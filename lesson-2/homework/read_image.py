import pyodbc
path ='D:\\image.jfif'

con = pyodbc.connect("DRIVER={SQL SERVER};SERVER=WIN-GD1UBBT42I9\\SQLEXPRESS;DATABASE=lesson2;Trusted_Connection=yes;")
cursor = con.cursor()

cursor.execute("SELECT * FROM photos;")
row = cursor.fetchone()
img_id, image_data = row

with open('output_image.jpg', 'wb') as f:
    f.write(image_data)

# I got syntax error due to using single backslash instead of double it appears one \ is escape character in python