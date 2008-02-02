From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] [git-gui] Update German translation.
Date: Sat, 2 Feb 2008 10:21:38 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200802021021.38566.stimming@tuhh.de>
References: <200802021020.18017.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iYDpHChOfUbgg4m"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 02 10:23:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLEb8-0000lb-AS
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 10:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758931AbYBBJXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 04:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758500AbYBBJXI
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 04:23:08 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:49401 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758098AbYBBJXE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 04:23:04 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m129Mnvb013963
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 2 Feb 2008 10:22:49 +0100
Received: from [192.168.2.102] (p549028DC.dip0.t-ipconnect.de [84.144.40.220])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m129MlcT012065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Feb 2008 10:22:49 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <200802021020.18017.stimming@tuhh.de>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72237>

--Boundary-00=_iYDpHChOfUbgg4m
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
Also attached as gzip because of whitespace yadda yadda.

 po/de.po |  129 ++++++++++++++++++++++++++++++++++++++++++----------------=
=2D--
 1 files changed, 89 insertions(+), 40 deletions(-)

diff --git a/po/de.po b/po/de.po
index 2dfe07e..d7c38f9 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2007-11-24 10:36+0100\n"
=2D"PO-Revision-Date: 2008-01-15 20:33+0100\n"
+"POT-Creation-Date: 2008-02-02 10:14+0100\n"
+"PO-Revision-Date: 2008-02-02 10:18+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -343,7 +343,9 @@ msgstr "Online-Dokumentation"
 #: git-gui.sh:2201
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
=2Dmsgstr "Fehler: Verzeichnis =BB%s=AB kann nicht gelesen werden: Datei od=
er Verzeichnis nicht gefunden"
+msgstr ""
+"Fehler: Verzeichnis =BB%s=AB kann nicht gelesen werden: Datei oder Verzei=
chnis "
+"nicht gefunden"
=20
 #: git-gui.sh:2234
 msgid "Current Branch:"
@@ -371,19 +373,19 @@ msgstr "Erste Versionsbeschreibung:"
=20
 #: git-gui.sh:2370
 msgid "Amended Commit Message:"
=2Dmsgstr "Nachgebesserte Versionsbeschreibung:"
+msgstr "Nachgebesserte Beschreibung:"
=20
 #: git-gui.sh:2371
 msgid "Amended Initial Commit Message:"
=2Dmsgstr "Nachgebesserte erste Versionsbeschreibung:"
+msgstr "Nachgebesserte erste Beschreibung:"
=20
 #: git-gui.sh:2372
 msgid "Amended Merge Commit Message:"
=2Dmsgstr "Nachgebesserte Zusammenf=FChrungs-Versionsbeschreibung:"
+msgstr "Nachgebesserte Zusammenf=FChrungs-Beschreibung:"
=20
 #: git-gui.sh:2373
 msgid "Merge Commit Message:"
=2Dmsgstr "Zusammenf=FChrungs-Versionsbeschreibung:"
+msgstr "Zusammenf=FChrungs-Beschreibung:"
=20
 #: git-gui.sh:2374
 msgid "Commit Message:"
@@ -397,31 +399,31 @@ msgstr "Alle kopieren"
 msgid "File:"
 msgstr "Datei:"
=20
=2D#: git-gui.sh:2545
=2Dmsgid "Refresh"
=2Dmsgstr "Aktualisieren"
=2D
=2D#: git-gui.sh:2566
+#: git-gui.sh:2573
 msgid "Apply/Reverse Hunk"
 msgstr "Kontext anwenden/umkehren"
=20
=2D#: git-gui.sh:2572
=2Dmsgid "Decrease Font Size"
=2Dmsgstr "Schriftgr=F6=DFe verkleinern"
=2D
=2D#: git-gui.sh:2576
=2Dmsgid "Increase Font Size"
=2Dmsgstr "Schriftgr=F6=DFe vergr=F6=DFern"
=2D
=2D#: git-gui.sh:2581
+#: git-gui.sh:2579
 msgid "Show Less Context"
 msgstr "Weniger Zeilen anzeigen"
=20
=2D#: git-gui.sh:2588
+#: git-gui.sh:2586
 msgid "Show More Context"
 msgstr "Mehr Zeilen anzeigen"
