From: Benjamin Kerensa <bkerensa@ubuntu.com>
Subject: [PATCH] git-gui: typo in git translation files
Date: Thu, 8 Mar 2012 08:56:50 +0000 (UTC)
Message-ID: <loom.20120308T095609-500@post.gmane.org>
References: <4F553CE5.4040708@ubuntu.com> <20120305233327.GA1360@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 10:00:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ZCo-0005NS-DT
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 10:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580Ab2CHJAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 04:00:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:45110 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755470Ab2CHJAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 04:00:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S5ZCf-0005DD-1Y
	for git@vger.kernel.org; Thu, 08 Mar 2012 10:00:05 +0100
Received: from c-24-21-211-132.hsd1.or.comcast.net ([24.21.211.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 10:00:05 +0100
Received: from bkerensa by c-24-21-211-132.hsd1.or.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 10:00:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.21.211.132 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.45 Safari/535.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192539>

"succeeded" was misspelled in the code, which propagated throughout the
 translations.

=46ixed all of them.

Signed-off-by: Benjamin Kerensa <bkerensa <at> ubuntu.com>

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
< at >< at > -2397,7 +2397,7 < at >< at > msgid "Generation failed."
 msgstr "Schl=C3=BCsselerzeugung fehlgeschlagen."

 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "Schl=C3=BCsselerzeugung erfolgreich, aber keine Schl=C3=BCssel=
 gefunden."

 #: lib/sshkey.tcl:121
diff --git a/po/fr.po b/po/fr.po
index 8170696..40441db 100644
--- a/po/fr.po
+++ b/po/fr.po
< at >< at > -2399,7 +2399,7 < at >< at > msgid "Generation failed."
 msgstr "La g=C3=A9n=C3=A9ration a =C3=A9chou=C3=A9."

 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "La g=C3=A9n=C3=A9ration a r=C3=A9ussi, mais aucune cl=C3=A9 n'=
a =C3=A9t=C3=A9 trouv=C3=A9e."

 #: lib/sshkey.tcl:121
diff --git a/po/git-gui.pot b/po/git-gui.pot
index 1ae2aaa..0c94f9c 100644
--- a/po/git-gui.pot
+++ b/po/git-gui.pot
< at >< at > -2203,7 +2203,7 < at >< at > msgid "Generation failed."
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
< at >< at > -2354,7 +2354,7 < at >< at > msgid "Generation failed."
 msgstr "A gener=C3=A1l=C3=A1s nem siker=C3=BClt."

 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "A gener=C3=A1l=C3=A1s sikeres, de egy kulcs se tal=C3=A1lhat=C3=
=B3."

 #: lib/sshkey.tcl:121
diff --git a/po/it.po b/po/it.po
index aa15a20..1bd8b8e 100644
--- a/po/it.po
+++ b/po/it.po
< at >< at > -2397,7 +2397,7 < at >< at > msgid "Generation failed."
 msgstr "Errore durante la creazione della chiave."

 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "La chiave =C3=A8 stata creata con successo, ma non =C3=A8 stat=
a trovata."

 #: lib/sshkey.tcl:121
diff --git a/po/ja.po b/po/ja.po
index 1501798..9aff249 100644
--- a/po/ja.po
+++ b/po/ja.po
< at >< at > -2362,7 +2362,7 < at >< at > msgid "Generation failed."
 msgstr "=E7=94=9F=E6=88=90=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=
=E3=81=97=E3=81=9F=E3=80=82"

 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "=E7=94=9F=E6=88=90=E3=81=AB=E3=81=AF=E6=88=90=E5=8A=9F=E3=81=97=
=E3=81=BE=E3=81=97=E3=81=9F=E3=81=8C=E3=80=81=E9=8D=B5=E3=81=8C=E8=A6=8B=
=E3=81=A4=E3=81=8B=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82"

 #: lib/sshkey.tcl:121
diff --git a/po/nb.po b/po/nb.po
index 6de93c2..d66aa50 100644
--- a/po/nb.po
+++ b/po/nb.po
< at >< at > -2286,7 +2286,7 < at >< at > msgid "Generation failed."
 msgstr "Generering feilet."

 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "Generering vellykket, men ingen n=C3=B8kler er funnet."

 #: lib/sshkey.tcl:121
diff --git a/po/pt_br.po b/po/pt_br.po
index b175b97..bad116c 100644
--- a/po/pt_br.po
+++ b/po/pt_br.po
< at >< at > -2375,7 +2375,7 < at >< at > msgid "Generation failed."
 msgstr "A gera=C3=A7=C3=A3o da chave falhou."

 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "A gera=C3=A7=C3=A3o da chave foi bem-sucedida, mas nenhuma cha=
ve foi encontrada."

 #: lib/sshkey.tcl:121
diff --git a/po/ru.po b/po/ru.po
index 30f4b77..ca4343b 100644
--- a/po/ru.po
+++ b/po/ru.po
< at >< at > -2370,7 +2370,7 < at >< at > msgid "Generation failed."
 msgstr "=D0=9A=D0=BB=D1=8E=D1=87 =D0=BD=D0=B5 =D1=81=D0=BE=D0=B7=D0=B4=
=D0=B0=D0=BD."

 #: lib/sshkey.tcl:118
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=B5 =D0=BA=D0=BB=D1=
=8E=D1=87=D0=B0 =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D0=BB=D0=BE=D1=
=81=D1=8C, =D0=BD=D0=BE =D1=80=D0=B5=D0=B7=D1=83=D0=BB=D1=8C=D1=82=D0=B0=
=D1=82 =D0=BD=D0=B5 =D0=B1=D1=8B=D0=BB =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=
=BD"

 #: lib/sshkey.tcl:121
diff --git a/po/sv.po b/po/sv.po
index 24cc4e3..fcb063f 100644
--- a/po/sv.po
+++ b/po/sv.po
< at >< at > -2382,7 +2382,7 < at >< at > msgid "Generation failed."
 msgstr "Misslyckades med att skapa."

 #: lib/sshkey.tcl:120
-msgid "Generation succeded, but no keys found."
+msgid "Generation succeeded, but no keys found."
 msgstr "Lyckades skapa nyckeln, men hittar inte n=C3=A5gon nyckel."

 #: lib/sshkey.tcl:123
