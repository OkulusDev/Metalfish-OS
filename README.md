# Metalfish-OS

*Текущая версия - 0.11.16*

Metalfish OS - простая и быстрая операционная система

![GitHub top language](https://img.shields.io/github/languages/top/OkulusDev/Metalfish-OS)
![GitHub](https://img.shields.io/github/license/OkulusDev/Metalfish-OS)
![GitHub Repo stars](https://img.shields.io/github/stars/OkulusDev/Metalfish-OS)
![GitHub issues](https://img.shields.io/github/issues/OkulusDev/Metalfish-OS)

## Почему Metalfish OS?

Операционная система Metalfish OS была создана не для работы на компьютерах, и до релиза врядли она будет способна выполнять минимальные команды или программы. Мы не гарантируем, что она будет лучше чем DOS системы.

Metalfish OS создана как домашний проект, который дал бы мне (а может, и вам) знания о работе операционной системе, девайсов, основ программирования и Computer Science.

## Установка

Перед запуском, установите make, nasm, gcc

```bash
# Установка тулчейна (i386 elf gcc компилятор)
# При возникающих ошибках создайте issue
wget http://newos.org/toolchains/i386-elf-4.9.1-Linux-x86_64.tar.xz
sudo mkdir /usr/local/i386elfgcc
sudo tar -xf i386-elf-4.9.1-Linux-x86_64.tar.xz -C /usr/local/i386elfgcc --strip-components=1
export PATH=$PATH:/usr/local/i386elfgcc/bin

# Установка и компиляция
git clone https://github.com/OkulusDev/Metalfish-OS.git
cd Metalfish-OS
make build clean
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
 + 31.10.2023 - создание драйвера клавиатуры, прерывания
 + 01.11.2023 - улучшение документации, добавление разноцветного продвинутого вывода, улучшение эстетической состовляющей

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
 + 0.8.10 - изменение вывода сообщений в бутсекторе и ядре
 + 0.8.11 - изменение документации, readme, незначительный фикс
 + 0.9.11 - добавление прерываний, MetalShell, драйвера с клавиатуры, cpu, libc, улучшение документации и изменение Makefile (TODO: улучшить Makefile)
 + 0.10.11 - добавление malloc (инициализация указателей необходимым объемом памяти)
 + 0.10.12 - изменение цветов, документации, README файла
 + 0.10.13 - изменение документации
 + 0.10.14 - небольшие косметические улучшения
 + 0.11.14 - добавление функции для вывода текста различным цветом (TODO: добавить также с разным фоновым цветом), улучшение документации, незначительне изменения
 + 0.11.15 - документирование и комментирование кода
 + 0.11.16 - изменения цветов и улучшения вывода
