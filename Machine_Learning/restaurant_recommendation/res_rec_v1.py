#%%
import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
from sklearn.metrics.pairwise import cosine_similarity as c_s
from sklearn.preprocessing import OneHotEncoder
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
import warnings
warnings.filterwarnings('ignore')

pd.options.display.max_columns = None
#%%
vectorizer = TfidfVectorizer()
onehotencoder = OneHotEncoder()
#%%
df = pd.read_csv(r'..\Machine_Learning\restaurant_recommendation\final_final_res.csv')
rating_final = pd.read_csv(r'..\Machine_Learning\restaurant_recommendation\final_final_ratings.csv')
# import os
#
# # Absolute path example
# file_path = r'E:\flutter_projects\taste-venture\Machine_Learning\restaurant_recommendation\final_final_res.csv'
# file_path2 = r'E:\flutter_projects\taste-venture\Machine_Learning\restaurant_recommendation\final_final_ratings.csv'
#
# # Check if the file exists
# if os.path.exists(file_path):
#     print("File exists")
# else:
#     print("File not found")
#
# # Load the file
# df = pd.read_csv(file_path)




#%%

# Step 1: Check which restaurants have multiple payment methods or multiple cuisines
multiple_payment_methods = df.groupby('placeID').filter(lambda x: x['Rpayment'].nunique() > 1)
multiple_cuisines = df.groupby('placeID').filter(lambda x: x['Rcuisine'].nunique() > 1)

# Step 2: One-hot encode the 'Rpayment' and 'Rcuisine' columns
payment_dummies = pd.get_dummies(df['Rpayment'], prefix='payment')
cuisine_dummies = pd.get_dummies(df['Rcuisine'], prefix='cuisine')

# Step 3: Concatenate the one-hot encoded columns to the original DataFrame
df_encoded = pd.concat([df, payment_dummies, cuisine_dummies], axis=1)

# Step 4: Drop the original 'Rpayment' and 'Rcuisine' columns as they are now encoded
df_encoded.drop(['Rpayment', 'Rcuisine'], axis=1, inplace=True)

# Step 5: Group the DataFrame by placeID and other relevant columns, then aggregate the payment and cuisine columns
df_grouped = df_encoded.groupby(
    ['placeID', 'parking_lot', 'latitude', 'longitude', 'name',
     'address', 'city', 'state', 'country', 'price', 'Rambience', 'area'],
    as_index=False
).max()

# Step 6: Display the final DataFrame with both payment and cuisine one-hot encoded and grouped
# df_grouped

# Step 7: (Optional) Check which restaurants had multiple payment methods or cuisines originally
multiple_payment_methods[['placeID', 'Rpayment']].drop_duplicates()
multiple_cuisines[['placeID', 'Rcuisine']].drop_duplicates()


#%%
# df_grouped.head()
#%%
# df_grouped.shape
#%%

#%%
# Define the transformer for restaurant features
restaurant_features = ColumnTransformer(
    transformers=[
        ('cuisine', OneHotEncoder(), ['cuisine_American','cuisine_Armenian','cuisine_Bakery','cuisine_Bar','cuisine_Bar_Pub_Brewery','cuisine_Breakfast-Brunch','cuisine_Burgers','cuisine_Cafe-Coffee_Shop',
                                      'cuisine_Cafeteria','cuisine_Chinese','cuisine_Contemporary','cuisine_Family','cuisine_Fast_Food','cuisine_Game','cuisine_International',
                                      'cuisine_Italian','cuisine_Japanese','cuisine_Mexican','cuisine_Pizzeria','cuisine_Regional','cuisine_Seafood','cuisine_Vietnamese']),
        ('payment', OneHotEncoder(), ['payment_American_Express', 'payment_Carte_Blanche', 'payment_MasterCard-Eurocard', 'payment_VISA',
                                      'payment_bank_debit_cards', 'payment_cash']),
        ('parking', OneHotEncoder(), ['parking_lot']),
        ('latitude', StandardScaler(), ['latitude']),
        ('longitude', StandardScaler(), ['longitude']),
        ('price', OneHotEncoder(), ['price']),
        ('area', OneHotEncoder(), ['area']),
        ('ambience', OneHotEncoder(), ['Rambience']),
        ('name', TfidfVectorizer(), 'name'),
        ('address', TfidfVectorizer(), 'address'),
        ('city', TfidfVectorizer(), 'city'),
        ('state', TfidfVectorizer(), 'state')
    ],
    remainder='drop'
)
#%%
restaurant_feature_matrix = restaurant_features.fit_transform(df_grouped)
restaurant_feature_matrix
#%%
def create_user_profile(user_id, ratings_df, restaurants_df, feature_matrix, min_rating=1):
    # Filter ratings for the specific user and only consider ratings >= min_rating
    user_ratings = ratings_df[(ratings_df['userID'] == user_id) & (ratings_df['rating'] >= min_rating)]

    # Get the restaurant indices that the user has rated
    rated_restaurant_ids = user_ratings['placeID'].tolist()
    rated_restaurant_indices = restaurants_df[restaurants_df['placeID'].isin(rated_restaurant_ids)].index.values.tolist()

    # Select the feature vectors for these restaurants
    rated_features = feature_matrix[rated_restaurant_indices].toarray()  # Convert to dense array if needed


    # Get the corresponding ratings and reshape them
    ratings = user_ratings['rating'].values.reshape(-1, 1)

    # Weight the features by the ratings
    weighted_features = rated_features * ratings

    # Calculate the user profile by averaging the weighted features
    user_profile = np.sum(weighted_features, axis=0) / np.sum(ratings)

    return user_profile

