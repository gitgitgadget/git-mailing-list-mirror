From: Benjamin Kerensa <bkerensa@ubuntu.com>
Subject: [PATCH] Fix for Typo in po files in git-gui
Date: Mon, 05 Mar 2012 17:16:50 -0800
Organization: Ubuntu
Message-ID: <4F556582.2090600@ubuntu.com>
References: <4F553CE5.4040708@ubuntu.com> <20120305233327.GA1360@burratino>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000900020706090008020701"
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 02:17:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4j1R-0001Tx-H2
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 02:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758125Ab2CFBQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 20:16:55 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58564 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757930Ab2CFBQy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 20:16:54 -0500
Received: by pbcun15 with SMTP id un15so3429745pbc.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 17:16:54 -0800 (PST)
Received-SPF: pass (google.com: domain of bkerensa@gmail.com designates 10.68.225.73 as permitted sender) client-ip=10.68.225.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of bkerensa@gmail.com designates 10.68.225.73 as permitted sender) smtp.mail=bkerensa@gmail.com; dkim=pass header.i=bkerensa@gmail.com
Received: from mr.google.com ([10.68.225.73])
        by 10.68.225.73 with SMTP id ri9mr55633060pbc.70.1330996614053 (num_hops = 1);
        Mon, 05 Mar 2012 17:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type;
        bh=qTatebrLQELIss3uO053pE3y5XyAG9YLGlqUmFVUOVs=;
        b=XSFs2KBDpjMAHMJ13zrlC5HF0ZgI9+MU1j2beFRBbKF4u4kXyatryWN75L6aiAOBsA
         SnoktmHaJgHkic98kq44w+QUwHmlWyLwuv6S7bYcvUcJXlA1sEg0HsOtqTtU//sb5+jW
         8TPkhGmchrs2WtuMsRbe+3QyhTgN/8fyYOLjFEZ3FUG15/fge6YNq9tOZNtykz+E2Wum
         eGQSaJjPOSK8OozmwtL2e3Ib3eGvg9uAoz8PiFPmtD6biI4CIHVlcPIm8Un108t/CxLA
         5Mv1dqN7P8UlZf1eM+C0EQOfbA4I1A+XPH3XAKqOoByxnfkV1egGOzcI6SwybLTvpRSc
         RjTA==
Received: by 10.68.225.73 with SMTP id ri9mr47624287pbc.70.1330996613987;
        Mon, 05 Mar 2012 17:16:53 -0800 (PST)
Received: from [192.168.2.2] (c-24-21-211-132.hsd1.or.comcast.net. [24.21.211.132])
        by mx.google.com with ESMTPS id f8sm14745128pbe.42.2012.03.05.17.16.51
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Mar 2012 17:16:52 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120302 Thunderbird/11.0
In-Reply-To: <20120305233327.GA1360@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192295>

This is a multi-part message in MIME format.
--------------000900020706090008020701
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>From 8caa972ad46858a126590e32825fd2dc5947da08 Mon Sep 17 00:00:00 2001

From: Benjamin Kerensa <bkerensa@ubuntu.com>

Date: Mon, 5 Mar 2012 16:51:15 -0800

Subject: [PATCH] Fix for Typo in po files

---

 po/de.po       |    2 +-

 po/fr.po       |    2 +-

 po/git-gui.pot |    2 +-

 po/hu.po       |    2 +-

 po/it.po       |    2 +-

 po/ja.po       |    2 +-

 po/nb.po       |    2 +-

 po/pt_br.po    |    2 +-

 po/ru.po       |    2 +-

 po/sv.po       |    2 +-

 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/po/de.po b/po/de.po

index 44c5ddc..d9a9ebd 100644

--- a/po/de.po

+++ b/po/de.po

@@ -2397,7 +2397,7 @@ msgid "Generation failed."

 msgstr "Schlüsselerzeugung fehlgeschlagen."

 

 #: lib/sshkey.tcl:118

-msgid "Generation succeded, but no keys found."

+msgid "Generation succeeded, but no keys found."

 msgstr "Schlüsselerzeugung erfolgreich, aber keine Schlüssel gefunden."

 

 #: lib/sshkey.tcl:121

diff --git a/po/fr.po b/po/fr.po

index 8170696..40441db 100644

--- a/po/fr.po

+++ b/po/fr.po

@@ -2399,7 +2399,7 @@ msgid "Generation failed."

 msgstr "La génération a échoué."

 

 #: lib/sshkey.tcl:118

