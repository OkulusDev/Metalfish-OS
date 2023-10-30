# Metalfish-OS

*Текущая версия - 0.8.8*

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
 + 30.10.2023 - улучшение бутсектора (загрузка диска, GDT) и создание ядра

## Журнал версий

 + 0.1.0 - создание репозитория
 + 0.1.1 - создание документации, системы сборки, архитектуры
 + 0.1.2 - рефакторинг
 + 0.2.2 - удаление ненужных и нестабильных файлов
 + 0.2.3 - улучшение документации, системы сборки, бутсектора
 + 0.3.3 - добавление teletype bios рутины
 + 0.4.3 - добавление функции вывода в бутсекторе, улучшение архитектуры путем перемещения бутсектора в отдельную папку boot/
 + 0.5.3 - добавление функции вывода шестнадцатиричного (HEX) текста, изменение кода бутсектора
 + 0.5.4 - улучшение документации и README файла
 + 0.5.5 - улучшение и добавление новых страниц в документации, фикс README файла
 + 0.6.5 - добавление функции чтения диска
 + 0.7.5 - добавление ядра на C
 + 0.7.6 - улучшение документации
 + 0.7.7 - улучшение документации, создание новых статей документации
 + 0.8.7 - добавление функционала ядра
 + 0.8.8 - улучшение кода, фикс незначительный ошибок, правки по кодстайлу, улучшение документации
 + 0.8.9 - улучшение README файла и файла ядра
