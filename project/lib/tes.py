list = [100, 200, 500, 80, 180]
list2 = [600, 550, 250, 75, 700]
hasil = 0
mean = 0
for value in list:
    mean += value
    nilai = (value - 212) ** 2
    print(nilai)
    hasil += nilai
print(mean / 5)
print(hasil / 5)
