import pickle
import re
import numpy as np
import fasttext


def get_restaurant_sentiment(review):
    fasttext_model = fasttext.load_model(r'..\Machine_Learning\food_review\cc.bn.300.bin')

    # Load the model
    with open(r'..\Machine_Learning\food_review\Restaurant_review_model.pkl', 'rb') as f:
        model = pickle.load(f)

    text = preprocess(review)
    text_embedding = text_to_embedding(text, fasttext_model)
    prediction = model.predict([text_embedding])
    print(prediction)

    return prediction


def preprocess(sentence):
    emoji_pattern = re.compile(
        "["
        "\U0001F600-\U0001F64F"  # Emoticons
        "\U0001F300-\U0001F5FF"  # Symbols & Pictographs
        "\U0001F680-\U0001F6FF"  # Transport & Map Symbols
        "\U0001F700-\U0001F77F"  # Alchemical Symbols
        "\U0001F780-\U0001F7FF"  # Geometric Shapes Extended
        "\U0001F800-\U0001F8FF"  # Supplemental Arrows-C
        "\U0001F900-\U0001F9FF"  # Supplemental Symbols and Pictographs
        "\U0001FA00-\U0001FA6F"  # Chess Symbols
        "\U0001FA70-\U0001FAFF"  # Symbols and Pictographs Extended-A
        "\U00002702-\U000027B0"  # Dingbats
        "\U000024C2-\U0001F251"
        "]+", flags=re.UNICODE
    )
    sentence = emoji_pattern.sub(r'', sentence)
    sentence = re.sub(r'\s*\n\s*', ' ', sentence)
    sentence = re.sub(r'\s+', ' ', sentence)
    sentence = re.sub(r'[#,।]', '', sentence)
    return sentence.strip().lower()


# Convert text to FastText embeddings
def text_to_embedding(text, model, embedding_dim=300):
    words = text.split()
    embeddings = [model.get_word_vector(word) for word in words if word in model]
    if embeddings:
        return np.mean(embeddings, axis=0)
    else:
        return np.zeros(embedding_dim)