=20
=2D#: git-gui.sh:2602
+#: git-gui.sh:2594
+msgid "Refresh"
+msgstr "Aktualisieren"
+
+#: git-gui.sh:2615
+msgid "Decrease Font Size"
+msgstr "Schriftgr=F6=DFe verkleinern"
+
+#: git-gui.sh:2619
+msgid "Increase Font Size"
+msgstr "Schriftgr=F6=DFe vergr=F6=DFern"
+
+#: git-gui.sh:2630
 msgid "Unstage Hunk From Commit"
 msgstr "Kontext aus Bereitstellung herausnehmen"
=20
@@ -542,7 +544,7 @@ msgstr "Kopiert oder verschoben durch:"
=20
 #: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
 msgid "Checkout Branch"
=2Dmsgstr "Zweig umstellen"
+msgstr "Auf Zweig umstellen"
=20
 #: lib/branch_checkout.tcl:23
 msgid "Checkout"
@@ -805,11 +807,15 @@ msgstr ""
 msgid "Updating working directory to '%s'..."
 msgstr "Arbeitskopie umstellen auf =BB%s=AB..."
=20
+#: lib/checkout_op.tcl:323
+msgid "files checked out"
+msgstr "Dateien aktualisiert"
+
 #: lib/checkout_op.tcl:353
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr ""
=2D"Zweig umstellen von =BB%s=AB abgebrochen (Zusammenf=FChren der Dateien =
ist "
+"Auf Zweig =BB%s=AB umstellen abgebrochen (Zusammenf=FChren der Dateien is=
t "
 "notwendig)."
=20
 #: lib/checkout_op.tcl:354
@@ -1069,15 +1075,21 @@ msgstr "F=FCr Objekt konnte kein Hardlink erstellt =
werden: %s"
=20
 #: lib/choose_repository.tcl:847
 msgid "Cannot fetch branches and objects.  See console output for details."
=2Dmsgstr "Zweige und Objekte konnten nicht angefordert werden.  Kontrollie=
ren Sie die Ausgaben auf der Konsole f=FCr weitere Angaben."
+msgstr ""
+"Zweige und Objekte konnten nicht angefordert werden.  Kontrollieren Sie d=
ie "
+"Ausgaben auf der Konsole f=FCr weitere Angaben."
=20
 #: lib/choose_repository.tcl:858
 msgid "Cannot fetch tags.  See console output for details."
=2Dmsgstr "Markierungen konnten nicht angefordert werden.  Kontrollieren Si=
e die Ausgaben auf der Konsole f=FCr weitere Angaben."
+msgstr ""
+"Markierungen konnten nicht angefordert werden.  Kontrollieren Sie die "
+"Ausgaben auf der Konsole f=FCr weitere Angaben."
=20
 #: lib/choose_repository.tcl:882
 msgid "Cannot determine HEAD.  See console output for details."
=2Dmsgstr "Die Zweigspitze (HEAD) konnte nicht gefunden werden.  Kontrollie=
ren Sie die Ausgaben auf der Konsole f=FCr weitere Angaben."
+msgstr ""
+"Die Zweigspitze (HEAD) konnte nicht gefunden werden.  Kontrollieren Sie d=
ie "
+"Ausgaben auf der Konsole f=FCr weitere Angaben."
=20
 #: lib/choose_repository.tcl:891
 #, tcl-format
@@ -1273,11 +1285,40 @@ msgstr ""
 "\n"
 "- Rest: Eine ausf=FChrliche Beschreibung, warum diese =C4nderung hilfreic=
h ist.\n"
=20
=2D#: lib/commit.tcl:257
+#: lib/commit.tcl:207
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "Warning: Tcl/Tk unterst=FCtzt die Zeichencodierung =BB%s=AB nicht."
+
+#: lib/commit.tcl:221
+msgid "Calling pre-commit hook..."
+msgstr ""
+
+#: lib/commit.tcl:236
+msgid "Commit declined by pre-commit hook."
+msgstr ""
+
+#: lib/commit.tcl:259
+msgid "Calling commit-msg hook..."
+msgstr ""
+
+#: lib/commit.tcl:274
+msgid "Commit declined by commit-msg hook."
+msgstr ""
+
+#: lib/commit.tcl:287
+msgid "Committing changes..."
+msgstr "=C4nderungen eintragen..."
+
+#: lib/commit.tcl:303
 msgid "write-tree failed:"
 msgstr "write-tree fehlgeschlagen:"