# Example: Create a user profile for user U1001
# user_profile = create_user_profile(1, rating_final, df_grouped, restaurant_feature_matrix)
# user_profile

#%%
user_profiles = {}

for user_id in rating_final['userID'].unique():
    user_profile = create_user_profile(user_id, rating_final, df_grouped, restaurant_feature_matrix)

    # Store the user profile in the dictionary
    user_profiles[user_id] = user_profile

user_profiles_df = pd.DataFrame(user_profiles).T

user_profiles_df.head()
#%%
from sklearn.metrics.pairwise import cosine_similarity

def calculate_similarity(user_vector, restaurant_features):
    return cosine_similarity(user_vector, restaurant_features)

#%%
def recommend(userid ,userProfile ,restaurant_feature_matrix ,top_n = 20):
    user = userProfile.loc[userid].values.reshape(1,-1)
    similarity = calculate_similarity(user ,restaurant_feature_matrix)
    top = similarity.argsort()[0][-top_n:][::-1]
    return df.iloc[top]
    # recommended_restaurants = df.iloc[top]

    # Drop duplicate restaurants based on 'placeID'
    # unique_recommendations = recommended_restaurants.drop_duplicates(subset='placeID')

    # return unique_recommendations
#%%
class RecommendationModel:
    def __init__(self, user_profiles, restaurant_features):
        self.user_profiles = user_profiles
        self.restaurant_features = restaurant_features

    def calculate_similarity(self, user_vector):
        return cosine_similarity(user_vector, self.restaurant_features)

    def recommend(self, user_id, top_n=30):
        user_vector = self.user_profiles.loc[user_id].values.reshape(1, -1)
        similarity = self.calculate_similarity(user_vector)

        top_indices = similarity.argsort()[0][-top_n:][::-1]
        # return df.iloc[top_indices]
        recommended_restaurants = df.iloc[top_indices]

        unique_recommendations = recommended_restaurants.drop_duplicates(subset='placeID')

        return unique_recommendations['placeID'].tolist()
#%%
rec_model = RecommendationModel(user_profiles_df, restaurant_feature_matrix)

# recommended_restaurants = recommendation_model.recommend(2)
# recommended_restaurants
#%%
import pickle

# Save the model
with open('rec_model.pkl', 'wb') as f:
    pickle.dump(rec_model, f)

# print("Model saved to trained_model.pkl")
#%%
# recommendation_model = RecommendationModel(user_profiles_df, restaurant_feature_matrix)

# recommended_restaurants = recommendation_model.recommend('U1067', top_n=5).drop_duplicates(subset='placeID')
# recommended_restaurants

#%%
# recommend('U1067' ,user_profiles_df ,restaurant_feature_matrix,5)
# #%%
# recommendations = recommend('U1067', user_profiles_df, restaurant_feature_matrix)
#
# # Ensure the results are unique based on 'placeID'
# unique_recommendations = recommendations.drop_duplicates(subset='placeID')
#
# # Display the unique recommendations
# unique_recommendations
#%%
# recommend('U1106' ,user_profiles_df ,restaurant_feature_matrix ,8)
