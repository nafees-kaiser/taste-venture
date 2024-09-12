Map<String, List<Map<String, dynamic>>> menuGroupByCategory(List<Map<String, dynamic>> menuItems){
  Map<String, List<Map<String, dynamic>>> updatedMenu= {};
  
  for(var m in menuItems){
    if(updatedMenu[m['category']] == null){
      updatedMenu[m['category']] = [m];
    } else{
      updatedMenu[m['category']]!.add(m);
    } 
  }

  return updatedMenu;
}