-msgid "Generation succeded, but no keys found."

+msgid "Generation succeeded, but no keys found."

 msgstr "La génération a réussi, mais aucune clé n'a été trouvée."

 

 #: lib/sshkey.tcl:121

diff --git a/po/git-gui.pot b/po/git-gui.pot

index 1ae2aaa..0c94f9c 100644

--- a/po/git-gui.pot

+++ b/po/git-gui.pot

@@ -2203,7 +2203,7 @@ msgid "Generation failed."

 msgstr ""

 

 #: lib/sshkey.tcl:118

-msgid "Generation succeded, but no keys found."

+msgid "Generation succeeded, but no keys found."

 msgstr ""

 

 #: lib/sshkey.tcl:121

diff --git a/po/hu.po b/po/hu.po

index 0f87bc1..d106dad 100644

--- a/po/hu.po

+++ b/po/hu.po

@@ -2354,7 +2354,7 @@ msgid "Generation failed."

 msgstr "A generálás nem sikerült."

 

 #: lib/sshkey.tcl:118

-msgid "Generation succeded, but no keys found."

+msgid "Generation succeeded, but no keys found."

 msgstr "A generálás sikeres, de egy kulcs se található."

 

 #: lib/sshkey.tcl:121

diff --git a/po/it.po b/po/it.po

index aa15a20..1bd8b8e 100644

--- a/po/it.po

+++ b/po/it.po

@@ -2397,7 +2397,7 @@ msgid "Generation failed."

 msgstr "Errore durante la creazione della chiave."

 

 #: lib/sshkey.tcl:118

-msgid "Generation succeded, but no keys found."

+msgid "Generation succeeded, but no keys found."

 msgstr "La chiave è stata creata con successo, ma non è stata trovata."

 

 #: lib/sshkey.tcl:121

diff --git a/po/ja.po b/po/ja.po

index 1501798..9aff249 100644

--- a/po/ja.po

+++ b/po/ja.po

@@ -2362,7 +2362,7 @@ msgid "Generation failed."

 msgstr "生成に失敗しました。"

 

 #: lib/sshkey.tcl:118

-msgid "Generation succeded, but no keys found."

+msgid "Generation succeeded, but no keys found."

 msgstr "生成には成功しましたが、鍵が見つかりません。"

 

 #: lib/sshkey.tcl:121

diff --git a/po/nb.po b/po/nb.po

index 6de93c2..d66aa50 100644

--- a/po/nb.po

+++ b/po/nb.po

@@ -2286,7 +2286,7 @@ msgid "Generation failed."

 msgstr "Generering feilet."

 

 #: lib/sshkey.tcl:118

-msgid "Generation succeded, but no keys found."

+msgid "Generation succeeded, but no keys found."

 msgstr "Generering vellykket, men ingen nøkler er funnet."

 

 #: lib/sshkey.tcl:121

diff --git a/po/pt_br.po b/po/pt_br.po

index b175b97..bad116c 100644

--- a/po/pt_br.po

+++ b/po/pt_br.po

@@ -2375,7 +2375,7 @@ msgid "Generation failed."

 msgstr "A geração da chave falhou."

 

 #: lib/sshkey.tcl:118

-msgid "Generation succeded, but no keys found."

+msgid "Generation succeeded, but no keys found."

 msgstr "A geração da chave foi bem-sucedida, mas nenhuma chave foi encontrada."

 

 #: lib/sshkey.tcl:121

diff --git a/po/ru.po b/po/ru.po

index 30f4b77..ca4343b 100644

--- a/po/ru.po

+++ b/po/ru.po

@@ -2370,7 +2370,7 @@ msgid "Generation failed."

 msgstr "Ключ не создан."

 

 #: lib/sshkey.tcl:118

-msgid "Generation succeded, but no keys found."

+msgid "Generation succeeded, but no keys found."

 msgstr "Создание ключа завершилось, но результат не был найден"

 

 #: lib/sshkey.tcl:121

diff --git a/po/sv.po b/po/sv.po

index 24cc4e3..fcb063f 100644

--- a/po/sv.po

+++ b/po/sv.po

@@ -2382,7 +2382,7 @@ msgid "Generation failed."

 msgstr "Misslyckades med att skapa."

 

 #: lib/sshkey.tcl:120

-msgid "Generation succeded, but no keys found."

+msgid "Generation succeeded, but no keys found."

 msgstr "Lyckades skapa nyckeln, men hittar inte någon nyckel."

 

 #: lib/sshkey.tcl:123

-- 

