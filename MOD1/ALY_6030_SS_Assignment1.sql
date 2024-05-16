Use recipes;

Select * from categories; 
Select * from ingredients;
Select * from rec_ingredients;
Select * from recipe_main;

#INSERT Queries for All the tables

LOCK TABLES `categories` WRITE;
INSERT INTO `categories` VALUES (3,'Breakfast'),(4,'Drink');
UNLOCK TABLES;
Commit;

#verifying entries

Select * from `categories`;

LOCK TABLES `recipe_main` WRITE;
INSERT INTO `recipe_main` VALUES (3,'Poha',3,'Poha & Nuts',10,15,3,2,'Soak Poha flakes for a couple of minutes until they become soft but not mushy. Then, drain the water and set the poha aside. In a pan, heat some oil or ghee over medium heat. Add mustard seeds and let them splutter. Then, add cumin seeds, curry leaves, and chopped green chilies for added flavor. Sauté them for a minute or until they release their aroma. Next, add diced onions and sauté until they turn translucent and slightly golden brown. You can also add other vegetables like peas, carrots, or bell peppers at this stage if desired. Cook the vegetables until they become tender. Now,it is time to add the soaked poha to the pan. Gently mix it with the sautéed onions and vegetables, ensuring that the poha is evenly coated with the spices and vegetables. Season with salt, turmeric powder, and a pinch of sugar for a balanced taste. Stir everything well and cook for a few minutes until the flavors are well incorporated. Finally, garnish the Poha with freshly chopped coriander leaves and a squeeze of lemon juice for a tangy kick.')
,(4,'Lemonade',4,'Homemade Lemonade',5,10,4,1,'To make lemonade, start by juicing 4-6 large lemons to get the fresh lemon juice. In a pitcher, combine the lemon juice with 1 cup of granulated sugar, stirring until the sugar dissolves. Add 4 cups of cold water and stir well. Chill the lemonade in the refrigerator for 30 minutes. Serve over ice cubes and garnish with lemon slices and fresh mint leaves if desired. Enjoy your refreshing homemade lemonade!');
UNLOCK TABLES;
Commit;

#verifying entries for Added Recipe

Select * from `recipe_main`;

#Inserting Ingredients for the Dish

LOCK TABLES `ingredients` WRITE;
INSERT INTO `ingredients` VALUES (20,'flattened rice (poha)'),(21,'medium-sized onion, finely chopped'),(23,'green chilies'),(24,'cup of peanuts'),(25,'fresh coriander leaves, chopped')
,(26,'mustard seeds'),(27,'cumin seeds'),(28,'curry leaves'),(29,'turmeric powder'),(30,'Lemon Juice'),(31,'Cold Water'),(32,'Ice Cube')
,(33,'mint');
UNLOCK TABLES;
Commit;

Select * from `ingredients`;

LOCK TABLES `rec_ingredients` WRITE;
INSERT INTO `rec_ingredients` VALUES (17,3,0.30,20),(18,3,0.20,21),(19,3,0.05,23)
,(20,3,0.10,24),(21,3,0.25,25),(22,3,0.10,26),(23,3,0.05,27),(24,3,0.05,28)
,(25,3,0.15,29),(26,3,0.25,30),(27,3,0.25,15),(28,3,0.50,3),(29,4,1.00,31)
,(30,4,0.25,30),(31,4,0.10,32),(32,4,0.10,33),(33,4,0.50,11) ;
UNLOCK TABLES;
Commit;

Select * From `rec_ingredients`;


# 2. Join of all Tables to see the ingredients
Select c.category_name, rm.rec_title, rm.recipe_desc, rm.prep_time, rm.cook_time, rm.servings, rm.directions
, ing.ingred_name, ring.amount
From categories c inner join  recipe_main rm  on c.category_id =  rm.category_id
inner join `rec_ingredients` ring on rm.recipe_id  =  ring.recipe_id
inner join  `ingredients` ing on ring.ingredient_id = ing.ingredient_id
where rm.rec_title = 'Poha' or  rm.rec_title = 'Lemonade' ;

#3.Query that identifies the recipe name, category name, and ingredient name, and ingredient amount.
Select c.category_name, rm.rec_title, ing.ingred_name, ring.amount
From categories c inner join  recipe_main rm  on c.category_id =  rm.category_id
inner join `rec_ingredients` ring on rm.recipe_id  =  ring.recipe_id
inner join  `ingredients` ing on ring.ingredient_id = ing.ingredient_id
order by  c.category_name desc, rm.rec_title asc, ing.ingred_name desc;