=20
=2D#: lib/commit.tcl:275
+#: lib/commit.tcl:304 lib/commit.tcl:348 lib/commit.tcl:368
+msgid "Commit failed."
+msgstr "Eintragen fehlgeschlagen."
+
+#: lib/commit.tcl:321
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "Version =BB%s=AB scheint besch=E4digt zu sein"
@@ -1301,12 +1342,7 @@ msgstr ""
 msgid "No changes to commit."
 msgstr "Keine =C4nderungen, die eingetragen werden k=F6nnen."
=20
=2D#: lib/commit.tcl:303
=2D#, tcl-format
=2Dmsgid "warning: Tcl does not support encoding '%s'."
=2Dmsgstr "Warning: Tcl/Tk unterst=FCtzt die Zeichencodierung =BB%s=AB nich=
t."
=2D
=2D#: lib/commit.tcl:317
+#: lib/commit.tcl:347
 msgid "commit-tree failed:"
 msgstr "commit-tree fehlgeschlagen:"
=20
@@ -1440,7 +1476,8 @@ msgstr "Fehler beim Laden des Vergleichs:"
=20
 #: lib/diff.tcl:302
 msgid "Failed to unstage selected hunk."
=2Dmsgstr "Fehler beim Herausnehmen des gew=E4hlten Kontexts aus der Bereit=
stellung."
+msgstr ""
+"Fehler beim Herausnehmen des gew=E4hlten Kontexts aus der Bereitstellung."
=20
 #: lib/diff.tcl:309
 msgid "Failed to stage selected hunk."
@@ -1471,7 +1508,10 @@ msgstr "Fehler in Bereitstellung"
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically started to=
 "
 "resynchronize git-gui."
=2Dmsgstr "Das Aktualisieren der Git-Bereitstellung ist fehlgeschlagen. Ein=
e allgemeine Git-Aktualisierung wird jetzt gestartet, um git-gui wieder mit=
 git zu synchronisieren."
+msgstr ""
+"Das Aktualisieren der Git-Bereitstellung ist fehlgeschlagen. Eine allgeme=
ine "
+"Git-Aktualisierung wird jetzt gestartet, um git-gui wieder mit git zu "
+"synchronisieren."
=20
 #: lib/index.tcl:27
 msgid "Continue"
@@ -1486,6 +1526,10 @@ msgstr "Bereitstellung freigeben"
 msgid "Unstaging %s from commit"
 msgstr "Datei =BB%s=AB aus der Bereitstellung herausnehmen"
=20
+#: lib/index.tcl:313
+msgid "Ready to commit."
+msgstr "Bereit zum Eintragen."
+
 #: lib/index.tcl:326
 #, tcl-format
 msgid "Adding %s"
@@ -1503,7 +1547,8 @@ msgstr "=C4nderungen in den gew=E4hlten %i Dateien ve=
rwerfen?"
=20
 #: lib/index.tcl:389
 msgid "Any unstaged changes will be permanently lost by the revert."
=2Dmsgstr "Alle nicht bereitgestellten =C4nderungen werden beim Verwerfen v=
erloren gehen."
+msgstr ""
+"Alle nicht bereitgestellten =C4nderungen werden beim Verwerfen verloren g=
ehen."
=20
 #: lib/index.tcl:392
 msgid "Do Nothing"
@@ -1641,7 +1686,11 @@ msgstr ""
 msgid "Aborting"
 msgstr "Abbruch"
=20
=2D#: lib/merge.tcl:266
+#: lib/merge.tcl:238
+msgid "files reset"
+msgstr "Dateien zur=FCckgesetzt"
+
+#: lib/merge.tcl:265
 msgid "Abort failed."
 msgstr "Abbruch fehlgeschlagen."
=20
=2D-=20
1.5.4.rc4


--Boundary-00=_iYDpHChOfUbgg4m
Content-Type: application/x-gzip;
  name="0002-git-gui-Update-German-translation.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0002-git-gui-Update-German-translation.patch.gz"