1.7.9


--------------000900020706090008020701
Content-Type: text/x-patch;
 name="git-gui-typo-fix.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="git-gui-typo-fix.patch"

>From 8caa972ad46858a126590e32825fd2dc5947da08 Mon Sep 17 00:00:00 2001
From: Benjamin Kerensa <bkerensa@ubuntu.com>
Date: Mon, 5 Mar 2012 16:51:15 -0800
Subject: [PATCH] Fix for Typo in po files

---
 po/de.po       |    2 +-
 po/fr.po       |    2 +-
 po/git-gui.pot |    2 +-
 po/hu.po       |    2 +-
 po/it.po       |    2 +-
 po/ja.po       |    2 +-
 po/nb.po       |    2 +-
 po/pt_br.po    |    2 +-
 po/ru.po       |    2 +-
 po/sv.po       |    2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/po/de.po b/po/de.po
index 44c5ddc..d9a9ebd 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2397,7 +2397,7 @@ msgid "Generation failed."
 msgstr "Schlüsselerzeugung fehlgeschlagen."
 
 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "Schlüsselerzeugung erfolgreich, aber keine Schlüssel gefunden."
 
 #: lib/sshkey.tcl:121
diff --git a/po/fr.po b/po/fr.po
index 8170696..40441db 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -2399,7 +2399,7 @@ msgid "Generation failed."
 msgstr "La génération a échoué."
 
 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "La génération a réussi, mais aucune clé n'a été trouvée."
 
 #: lib/sshkey.tcl:121
diff --git a/po/git-gui.pot b/po/git-gui.pot
index 1ae2aaa..0c94f9c 100644
--- a/po/git-gui.pot
+++ b/po/git-gui.pot
@@ -2203,7 +2203,7 @@ msgid "Generation failed."
 msgstr ""
 
 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr ""
 
 #: lib/sshkey.tcl:121
diff --git a/po/hu.po b/po/hu.po
index 0f87bc1..d106dad 100644
--- a/po/hu.po
+++ b/po/hu.po
@@ -2354,7 +2354,7 @@ msgid "Generation failed."
 msgstr "A generálás nem sikerült."
 
 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "A generálás sikeres, de egy kulcs se található."
 
 #: lib/sshkey.tcl:121
diff --git a/po/it.po b/po/it.po
index aa15a20..1bd8b8e 100644
--- a/po/it.po
+++ b/po/it.po
@@ -2397,7 +2397,7 @@ msgid "Generation failed."
 msgstr "Errore durante la creazione della chiave."
 
 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "La chiave è stata creata con successo, ma non è stata trovata."
 
 #: lib/sshkey.tcl:121
diff --git a/po/ja.po b/po/ja.po
index 1501798..9aff249 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -2362,7 +2362,7 @@ msgid "Generation failed."
 msgstr "生成に失敗しました。"
 
 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "生成には成功しましたが、鍵が見つかりません。"
 
 #: lib/sshkey.tcl:121
diff --git a/po/nb.po b/po/nb.po
index 6de93c2..d66aa50 100644
--- a/po/nb.po
+++ b/po/nb.po
@@ -2286,7 +2286,7 @@ msgid "Generation failed."
 msgstr "Generering feilet."
 
 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "Generering vellykket, men ingen nøkler er funnet."
 
 #: lib/sshkey.tcl:121
diff --git a/po/pt_br.po b/po/pt_br.po
index b175b97..bad116c 100644
--- a/po/pt_br.po
+++ b/po/pt_br.po
@@ -2375,7 +2375,7 @@ msgid "Generation failed."
 msgstr "A geração da chave falhou."
 
 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "A geração da chave foi bem-sucedida, mas nenhuma chave foi encontrada."
 
 #: lib/sshkey.tcl:121
diff --git a/po/ru.po b/po/ru.po
index 30f4b77..ca4343b 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -2370,7 +2370,7 @@ msgid "Generation failed."
 msgstr "Ключ не создан."
 
 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "Создание ключа завершилось, но результат не был найден"
 
 #: lib/sshkey.tcl:121
diff --git a/po/sv.po b/po/sv.po
index 24cc4e3..fcb063f 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -2382,7 +2382,7 @@ msgid "Generation failed."
 msgstr "Misslyckades med att skapa."
 
 #: lib/sshkey.tcl:120
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "Lyckades skapa nyckeln, men hittar inte någon nyckel."
 
 #: lib/sshkey.tcl:123
-- 
1.7.9


--------------000900020706090008020701--
