From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] git-gui: Update German translation.
Date: Sat, 16 Feb 2008 21:58:22 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200802162158.22924.stimming@tuhh.de>
References: <200802162156.23436.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_u50tHhMRwL8vyxO"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 22:01:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQU9u-0003fl-J0
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 22:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585AbYBPVAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 16:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756553AbYBPVAo
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 16:00:44 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:52394 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581AbYBPVAm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 16:00:42 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m1GL0UmL024352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 16 Feb 2008 22:00:31 +0100
Received: from [192.168.2.102] (p549030FB.dip0.t-ipconnect.de [84.144.48.251])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m1GL0SqR002378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 16 Feb 2008 22:00:30 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <200802162156.23436.stimming@tuhh.de>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74077>

--Boundary-00=_u50tHhMRwL8vyxO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
Attached this and previous patch as tarball because of=20
whitespace yadda yadda :-)

 po/de.po          |   70 +++++++++++++++++++++++++++++++++++--------------=
=2D--
 po/glossary/de.po |    4 +-
 2 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/po/de.po b/po/de.po
index d7c38f9..e84e1c7 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2008-02-02 10:14+0100\n"
=2D"PO-Revision-Date: 2008-02-02 10:18+0100\n"
+"POT-Creation-Date: 2008-02-16 21:24+0100\n"
+"PO-Revision-Date: 2008-02-16 21:52+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -653,7 +653,7 @@ msgstr "Lokale Zweige"
=20
 #: lib/branch_delete.tcl:52
 msgid "Delete Only If Merged Into"
=2Dmsgstr "Nur l=F6schen, wenn darin zusammengef=FChrt"
+msgstr "Nur l=F6schen, wenn zusammengef=FChrt nach"
=20
 #: lib/branch_delete.tcl:54
 msgid "Always (Do not perform merge test.)"
@@ -1292,19 +1292,19 @@ msgstr "Warning: Tcl/Tk unterst=FCtzt die Zeichenco=
dierung =BB%s=AB nicht."
=20
 #: lib/commit.tcl:221
 msgid "Calling pre-commit hook..."
=2Dmsgstr ""
+msgstr "Aufrufen der Vor-Eintragen-Kontrolle..."
=20
 #: lib/commit.tcl:236
 msgid "Commit declined by pre-commit hook."
=2Dmsgstr ""
+msgstr "Eintragen abgelehnt durch Vor-Eintragen-Kontrolle (=BBpre-commit h=
ook=AB)."
=20
 #: lib/commit.tcl:259
 msgid "Calling commit-msg hook..."
=2Dmsgstr ""
+msgstr "Aufrufen der Versionsbeschreibungs-Kontrolle..."
=20
 #: lib/commit.tcl:274
 msgid "Commit declined by commit-msg hook."
=2Dmsgstr ""
+msgstr "Eintragen abgelehnt durch Versionsbeschreibungs-Kontrolle (=BBcomm=
it-message hook=AB)."
=20
 #: lib/commit.tcl:287
 msgid "Committing changes..."
@@ -1389,7 +1389,7 @@ msgstr "Festplattenplatz von komprimierten Objekten"
=20
 #: lib/database.tcl:48
 msgid "Packed objects waiting for pruning"
=2Dmsgstr "Komprimierte Objekte, die zum Entfernen vorgesehen sind"
+msgstr "Komprimierte Objekte, die zum Aufr=E4umen vorgesehen sind"
=20
 #: lib/database.tcl:49
 msgid "Garbage files"
@@ -1622,10 +1622,10 @@ msgstr "%s von %s"
=20
 #: lib/merge.tcl:119
 #, tcl-format
=2Dmsgid "Merging %s and %s"
=2Dmsgstr "Zusammenf=FChren von %s und %s"
+msgid "Merging %s and %s..."
+msgstr "Zusammenf=FChren von %s und %s..."
=20
=2D#: lib/merge.tcl:131
+#: lib/merge.tcl:130
 msgid "Merge completed successfully."
 msgstr "Zusammenf=FChren erfolgreich abgeschlossen."
=20
@@ -1636,7 +1636,7 @@ msgstr "Zusammenf=FChren fehlgeschlagen. Konfliktaufl=
=F6sung ist notwendig."
 #: lib/merge.tcl:158
 #, tcl-format
 msgid "Merge Into %s"
=2Dmsgstr "Zusammenf=FChren in %s"
+msgstr "Zusammenf=FChren in =BB%s=AB"
=20
 #: lib/merge.tcl:177
 msgid "Revision To Merge"
@@ -1741,7 +1741,7 @@ msgstr "Auf Datei=E4nderungsdatum verlassen"
=20
 #: lib/option.tcl:111
 msgid "Prune Tracking Branches During Fetch"
=2Dmsgstr "=DCbernahmezweige entfernen w=E4hrend Anforderung"
+msgstr "=DCbernahmezweige aufr=E4umen w=E4hrend Anforderung"
=20
 #: lib/option.tcl:112
 msgid "Match Tracking Branches"
@@ -1755,7 +1755,11 @@ msgstr "Anzahl der Kontextzeilen beim Vergleich"
 msgid "New Branch Name Template"
 msgstr "Namensvorschlag f=FCr neue Zweige"
=20
=2D#: lib/option.tcl:176
+#: lib/option.tcl:191
+msgid "Spelling Dictionary:"
+msgstr "W=F6rterbuch Rechtschreibpr=FCfung:"
+
+#: lib/option.tcl:215
 msgid "Change Font"
 msgstr "Schriftart =E4ndern"