H4sICIE1pEcAAzAwMDItZ2l0LWd1aS1VcGRhdGUtR2VybWFuLXRyYW5zbGF0aW9uLnBhdGNoAMVZ
S4/bRhK+61cUJhjEhkQNKVIiJSx2rcx4YsMe2/BMEsBJYPDRfEQUqTSbnsxgj/s/9pLb3nNZnzJ/
bKuaD5EiZWuCMdYwLJnsrvq66qtX65yna7AtV58ye+qopulMNc2fWw6znfl05ppMc2azmT3VNdWC
izSBS7YBzQRVXci/MFFVbXCOYhZwGvIoE5GNi0S0XkdJAH/Lym9PRB6GY4/9fXBmC7aAS1uMYALn
zCEJFmjqQrMWExOGqqaqg8vc+YW5YgE/vllenT77GX4MIqEEefQzfLfxUAJ8y/gaNQluJ1lsiyhN
xoPBZRQkzFNS31ecm0MBKYoygE164rHxJoV/AmiTOQwP/qN0/wxAAz+KWQZuaCcB80ZgzSFKMsYJ
aPZo+HgEhgoei1nxQHk8GHiR74Oi4EHBPqnxOPXXQZR47DeYeD5TTTYee6arW/4cTafODIOO0dg3
QGTNvU+egGKOLBjSP/ifdRZEHhwdDehbJrj8evSGp2R25bmnfM94htAWUBr+p4QWvGWblAvlgnYr
3+RBplylC6B3ytGb11fKKWfSF0rhZXStqWiaMjHIwfpMOrdarbxlH6KstdhSVE3Rpvh1oev14uEe
0bh6gn8ld4zW6n7R9WKrXgxHL+1MKFcli1J+IGmqvUmQ2wFTrpiN/C8oWby6eH7xdGtDbSy1kRN0
Qx8hy+ljXjpCmv91EkcJU87SVb5miZBHRUFf1Q4YZ+FiMsFgg69GINxY8VNUJwaVK31b2PECXDtJ
UgEZSoCNLUI4zhbwKoUsd0NJSkg5eBFHN6f8Bj1RAThnYczw/Aj6lkVumEQZ/Pnf4+zP/8AKZUKC
zwQESNmMJXDNuMfwZGTfCFKP8dbGarGfI2fJKVuWDR9WEwnc1QZdu+lGbajTnHO0MHyDTnfDRekW
UxtpGPa6qdNnwzFPeYbppnRl5rDMDTmLnDwJFn2adFOtNS3Rkx7z4DRF9gi4YFmGbFk0jP7KdsOA
oVBKDXu1DPcs/+bzYLQOmOdJhOyODwfFPmWAfdCKTQcAnHQAXjAesMPhvcsze41b/buPIUc9mXJP
qF0BB8DWa9ifg3t/fH8JUIPfu1Akv+fmSNeQ3/M5fTb4vYwxJ6zSTcS4jJ1SyjmmikWjPMjwk7qV
Hd1TYypPS7veMp+zLGwcf7kSuR1jMi7EK93ts9lguPusYd/lZhPfnGBCR6sxeJYnqwaqF2ki2G9Y
MJNrIk9ykq9XLCwO0tWEZKuAnjEX6wkKPEcJcBndsgbmSzR25IuA3/1x928GqHkVM8zOvP8A5qwW
+zy5l9jy6x65ltZjmHltmMswvYaX6GUkn7RCwy4/sCQKMFO+Y+jGBM2D+TLYYxXL6qqxZm01Fyln
PWou0NaH6Jipk66OuSEp36LNcA9thp3tM21ab+9z5vAQZ/aJnddi+5z5CbENZ/bI1bdl4bsEq3NQ
cBmodS6zRx+v8wyTKEa+wHQaxxj+EDKOTxMWrgtbU3RPjQk1FVPDwI9GbL+QYS2KqkkB5Iapg77y
ci4rX5FI4sg5cWQxfO+GzF2luRhjg4FN1f5XWxqels/LetrMfNdICMjXEnqrC1jmPnTefhrMRO9o
LDKbpU5HGmY2SzVH2Do2Tr9NZnJmoE7uOuUr+qwbIBApfH2cfT0ejxvmX3KHTC6z4hYiesMvG5Vi
ufQyAa6Qvk83EqyOaCsWVYMArsDiJmEPW0mVBG/ZTq9rQ3TkTvV97d/SwcYcFVRbIPXlweCRbPpi
zJ8xrJGldHzsmzj7NUcjeI/HrRlA2fUafMChr+zObAfLJk9RRQKPWlWKOIUUq86DDbRszLZ+LiU0
bHk/WXCEXS3l+CiQiD9hIkPSQlNnc+LDUFPN6WjSKnnndx85vMYJcyWw8iUYarDClADPbO5hF74q
upc4FnXzeZy1daZpxt5zHIayiFgkNVuGuaVo0YX7TGDXXdAZSWAnSAA52GZjwEmagYttQEo9eS42
6DOfenMm7CjOxruBhETE7QVqVsKuemUaMnGvR7FeQEb5lEN4GscyhWL6Ysh6Bss8C2ynJDPZ+UUJ
wSejoCKBy2GZyEXjnc79IYEU/LgfmM+6YGr1uwDz7f1MfmFjomDUfSG6/4+xHwbCFzGzNdk1M5oQ
p18sq/Ds6fLsXqY+Q5SSWNkmErcMHpGEx1Vgtme7L2rwhwTyRcw+7wz/MtNNaGbFCqhNrOnIUHdK
4FFxIaHAW5aJBTwlH2EDIVNtjGdqT2kjuLZ5vqYzYONz9y88K5ddRxRji4bLKR+Pf6q7PIlWdi9F
lZ6a26LYeKzS4xbyqjyiugRL0gKu3Bi8FLOkvL7IN3TRBCxxU48qlqzRDX/90Nh2crXClCQoad99
FLdCOuAdgS22FycoK5B047hq0XZxTrQa2KmNPsV9G86UYgmgV1ay8jdp0ytHn23lFHs95tIFjwfO
TUfkAQKn8w6w4jWF0T2AmcangO2KPECgZe4IlH1Wce+ZtTHVbMKQwHIrODbBSbGkT7Sublu+a47B
ogiOScXH/MG85mjafMnCOCA6xyR7sY+l5rRfodF5ZFidRzNr14QFpOZRn1bH20G096yTvfd6pY5j
bB82G2bzjFpWh5Ir5/mmOTSU9woV01EnWRnkNcPd79g5CbjNIcOHRees6ao20iaYOHQ5P/S2zq/S
ypmkt4TcnFRoloKGa0cy/PBpwEoTFKkSVnd/JEmZ6HqcQu5W2iZQ/lKOUB4sRyi9OLXeFKc3ur8y
jPbQtfW2y1fpGcNQaaDTDHNW39c3bmnRp9EaXtqe7JUzupwLYjpM1hrq6BeF0rbbgn0uAZEz83IO
zViMLSk+C3EgHXeuhAtlzxpjp9QZsOu738OYmpJyWs3kuEqFrj2y7tbZhxPbe9R5z1H7D1qY2tSk
qaeqNdLUHlvjYNBWvA0OKqz1bCmwlH6LkVr8TFPmBIAljlqZa2MYRHFMgWvnIkV2Ry7m8RtCJuc2
BEnScO0NDgs8TSLsQKobhGa3ZGfQuhyRlkG9ys49Ac1NO8mnLP4xPlvLsKVtDWG07TriHvzCKERw
pwQnRji3VVhwASONlJPopyrKKBXiAlCnrXpIxCTwYVCTpC7yLaOkG8ty0UjGCfo6ZxV3rNloRtyZ
zHa4s3M06p3oyrlxwVrcAhFxMLX7dAvk7t4CFT95VMN3bxB0roOGHfi6pjcu2mzvppXIh23EaJk1
1NVr3LyMaEiczPZeQ3hecaTSQlNVL6LLMNuJrNkMRESJpBn6x1E9/39gHAuIz5J/9HtHt7YBv0xu
qqzm1WWriruN/HmOJQKjLk6Ra9jwUMxyuloWzRiTV+JFv+9IqxCn6D4A4TRxl4VNJrLvK5gEOE65
PE/YjYYHlt1rkfk225+l8CoVYURZSzpkZhTpbobU1bT+mi/vkqIq0RUmcRye0+3etnbTZRIrAqS8
wt95qls7l2CY3Fjf9ddtzu8+uquAXt+KZovU1DFt49t2Xbsguz0XglZgoI2nY2PMXWMw+B8ozWgk
+CAAAA==

--Boundary-00=_iYDpHChOfUbgg4m--
