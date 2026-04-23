"""
Скрипт для формирования кода по наполнению таблицы классов на основании именования графических представлений комбинаций
"""
import os
from datetime import datetime

folder_path = './projectwork/first_data' # текущая директория
files = os.listdir(folder_path)

with open('./projectwork/insert_class.sql', 'wt') as f:
    for file in files:
        items = file.split('_')
        dtime = datetime.strptime(items[2][:-5], "%Y-%m-%d %H-%M-%S")

        f.write(f"INSERT INTO class VALUES ('{items[1]}', '{dtime}', {1 if items[0] == 'BUY' else 0});\n")