=20
@@ -1778,11 +1782,11 @@ msgstr "Optionen konnten nicht gespeichert werden:"
=20
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Remote Branch"
=2Dmsgstr "Zweig aus anderem Projektarchiv l=F6schen"
+msgstr "Zweig in anderem Projektarchiv l=F6schen"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
=2Dmsgstr "Von Projektarchiv"
+msgstr "In Projektarchiv"
=20
 #: lib/remote_branch_delete.tcl:50 lib/transport.tcl:123
 msgid "Remote:"
@@ -1790,7 +1794,7 @@ msgstr "Anderes Archiv:"
=20
 #: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
 msgid "Arbitrary URL:"
=2Dmsgstr "Kommunikation mit URL:"
+msgstr "Archiv-URL:"
=20
 #: lib/remote_branch_delete.tcl:84
 msgid "Branches"
@@ -1798,11 +1802,11 @@ msgstr "Zweige"
=20
 #: lib/remote_branch_delete.tcl:109
 msgid "Delete Only If"
=2Dmsgstr "L=F6schen, falls"
+msgstr "Nur l=F6schen, wenn"
=20
 #: lib/remote_branch_delete.tcl:111
 msgid "Merged Into:"
=2Dmsgstr "Zusammenf=FChren mit:"
+msgstr "Zusammengef=FChrt mit:"
=20
 #: lib/remote_branch_delete.tcl:119
 msgid "Always (Do not perform merge checks)"
@@ -1864,7 +1868,7 @@ msgstr "=BB%s=AB laden..."
=20
 #: lib/remote.tcl:165
 msgid "Prune from"
=2Dmsgstr "Entfernen von"
+msgstr "Aufr=E4umen von"
=20
 #: lib/remote.tcl:170
 msgid "Fetch from"
@@ -1882,6 +1886,26 @@ msgstr "Fehler beim Schreiben der Verkn=FCpfung:"
 msgid "Cannot write icon:"
 msgstr "Fehler beim Erstellen des Icons:"
=20
+#: lib/spellcheck.tcl:37
+msgid "Not connected to aspell"
+msgstr "Keine Verbindung zu =BBaspell=AB"
+
+#: lib/spellcheck.tcl:41
+msgid "Unrecognized aspell version"
+msgstr "Unbekannte Version von =BBaspell=AB"
+
+#: lib/spellcheck.tcl:135
+msgid "No Suggestions"
+msgstr "Keine Vorschl=E4ge"
+
+#: lib/spellcheck.tcl:336
+msgid "Unexpected EOF from aspell"
+msgstr "Unerwartetes EOF von =BBaspell=AB"
+
+#: lib/spellcheck.tcl:340
+msgid "Spell Checker Failed"
+msgstr "Rechtschreibpr=FCfung fehlgeschlagen"
+
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
@@ -1900,12 +1924,12 @@ msgstr "Neue =C4nderungen von =BB%s=AB holen"
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
=2Dmsgstr "Entfernen von =BB%s=AB aus anderem Archiv"
+msgstr "Aufr=E4umen von =BB%s=AB"
=20
 #: lib/transport.tcl:19
 #, tcl-format
 msgid "Pruning tracking branches deleted from %s"
=2Dmsgstr "=DCbernahmezweige entfernen, die in =BB%s=AB gel=F6scht wurden"
+msgstr "=DCbernahmezweige aufr=E4umen und entfernen, die in =BB%s=AB gel=
=F6scht wurden"
=20
 #: lib/transport.tcl:25 lib/transport.tcl:71
 #, tcl-format
@@ -1928,7 +1952,7 @@ msgstr "Zweige versenden"
=20
 #: lib/transport.tcl:103
 msgid "Source Branches"
=2Dmsgstr "Herkunftszweige"
+msgstr "Lokale Zweige"
=20
 #: lib/transport.tcl:120
 msgid "Destination Repository"
diff --git a/po/glossary/de.po b/po/glossary/de.po
index 0b33c57..35764d1 100644
=2D-- a/po/glossary/de.po
+++ b/po/glossary/de.po
@@ -7,7 +7,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui glossary\n"
 "POT-Creation-Date: 2008-01-07 21:20+0100\n"
=2D"PO-Revision-Date: 2008-01-15 20:32+0100\n"
+"PO-Revision-Date: 2008-02-16 21:48+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German \n"
 "MIME-Version: 1.0\n"
@@ -114,7 +114,7 @@ msgstr "Beschreibung (Meldung?, Nachricht?; Source Safe=
: Kommentar)"
=20
 #. "Deletes all stale tracking branches under <name>. These stale branches=
 have already been removed from the remote repository referenced by <name>,=
 but are still locally available in 'remotes/<name>'."
 msgid "prune"
=2Dmsgstr "entfernen"
+msgstr "aufr=E4umen (entfernen?)"
=20
 #. "Pulling a branch means to fetch it and merge it."
 msgid "pull"
=2D-=20
1.5.4.2.g41ac4


--Boundary-00=_u50tHhMRwL8vyxO
Content-Type: application/x-tgz;
  name="0001-git-gui-i18n.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-git-gui-i18n.tgz"

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
Q98SCQBQAAA=

--Boundary-00=_u50tHhMRwL8vyxO--
