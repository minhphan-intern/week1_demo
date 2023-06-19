import psycopg2

conn = psycopg2.connect(
    host="192.168.22.11",
    database="bookstore",
    user="pm",
    password="pm",
    port = "5432"
)

cursor = conn.cursor()

cursor.execute("SELECT * FROM book LIMIT 10")

rows = cursor.fetchall()
print(len(rows))
for row in rows:
    print(row)

cursor.close()
conn.close()
