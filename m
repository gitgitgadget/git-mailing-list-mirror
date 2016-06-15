From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 12/15] git-gui: initial version of russian translation
Date: Sun, 2 Sep 2007 17:36:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021736230.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1124202225-1188750999=:28586"
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:37:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsRz-0005zU-0b
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbXIBQhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbXIBQhW
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:37:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:51239 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964794AbXIBQhU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:37:20 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:37:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 02 Sep 2007 18:37:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CvGonNdQCLFxkaae4AkrGDe1g4CH6hySvRVOO3U
	ewxx4RadVxGw2M
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57360>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1124202225-1188750999=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


From: Irina Riesen <irina.riesen@gmail.com>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
Signed-off-by: Irina Riesen <irina.riesen@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/ru.po | 1480 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1480 insertions(+), 0 deletions(-)
 create mode 100644 po/ru.po

diff --git a/po/ru.po b/po/ru.po
new file mode 100644
index 0000000..c44d30a
--- /dev/null
+++ b/po/ru.po
@@ -0,0 +1,1480 @@
+# Translation of git-gui to russian
+# Copyright (C) 2007 Shawn Pearce
+# This file is distributed under the same license as the git-gui package.
+# Irina Riesen <irina.riesen@gmail.com>, 2007.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-07-27 19:33+0200\n"
+"PO-Revision-Date: 2007-07-28 18:30+0200\n"
+"Last-Translator: Irina Riesen <irina.riesen@gmail.com>\n"
+"Language-Team: Russian Translation <git@vger.kernel.org>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: git-gui.sh:531
+msgid "Cannot find git in PATH."
+msgstr "git не найден в PATH."
+
+#: git-gui.sh:550
+msgid "Cannot parse Git version string:"
+msgstr ""
+"Невозможно распознать строку версии Git: "
+
+#: git-gui.sh:567
+#, tcl-format
+msgid ""
+"Git version cannot be determined.\n"
+"\n"
+"%s claims it is version '%s'.\n"
+"\n"
+"%s requires at least Git 1.5.0 or later.\n"
+"\n"
+"Assume '%s' is version 1.5.0?\n"
+msgstr ""
+
+#: git-gui.sh:689
+msgid "Cannot find the git directory:"
+msgstr "Каталог Git не найден:"
+
+#: git-gui.sh:697
+msgid "Git directory not found:"
+msgstr "Каталог Git не найден:"
+
+#: git-gui.sh:703
+msgid "Cannot use funny .git directory:"
+msgstr "Каталог.git испорчен: "
+
+#: git-gui.sh:708
+msgid "No working directory"
+msgstr "Отсутствует рабочий каталог"
+
+#: git-gui.sh:853
+msgid "Refreshing file status..."
+msgstr "Обновление состояния файлов проекта..."
+
+#: git-gui.sh:886
+msgid "Scanning for modified files ..."
+msgstr "Поиск измененных файлов..."
+
+#: git-gui.sh:1052 lib/browser.tcl:233
+msgid "Ready."
+msgstr "Готово."
+
+#: git-gui.sh:1343
+msgid "Unmodified"
+msgstr "Не изменено"
+
+#: git-gui.sh:1345
+msgid "Modified, not staged"
+msgstr "Изменено, но не включено"
+
+#: git-gui.sh:1346 git-gui.sh:1351
+msgid "Staged for commit"
+msgstr "Подготовлено для сохранения"
+
+#: git-gui.sh:1347 git-gui.sh:1352
+msgid "Portions staged for commit"
+msgstr "Части, подготовленные для сохранения"
+
+#: git-gui.sh:1348 git-gui.sh:1353
+#, fuzzy
+msgid "Staged for commit, missing"
+msgstr ""
+"Подготовлено для сохранения, отсутствует"
+
+#: git-gui.sh:1350
+msgid "Untracked, not staged"
+msgstr "Не отслеживается, не подготовлено"
+
+#: git-gui.sh:1355
+msgid "Missing"
+msgstr "Отсутствует"
+
+#: git-gui.sh:1356
+msgid "Staged for removal"
+msgstr "Подготовлено для удаления"
+
+#: git-gui.sh:1357
+msgid "Staged for removal, still present"
+msgstr ""
+"Подготовлено для удаления, но еще не "
+"удалено"
+
+#: git-gui.sh:1359 git-gui.sh:1360 git-gui.sh:1361 git-gui.sh:1362
+msgid "Requires merge resolution"
+msgstr ""
+"Требуется разрешение конфликта при "
+"объединении"
+
+#: git-gui.sh:1404
+msgid "Starting gitk... please wait..."
+msgstr "Запускается gitk... пожалуйста, ждите..."
+
+#: git-gui.sh:1413
+#, tcl-format
+msgid ""
+"Unable to start gitk:\n"
+"\n"
+"%s does not exist"
+msgstr ""
+"Не удалось запустить gitk:\n"
+"\n"
+"%s не существует"
+
+#: git-gui.sh:1630
+#, tcl-format
+msgid "Invalid font specified in gui.%s:"
+msgstr ""
+"В оболочке установлен неверный шрифт.%s:"
+
+#: git-gui.sh:1655
+msgid "Main Font"
+msgstr "Шрифт интерфейса"
+
+#: git-gui.sh:1656
+msgid "Diff/Console Font"
+msgstr "Шрифт в консоли diff"
+
+#: git-gui.sh:1670
+msgid "Repository"
+msgstr "Репозиторий"
+
+#: git-gui.sh:1671
+msgid "Edit"
+msgstr "Редактировать"
+
+#: git-gui.sh:1673
+msgid "Branch"
+msgstr "Ветвь"
+
+#: git-gui.sh:1676 git-gui.sh:1854 git-gui.sh:2193
+msgid "Commit"
+msgstr "Сохранить"
+
+#: git-gui.sh:1679 lib/merge.tcl:96 lib/merge.tcl:157 lib/merge.tcl:173
+msgid "Merge"
+msgstr "Объединить"
+
+#: git-gui.sh:1680
+msgid "Fetch"
+msgstr "Получить"
+
+#: git-gui.sh:1681 git-gui.sh:2199 lib/transport.tcl:88 lib/transport.tcl:172
+msgid "Push"
+msgstr "Отправить"
+
+#: git-gui.sh:1690
+msgid "Browse Current Branch's Files"
+msgstr "Просмотреть файлы текущей ветви"
+
+#: git-gui.sh:1692
+#, fuzzy, tcl-format
+msgid "Browse %s's Files"
+msgstr "Показать файлы ветви"
+
+#: git-gui.sh:1694
+#, fuzzy
+msgid "Browse Branch Files..."
+msgstr "Показать файлы ветви"
+
+#: git-gui.sh:1699
+msgid "Visualize Current Branch's History"
+msgstr "История текущей ветви наглядно"
+
+#: git-gui.sh:1701
+#, fuzzy, tcl-format
+msgid "Visualize %s's History"
+msgstr "История всех ветвей наглядно"
+
+#: git-gui.sh:1703
+msgid "Visualize All Branch History"
+msgstr "История всех ветвей наглядно"
+
+#: git-gui.sh:1708 lib/database.tcl:27 lib/database.tcl:67
+msgid "Database Statistics"
+msgstr "Статистика базы данных"
+
+#: git-gui.sh:1711 lib/database.tcl:34
+msgid "Compress Database"
+msgstr "Сжать базу данных"
+
+#: git-gui.sh:1714
+msgid "Verify Database"
+msgstr "Проверить базу данных"
+
+#: git-gui.sh:1721 git-gui.sh:1725 git-gui.sh:1729 lib/shortcut.tcl:9
+#: lib/shortcut.tcl:45 lib/shortcut.tcl:84
+msgid "Create Desktop Icon"
+msgstr "Создать ярлык на рабочем столе"
+
+#: git-gui.sh:1734
+msgid "Quit"
+msgstr "Выход"
+
+#: git-gui.sh:1741
+msgid "Undo"
+msgstr "Отменить"
+
+#: git-gui.sh:1744
+msgid "Redo"
+msgstr "Повторить"
+
+#: git-gui.sh:1748 git-gui.sh:2263
+msgid "Cut"
+msgstr "Вырезать"
+
+#: git-gui.sh:1751 git-gui.sh:2266 git-gui.sh:2337 git-gui.sh:2409
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr "Копировать"
+
+#: git-gui.sh:1754 git-gui.sh:2269
+msgid "Paste"
+msgstr "Вставить"
+
+#: git-gui.sh:1757 git-gui.sh:2272 lib/branch_delete.tcl:26
+#: lib/remote_branch_delete.tcl:38
+msgid "Delete"
+msgstr "Удалить"
+
+#: git-gui.sh:1761 git-gui.sh:2276 git-gui.sh:2413 lib/console.tcl:71
+msgid "Select All"
+msgstr "Выделить все"
+
+#: git-gui.sh:1770
+msgid "Create..."
+msgstr "Создать..."
+
+#: git-gui.sh:1776
+msgid "Checkout..."
+msgstr "Перейти..."
+
+#: git-gui.sh:1782
+msgid "Rename..."
+msgstr "Переименовать..."
+
+#: git-gui.sh:1787 git-gui.sh:1885
+msgid "Delete..."
+msgstr "Удалить..."
+
+#: git-gui.sh:1792
+msgid "Reset..."
+msgstr "Сбросить..."
+
+#: git-gui.sh:1804 git-gui.sh:2210
+msgid "New Commit"
+msgstr "Новое состояние"
+
+#: git-gui.sh:1812 git-gui.sh:2217
+msgid "Amend Last Commit"
+msgstr "Исправить последнее состояние"
+
+#: git-gui.sh:1821 git-gui.sh:2177 lib/remote_branch_delete.tcl:99
+msgid "Rescan"
+msgstr "Перечитать"
+
+#: git-gui.sh:1827
+msgid "Add To Commit"
+msgstr "Подготовить к сохранению"
+
+#: git-gui.sh:1832
+msgid "Add Existing To Commit"
+msgstr ""
+"Подготовить имеющиеся файлы к сохранению"
+
+#: git-gui.sh:1838
+msgid "Unstage From Commit"
+msgstr "Убрать из подготовленного"
+
+#: git-gui.sh:1843 lib/index.tcl:376
+msgid "Revert Changes"
+msgstr "Отменить изменения"
+
+#: git-gui.sh:1850 git-gui.sh:2189 git-gui.sh:2287
+msgid "Sign Off"
+msgstr "Подписать"
+
+#: git-gui.sh:1865
+msgid "Local Merge..."
+msgstr "Локальное объединение..."
+
+#: git-gui.sh:1870
+msgid "Abort Merge..."
+msgstr "Прервать объединение..."
+
+#: git-gui.sh:1882
+msgid "Push..."
+msgstr "Отправить..."
+
+#: git-gui.sh:1892
+msgid "Apple"
+msgstr ""
+
+#: git-gui.sh:1895 git-gui.sh:1942 lib/option.tcl:65
+#, tcl-format
+msgid "About %s"
+msgstr "О %s"
+
+#: git-gui.sh:1897 git-gui.sh:1903 git-gui.sh:2455
+msgid "Options..."
+msgstr "Настройки..."
+
+#: git-gui.sh:1917
+msgid "Running miga..."
+msgstr ""
+
+#: git-gui.sh:1938
+msgid "Help"
+msgstr "Помощь"
+
+#: git-gui.sh:1979
+msgid "Online Documentation"
+msgstr "Документация в интернете"
+
+#: git-gui.sh:2095
+msgid "Current Branch:"
+msgstr "Текущая ветвь:"
+
+#: git-gui.sh:2116
+msgid "Staged Changes (Will Be Committed)"
+msgstr "Подготовлено (будет сохранено)"
+
+#: git-gui.sh:2136
+msgid "Unstaged Changes (Will Not Be Committed)"
+msgstr "Изменено (не будет сохранено)"
+
+#: git-gui.sh:2183
+msgid "Add Existing"
+msgstr "Добавить имеющиеся файлы"
+
+#: git-gui.sh:2229
+#, fuzzy
+msgid "Initial Commit Message:"
+msgstr ""
+"Первоначальный комментарий к состоянию:"
+
+#: git-gui.sh:2230
+#, fuzzy
+msgid "Amended Commit Message:"
+msgstr "Исправленный комментарий к состоянию:"
+
+#: git-gui.sh:2231
+#, fuzzy
+msgid "Amended Initial Commit Message:"
+msgstr ""
+"Первоначальный комментарий к "
+"исправленному состоянию:"
+
+#: git-gui.sh:2232
+#, fuzzy
+msgid "Amended Merge Commit Message:"
+msgstr ""
+"Комментарий к исправленному объединению:"
+
+#: git-gui.sh:2233
+msgid "Merge Commit Message:"
+msgstr "Комментарий к объединению:"
+
+#: git-gui.sh:2234
+msgid "Commit Message:"
+msgstr "Комментарий к состоянию:"
+
+#: git-gui.sh:2279 git-gui.sh:2417 lib/console.tcl:73
+msgid "Copy All"
+msgstr "Копировать все"
+
+#: git-gui.sh:2303 lib/blame.tcl:104
+msgid "File:"
+msgstr "Файл:"
+
+#: git-gui.sh:2405
+msgid "Refresh"
+msgstr "Обновить"
+
+#: git-gui.sh:2426
+msgid "Apply/Reverse Hunk"
+msgstr "Применить/Убрать изменение"
+
+#: git-gui.sh:2432
+msgid "Decrease Font Size"
+msgstr "Уменьшить размер шрифта"
+
+#: git-gui.sh:2436
+msgid "Increase Font Size"
+msgstr "Увеличить размер шрифта"
+
+#: git-gui.sh:2441
+msgid "Show Less Context"
+msgstr "Меньше контекста"
+
+#: git-gui.sh:2448
+msgid "Show More Context"
+msgstr "Больше контекста"
+
+#: git-gui.sh:2461
+msgid "Unstage Hunk From Commit"
+msgstr "Не сохранять часть"
+
+#: git-gui.sh:2463
+msgid "Stage Hunk For Commit"
+msgstr "Подготовить часть для сохранения"
+
+#: git-gui.sh:2473
+msgid "Initializing..."
+msgstr "Инициализация..."
+
+#: lib/blame.tcl:77
+msgid "File Viewer"
+msgstr "Просмотр файла"
+
+#: lib/blame.tcl:81
+msgid "Commit:"
+msgstr "Сохраненное состояние:"
+
+#: lib/blame.tcl:249
+msgid "Copy Commit"
+msgstr "Копировать сохраненное состояние"
+
+#: lib/blame.tcl:369
+#, tcl-format
+msgid "Reading %s..."
+msgstr "Чтение %s..."
+
+#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+msgid "Checkout Branch"
+msgstr "Перейти на ветвь"
+
+#: lib/branch_checkout.tcl:23
+msgid "Checkout"
+msgstr "Перейти"
+
+#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
+#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:269
+#: lib/checkout_op.tcl:519 lib/merge.tcl:176 lib/option.tcl:172
+#: lib/remote_branch_delete.tcl:42 lib/transport.tcl:92
+msgid "Cancel"
+msgstr "Отменить"
+
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:274
+msgid "Revision"
+msgstr "Версия"
+
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:159
+#: lib/option.tcl:274
+msgid "Options"
+msgstr "Настройки"
+
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "Получить изменения из внешней ветви"
+
+#: lib/branch_checkout.tcl:44
+msgid "Detach From Local Branch"
+msgstr "Отсоединить от локальной ветви"
+
+#: lib/branch_create.tcl:22
+msgid "Create Branch"
+msgstr "Создание ветви"
+
+#: lib/branch_create.tcl:27
+msgid "Create New Branch"
+msgstr "Создать новую ветвь"
+
+#: lib/branch_create.tcl:31
+msgid "Create"
+msgstr "Создать"
+
+#: lib/branch_create.tcl:40
+msgid "Branch Name"
+msgstr "Название ветви"
+
+#: lib/branch_create.tcl:43
+msgid "Name:"
+msgstr "Название:"
+
+#: lib/branch_create.tcl:58
+msgid "Match Tracking Branch Name"
+msgstr "Взять из имен ветвей слежения"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "Начальная версия"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "Обновить имеющуюся ветвь:"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "Нет"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "Только Fast Forward"
+
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:511
+msgid "Reset"
+msgstr "Сброс"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "После создания сделать текущей"
+
+#: lib/branch_create.tcl:131
+msgid "Please select a tracking branch."
+msgstr "Укажите ветвь слежения."
+
+#: lib/branch_create.tcl:140
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr ""
+"Ветвь слежения %s не является ветвью во "
+"внешнем репозитории."
+
+#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+msgid "Please supply a branch name."
+msgstr "Укажите название ветви."
+
+#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "Недопустимое название ветви '%s'."
+
+#: lib/branch_delete.tcl:15
+msgid "Delete Branch"
+msgstr "Удаление ветви"
+
+#: lib/branch_delete.tcl:20
+msgid "Delete Local Branch"
+msgstr "Удалить локальную ветвь"
+
+#: lib/branch_delete.tcl:37
+msgid "Local Branches"
+msgstr "Локальные ветви"
+
+#: lib/branch_delete.tcl:52
+msgid "Delete Only If Merged Into"
+msgstr ""
+"Удалить только в случае, если было "
+"объединение с"
+
+#: lib/branch_delete.tcl:54
+msgid "Always (Do not perform merge test.)"
+msgstr ""
+"Всегда (не выполнять проверку на "
+"объединение)"
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr ""
+"Следующие ветви объединены с %s не "
+"полностью:"
+
+#: lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult. \n"
+"\n"
+" Delete the selected branches?"
+msgstr ""
+"Восстановить удаленную ветвь сложно. \n"
+"\n"
+" Удалить выбранные ветви?"
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"Не удалось удалить ветви:\n"
+"%s"
+
+#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+msgid "Rename Branch"
+msgstr "Переименование ветви"
+
+#: lib/branch_rename.tcl:26
+msgid "Rename"
+msgstr "Переименовать"
+
+#: lib/branch_rename.tcl:36
+msgid "Branch:"
+msgstr "Ветвь:"
+
+#: lib/branch_rename.tcl:39
+msgid "New Name:"
+msgstr "Новое название:"
+
+#: lib/branch_rename.tcl:75
+msgid "Please select a branch to rename."
+msgstr "Укажите ветвь для переименования."
+
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "Ветвь '%s' уже существует."
+
+#: lib/branch_rename.tcl:117
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Не удалось переименовать '%s'. "
+
+#: lib/browser.tcl:10
+msgid "Starting..."
+msgstr "Запуск..."
+
+#: lib/browser.tcl:19
+msgid "File Browser"
+msgstr "Просмотр списка файлов"
+
+#: lib/browser.tcl:120 lib/browser.tcl:137
+#, tcl-format
+msgid "Loading %s..."
+msgstr "Загрузка %s..."
+
+#: lib/browser.tcl:254 lib/browser.tcl:260
+msgid "Browse Branch Files"
+msgstr "Показать файлы ветви"
+
+#: lib/browser.tcl:265
+msgid "Browse"
+msgstr "Показать"
+
+#: lib/checkout_op.tcl:79
+#, fuzzy, tcl-format
+msgid "Fetching %s from %s"
+msgstr "Получение изменений из %s "
+
+#: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
+msgid "Close"
+msgstr "Закрыть"
+
+#: lib/checkout_op.tcl:169
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "Ветвь '%s' не существует "
+
+#: lib/checkout_op.tcl:205
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+"Ветвь '%s' уже существует.\n"
+"\n"
+"Она не может быть прокручена(fast-forward) к %s.\n"
+"Требуется объединение."
+
+#: lib/checkout_op.tcl:219
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr ""
+"Операция объединения '%s' не "
+"поддерживается."
+
+#: lib/checkout_op.tcl:238
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr "Не удалось обновить '%s'."
+
+#: lib/checkout_op.tcl:250
+msgid "Index is already locked."
+msgstr "Индекс заблокирован."
+
+#: lib/checkout_op.tcl:265
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before the current branch can be changed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Последнее прочитанное состояние "
+"репозитория не соответствует текущему.\n"
+"\n"
+"С момента последней проверки репозиторий "
+"был изменен другой программой "
+"Git.Необходимо перечитать репозиторий, "
+"прежде чем изменять текущую ветвь. \n"
+"\n"
+"Это будет сделано сейчас автоматически.\n"
+
+#: lib/checkout_op.tcl:352
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr ""
+"Прерван переход на '%s' (требуется "
+"объединение на уровне файлов)"
+
+#: lib/checkout_op.tcl:353
+msgid "File level merge required."
+msgstr ""
+"Требуется объединение на уровне файлов."
+
+#: lib/checkout_op.tcl:357
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr "Ветвь '%s' остается текущей."
+
+#: lib/checkout_op.tcl:426
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This Detached "
+"Checkout'."
+msgstr ""
+"Вы находитесь не в локальной ветви.\n"
+"\n"
+"Если вы хотите снова вернуться к "
+"какой-нибудь ветви, создайте ее сейчас, "
+"начиная с 'Текущего отсоединенного "
+"состояния'."
+
+#: lib/checkout_op.tcl:475
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr ""
+"Сброс '%s' в '%s' приведет к потере следующих "
+"сохраненных состояний: "
+
+#: lib/checkout_op.tcl:497
+msgid "Recovering lost commits may not be easy."
+msgstr ""
+"Восстановить потерянные сохраненные "
+"состояния будет сложно."
+
+#: lib/checkout_op.tcl:502
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr "Сбросить '%s'?"
+
+#: lib/checkout_op.tcl:507 lib/merge.tcl:171
+msgid "Visualize"
+msgstr "Наглядно"
+
+#: lib/checkout_op.tcl:575
+#, tcl-format
+msgid ""
+"Failed to set current branch.\n"
+"\n"
+"This working directory is only partially switched.  We successfully updated "
+"your files, but failed to update an internal Git file.\n"
+"\n"
+"This should not have occurred.  %s will now close and give up."
+msgstr ""
+"Не удалось установить текущую ветвь.\n"
+"\n"
+"Ваш рабочий каталог обновлен только "
+"частично. Были обновлены все файлы кроме "
+"служебных файлов Git. \n"
+"\n"
+"Этого не должно было произойти. %s "
+"завершается."
+
+#: lib/choose_rev.tcl:35
+msgid "This Detached Checkout"
+msgstr "Текущее отсоединенное состояние"
+
+#: lib/choose_rev.tcl:42
+msgid "Revision Expression:"
+msgstr "Выражение для определения версии:"
+
+#: lib/choose_rev.tcl:56
+msgid "Local Branch"
+msgstr "Локальная ветвь:"
+
+#: lib/choose_rev.tcl:61
+msgid "Tracking Branch"
+msgstr "Ветвь слежения"
+
+#: lib/choose_rev.tcl:66
+msgid "Tag"
+msgstr "Метка"
+
+#: lib/choose_rev.tcl:227
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Неверная версия: %s"
+
+#: lib/choose_rev.tcl:248
+msgid "No revision selected."
+msgstr "Версия не указана."
+
+#: lib/choose_rev.tcl:256
+msgid "Revision expression is empty."
+msgstr ""
+"Пустое выражения для определения версии."
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
+msgstr ""
+"Отсутствует состояние для исправления.\n"
+"\n"
+"Вы можете создать начальное сохраненное "
+"состояние. Других состояний для "
+"исправления нет.\n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
+msgstr ""
+"Невозможно исправить состояние во время "
+"объединения.\n"
+"\n"
+"Текущее объединение не завершено. "
+"Невозможно исправить предыдущее "
+"сохраненное состояние не прерывая "
+"текущее объединение.\n"
+
+#: lib/commit.tcl:49
+msgid "Error loading commit data for amend:"
+msgstr ""
+"Ошибка при загрузке данных для "
+"исправления сохраненного состояния:"
+
+#: lib/commit.tcl:76
+msgid "Unable to obtain your identity:"
+msgstr ""
+"Невозможно получить информацию об "
+"авторстве:"
+
+#: lib/commit.tcl:81
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "Неверная GIT_COMMITTER_IDENT:"
+
+#: lib/commit.tcl:133
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Последнее прочитанное состояние "
+"репозитория не соответствует текущему.\n"
+"\n"
+"С момента последней проверки репозиторий "
+"был изменен другой программой "
+"Git.Необходимо перечитать репозиторий, "
+"прежде чем изменять текущую ветвь. \n"
+"\n"
+"Это будет сделано сейчас автоматически.\n"
+
+#: lib/commit.tcl:154
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and add the file before "
+"committing.\n"
+msgstr ""
+"Нельзя сохранить необъединенные файлы.\n"
+"\n"
+"Для файла %s возник конфликт объединения. "
+"Разрешите конфликт и добавьте к "
+"подготовленным файлам перед "
+"сохранением.\n"
+
+#: lib/commit.tcl:162
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"Обнаружено неизвестное состояние файла "
+"%s.\n"
+"\n"
+"Файл %s не может быть сохранен данной "
+"программой.\n"
+
+#: lib/commit.tcl:170
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must add at least 1 file before you can commit.\n"
+msgstr ""
+"Отсутствуют изменения для сохранения.\n"
+"\n"
+"Подготовьте хотя бы один файл до создания "
+"сохраненного состояния.\n"
+
+#: lib/commit.tcl:183
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentance what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr ""
+"Напишите комментарий к сохраненному "
+"состоянию.\n"
+"\n"
+"Рекомендуется следующий формат "
+"комментария:\n"
+"\n"
+"- первая строка: краткое описание "
+"сделанных изменений.\n"
+"- вторая строка пустая\n"
+"- оставшиеся строки: опишите, что дают "
+"ваши изменения.\n"
+
+#: lib/commit.tcl:257
+msgid "write-tree failed:"
+msgstr ""
+"Программа write-tree завершилась с ошибкой:"
+
+#: lib/commit.tcl:279
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"Отсутствуют изменения для сохранения.\n"
+"\n"
+"Ни один файл не был изменен и не было "
+"объединения.\n"
+"\n"
+"Сейчас автоматически запустится "
+"перечитывание репозитория.\n"
+
+#: lib/commit.tcl:286
+msgid "No changes to commit."
+msgstr "Отуствуют измения для сохранения."
+
+#: lib/commit.tcl:317
+msgid "commit-tree failed:"
+msgstr ""
+"Программа commit-tree завершилась с ошибкой:"
+
+#: lib/commit.tcl:339
+msgid "update-ref failed:"
+msgstr ""
+"Программа update-ref завершилась с ошибкой:"
+
+#: lib/commit.tcl:430
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "Создано состояние %s: %s "
+
+#: lib/console.tcl:55
+msgid "Working... please wait..."
+msgstr "В процессе... пожалуйста, ждите..."
+
+#: lib/console.tcl:184
+msgid "Success"
+msgstr "Процесс успешно завершен"
+
+#: lib/console.tcl:194
+msgid "Error: Command Failed"
+msgstr "Ошибка: не удалось выполнить команду"
+
+#: lib/database.tcl:43
+msgid "Number of loose objects"
+msgstr "Количество несвязанных объектов"
+
+#: lib/database.tcl:44
+msgid "Disk space used by loose objects"
+msgstr ""
+"Объем дискового пространства, занятый "
+"несвязанными объектами"
+
+#: lib/database.tcl:45
+msgid "Number of packed objects"
+msgstr "Количество упакованных объектов"
+
+#: lib/database.tcl:46
+msgid "Number of packs"
+msgstr "Количество pack-файлов"
+
+#: lib/database.tcl:47
+msgid "Disk space used by packed objects"
+msgstr ""
+"Объем дискового пространства, занятый "
+"упакованными объектами"
+
+#: lib/database.tcl:48
+msgid "Packed objects waiting for pruning"
+msgstr ""
+"Несвязанные объекты, которые можно "
+"удалить"
+
+#: lib/database.tcl:49
+msgid "Garbage files"
+msgstr "Мусор"
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "Сжатие базы объектов"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "Проверка базы объектов при помощи fsck"
+
+#: lib/diff.tcl:42
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may have "
+"the same state."
+msgstr ""
+"Изменений не обнаружено.\n"
+"\n"
+"в %s отутствуют изменения.\n"
+"\n"
+"Дата изменения файла была обновлена "
+"другой программой, но содержимое файла "
+"осталось прежним.\n"
+"\n"
+"Сейчас будет запущено перечитывание "
+"репозитория, чтобы найти подобные файлы."
+
+#: lib/diff.tcl:97
+msgid "Error loading file:"
+msgstr "Ошибка загрузки файла:"
+
+#: lib/diff.tcl:162
+msgid "Error loading diff:"
+msgstr "Ошибка загрузки diff:"
+
+#: lib/diff.tcl:278
+msgid "Failed to unstage selected hunk."
+msgstr "Не удалось исключить выбранную часть"
+
+#: lib/diff.tcl:285
+msgid "Failed to stage selected hunk."
+msgstr ""
+"Не удалось подготовить к сохранению "
+"выбранную часть"
+
+#: lib/error.tcl:12 lib/error.tcl:102
+msgid "error"
+msgstr "ошибка"
+
+#: lib/error.tcl:28
+msgid "warning"
+msgstr "предупреждение"
+
+#: lib/error.tcl:81
+msgid "You must correct the above errors before committing."
+msgstr ""
+"Прежде чем сохранить, исправьте "
+"вышеуказанные ошибки."
+
+#: lib/index.tcl:364
+#, fuzzy, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "Отменить изменения"
+
+#: lib/index.tcl:366
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr "Отменить изменения в %i файле(-ах)?"
+
+#: lib/index.tcl:372
+#, fuzzy
+msgid "Any unadded changes will be permanently lost by the revert."
+msgstr ""
+"Отменить изменения в %s?\n"
+"\n"
+"Любые изменения, не подготовленные к "
+"сохранению, будут потеряны при данной "
+"операции."
+
+#: lib/index.tcl:375
+msgid "Do Nothing"
+msgstr "Ничего не делать"
+
+#: lib/merge.tcl:14
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr ""
+"Невозможно выполнить объединение во "
+"время исправления.\n"
+"\n"
+"Завершите исправление данного состояния "
+"перед выполнением операции объединения.\n"
+
+#: lib/merge.tcl:28
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Последнее прочитанное состояние "
+"репозитория не соответствует текущему.\n"
+"\n"
+"С момента последней проверки репозиторий "
+"был изменен другой программой "
+"Git.Необходимо перечитать репозиторий, "
+"прежде чем изменять текущую ветвь. \n"
+"\n"
+"Это будет сделано сейчас автоматически.\n"
+
+#: lib/merge.tcl:45
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, add the file, and commit to complete the current "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+"Предыдущее объединение не завершено "
+"из-за конфликта.\n"
+"\n"
+"Для файла %s возник конфликт объединения.\n"
+"Разрешите конфликт, подготовьте файл и "
+"сохраните. Только после этого можно "
+"начать следующее объединение.\n"
+
+#: lib/merge.tcl:55
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doing so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+"Изменения не сохранены.\n"
+"\n"
+"Файл  %s изменен.\n"
+"\n"
+"Подготовьте и сохраните измения перед "
+"началом объединения. В случае "
+"необходимости это позволит прервать "
+"операцию объединения.\n"
+
+#: lib/merge.tcl:94
+#, tcl-format
+msgid "Merging %s and %s"
+msgstr "Объединение %s и %s"
+
+#: lib/merge.tcl:106
+msgid "Merge completed successfully."
+msgstr "Объединение успешно завершено."
+
+#: lib/merge.tcl:108
+msgid "Merge failed.  Conflict resolution is required."
+msgstr ""
+"Не удалось завершить объединение. "
+"Требуется разрешение конфликта."
+
+#: lib/merge.tcl:166
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "Объединить с %s"
+
+#: lib/merge.tcl:181 lib/transport.tcl:98
+msgid "Source Branches"
+msgstr "Исходные ветви"
+
+#: lib/merge.tcl:240
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"Невозможно прервать исправление.\n"
+"\n"
+"Завершите текущее исправление "
+"сохраненного состояния.\n"
+
+#: lib/merge.tcl:250
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"Прервать объединение?\n"
+"Прерывание объединения приведет к потере "
+"*ВСЕХ* несохраненных изменений.\n"
+"\n"
+"Продолжить?"
+
+#: lib/merge.tcl:256
+msgid ""
+"Abort commit?\n"
+"\n"
+"Aborting the current commit will cause *ALL* uncommitted changes to be "
+"lost.\n"
+"\n"
+"Continue with aborting the current commit?"
+msgstr ""
+"Отменить изменения?\n"
+"\n"
+"Вызванная операция приведет к потере "
+"*ВСЕХ* несохраненных изменений.\n"
+"\n"
+"Продолжить?"
+
+#: lib/merge.tcl:267
+msgid "Aborting... please wait..."
+msgstr ""
+"Прерывание выполнения... Пожалуйста, "
+"ждите..."
+
+#: lib/merge.tcl:290
+msgid "Abort completed.  Ready."
+msgstr "Прервано."
+
+#: lib/option.tcl:77
+msgid "git-gui - a graphical user interface for Git."
+msgstr ""
+"git-gui - графический пользовательский "
+"интерфейс к Git."
+
+#: lib/option.tcl:164
+msgid "Restore Defaults"
+msgstr "Восстановить настройки по умолчанию"
+
+#: lib/option.tcl:168
+msgid "Save"
+msgstr "Сохранить"
+
+#: lib/option.tcl:178
+#, tcl-format
+msgid "%s Repository"
+msgstr "для репозитория %s "
+
+#: lib/option.tcl:179
+msgid "Global (All Repositories)"
+msgstr "Общие (для всех репозиториев)"
+
+#: lib/option.tcl:185
+msgid "User Name"
+msgstr "Имя пользователя"
+
+#: lib/option.tcl:186
+msgid "Email Address"
+msgstr "Адес электронной почты"
+
+#: lib/option.tcl:188
+msgid "Summarize Merge Commits"
+msgstr ""
+"Суммарный комментарий при объединении"
+
+#: lib/option.tcl:189
+msgid "Merge Verbosity"
+msgstr ""
+"Уровень детальности сообщений при "
+"объединении"
+
+#: lib/option.tcl:190
+msgid "Show Diffstat After Merge"
+msgstr ""
+"Показать отчет об изменениях после "
+"объединения"
+
+#: lib/option.tcl:192
+msgid "Trust File Modification Timestamps"
+msgstr "Доверять времени модификации файла"
+
+#: lib/option.tcl:193
+msgid "Prune Tracking Branches During Fetch"
+msgstr ""
+"Чистка ветвей слежения при получении "
+"изменений"
+
+#: lib/option.tcl:194
+msgid "Match Tracking Branches"
+msgstr ""
+"Имя новой ветви взять из имен ветвей "
+"слежения"
+
+#: lib/option.tcl:195
+msgid "Number of Diff Context Lines"
+msgstr "Число строк в контексте diff"
+
+#: lib/option.tcl:196
+msgid "New Branch Name Template"
+msgstr "Шаблон для имени новой ветви"
+
+#: lib/option.tcl:305
+msgid "Failed to completely save options:"
+msgstr ""
+"Не удалось полностью сохранить настройки:"
+
+#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+msgid "Delete Remote Branch"
+msgstr "Удалить внешнюю ветвь"
+
+#: lib/remote_branch_delete.tcl:47
+msgid "From Repository"
+msgstr "Из репозитория"
+
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:118
+msgid "Remote:"
+msgstr "внешний:"
+
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:133
+msgid "Arbitrary URL:"
+msgstr "по указанному URL:"
+
+#: lib/remote_branch_delete.tcl:84
+msgid "Branches"
+msgstr "Ветви"
+
+#: lib/remote_branch_delete.tcl:109
+msgid "Delete Only If"
+msgstr "Удалить только в случае, если"
+
+#: lib/remote_branch_delete.tcl:111
+msgid "Merged Into:"
+msgstr "Объединено с:"
+
+#: lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
+msgstr ""
+"Всегда (не выполнять проверку "
+"объединений)"
+
+#: lib/remote_branch_delete.tcl:152
+msgid "A branch is required for 'Merged Into'."
+msgstr ""
+"Для опции 'Объединено с' требуется "
+"указать ветвь."
+
+#: lib/remote_branch_delete.tcl:189
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched the "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:207
+msgid "Please select one or more branches to delete."
+msgstr ""
+"Укажите одну или несколько ветвей для "
+"удаления."
+
+#: lib/remote_branch_delete.tcl:216
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Восстановить удаленные ветви сложно.\n"
+"\n"
+"Продолжить?"
+
+#: lib/remote_branch_delete.tcl:226
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "Удаление ветвей из %s"
+
+#: lib/remote_branch_delete.tcl:286
+msgid "No repository selected."
+msgstr "Не указан репозиторий"
+
+#: lib/remote_branch_delete.tcl:291
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "Перечитывание %s... "
+
+#: lib/remote.tcl:156
+#, fuzzy, tcl-format
+msgid "Fetch from %s..."
+msgstr "Чистка %s... "
+
+#: lib/remote.tcl:166
+#, tcl-format
+msgid "Prune from %s..."
+msgstr "Чистка %s... "
+
+#: lib/remote.tcl:200
+#, tcl-format
+msgid "Push to %s..."
+msgstr "Отправка в %s..."
+
+#: lib/shortcut.tcl:26 lib/shortcut.tcl:74
+msgid "Cannot write script:"
+msgstr "Невозможно записать скрипт:"
+
+#: lib/shortcut.tcl:149
+msgid "Cannot write icon:"
+msgstr "Невозможно записать значок:"
+
+#: lib/status_bar.tcl:58
+#, tcl-format
+msgid "%s ... %i of %i %s (%2i%%)"
+msgstr "%s ... %i из %i %s (%2i%%)"
+
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Получение изменений из %s "
+
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "Чистка ветвей слежения, удаленных из %s"
+
+#: lib/transport.tcl:26
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "Отправка изменений в %s "
+
+#: lib/transport.tcl:68
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "Отправка %s %s в %s"
+
+#: lib/transport.tcl:84
+msgid "Push Branches"
+msgstr "Отправить изменения"
+
+#: lib/transport.tcl:115
+msgid "Destination Repository"
+msgstr "Репозиторий назначения"
+
+#: lib/transport.tcl:153
+msgid "Transfer Options"
+msgstr "Настройки передачи"
+
+#: lib/transport.tcl:155
+msgid "Use thin pack (for slow network connections)"
+msgstr ""
+"Использовать thin pack (для медленных сетевых "
+"подключений)"
+
+#: lib/transport.tcl:159
+msgid "Include tags"
+msgstr "Включить метки"
-- 
1.5.3.2.g46909


--8323584-1124202225-1188750999=:28586--
