# Metalfish-OS
Metalfish OS - простая и быстрая операционная система

![GitHub top language](https://img.shields.io/github/languages/top/OkulusDev/Metalfish-OS)
![GitHub](https://img.shields.io/github/license/OkulusDev/Metalfish-OS)
![GitHub Repo stars](https://img.shields.io/github/stars/OkulusDev/Metalfish-OS)
![GitHub issues](https://img.shields.io/github/issues/OkulusDev/Metalfish-OS)

## Установка

Перед запуском, установите make, nasm, gcc

```bash
wget http://newos.org/toolchains/i386-elf-4.9.1-Linux-x86_64.tar.xz
sudo mkdir /usr/local/i386elfgcc
sudo tar -xf i386-elf-4.9.1-Linux-x86_64.tar.xz -C /usr/local/i386elfgcc --strip-components=1
export PATH=$PATH:/usr/local/i386elfgcc/bin

git clone https://github.com/OkulusDev/Metalfish-OS.git
cd Metalfish-OS
make build
make run
```

## Документация
Пользовательскую документацию можно получить по [этой ссылке](./docs/ru/index.md).

[Релизы программы]: https://github.com/OkulusDev/Oxygen/releases

## Поддержка
Если у вас возникли сложности или вопросы по использованию Metalfish OS, создайте 
[обсуждение](https://github.com/OkulusDev/Metalfish-OS/issues/new/choose) в данном репозитории или напишите на электронную почту <bro.alexeev@gmail.com>.

## Журнал апдейтов

 + 16.10.2023 - начало разработки
 + 28.10.2023 - создание бутсектора
 + 29.10.2023 - улучшение бутсектора и системы сборки
