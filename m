From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 2/4] git-gui i18n: Update German glossary according to mailing list discussion.
Date: Fri, 5 Oct 2007 22:39:47 +0200
Message-ID: <200710052239.47628.stimming@tuhh.de>
References: <200710052239.02492.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 05 22:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdtbS-0001Dm-Mq
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 22:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760529AbXJEUQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 16:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760548AbXJEUQr
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 16:16:47 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:35515 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759861AbXJEUQp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 16:16:45 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l95KGfk1019956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 5 Oct 2007 22:16:41 +0200
Received: from [192.168.2.102] (p54900D20.dip0.t-ipconnect.de [84.144.13.32])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l95KGdR7021441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 22:16:40 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <200710052239.02492.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60127>

 Signed-off-by: Christian Stimming <stimming@tuhh.de>

---
 po/glossary/de.po |   45 ++++++++++++++++++++++++++++++++++-----------
 1 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/po/glossary/de.po b/po/glossary/de.po
index aab3b22..054cf4d 100644
--- a/po/glossary/de.po
+++ b/po/glossary/de.po
@@ -6,7 +6,8 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui glossary\n"
-"PO-Revision-Date: 2007-07-26 14:45+0200\n"
+"POT-Creation-Date: 2007-10-05 22:30+0200\n"
+"PO-Revision-Date: 2007-10-05 22:32+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German \n"
 "MIME-Version: 1.0\n"
@@ -19,11 +20,17 @@ msgid ""
 msgstr ""
 "Deutsche =DCbersetzung.\n"
 "Andere deutsche SCM:\n"
-"  http://tortoisesvn.net/docs/release/TortoiseSVN_de/index.html und h=
ttp://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/Languages/Tortoise_d=
e.po (username=3Dguest, password empty, gut),\n"
-"  http://msdn.microsoft.com/de-de/library/ms181038(vs.80).aspx (MS Vi=
sual Source Safe, kommerziell),\n"
-"  http://cvsbook.red-bean.com/translations/german/Kap_06.html (mittel=
m=E4=DFig),\n"
-"  http://tortoisecvs.cvs.sourceforge.net/tortoisecvs/po/TortoiseCVS/d=
e_DE.po?view=3Dmarkup (mittelm=E4=DFig),\n"
-"  http://rapidsvn.tigris.org/svn/rapidsvn/trunk/src/locale/de/rapidsv=
n.po (username=3Dguest, password empty, schlecht)"
+"  http://tortoisesvn.net/docs/release/TortoiseSVN_de/index.html und h=
ttp://"
+"tortoisesvn.tigris.org/svn/tortoisesvn/trunk/Languages/Tortoise_de.po=
 "
+"(username=3Dguest, password empty, gut),\n"
+"  http://msdn.microsoft.com/de-de/library/ms181038(vs.80).aspx (MS Vi=
sual "
+"Source Safe, kommerziell),\n"
+"  http://cvsbook.red-bean.com/translations/german/Kap_06.html "
+"(mittelm=E4=DFig),\n"
+"  http://tortoisecvs.cvs.sourceforge.net/tortoisecvs/po/TortoiseCVS/d=
e_DE.po?"
+"view=3Dmarkup (mittelm=E4=DFig),\n"
+"  http://rapidsvn.tigris.org/svn/rapidsvn/trunk/src/locale/de/rapidsv=
n.po "
+"(username=3Dguest, password empty, schlecht)"
=20
 #. ""
 msgid "amend"
@@ -43,19 +50,31 @@ msgstr "verzweigen"
=20
 #. ""
 msgid "checkout [noun]"
-msgstr "Auscheck? Ausspielung? Abruf? (Source Safe: Auscheckvorgang)"
+msgstr ""
+"Arbeitskopie (Erstellung einer Arbeitskopie; Auscheck? Ausspielung? A=
bruf? "
+"Source Safe: Auscheckvorgang)"
=20
 #. "The action of updating the working tree to a revision which was st=
ored in the object database."
 msgid "checkout [verb]"
-msgstr "auschecken? ausspielen? abrufen? (Source Safe: auschecken)"
+msgstr ""
+"Arbeitskopie erstellen; Zweig umstellen [checkout a branch] (auscheck=
en? "
+"ausspielen? abrufen? Source Safe: auschecken)"
+
+#. ""
+msgid "clone [verb]"
+msgstr "kopieren"
=20
 #. "A single point in the git history."
 msgid "commit [noun]"
-msgstr "=DCbertragung (Sendung?, =DCbergabe?, Einspielung?, Ablagevorg=
ang?)"
+msgstr ""
+"Version; Eintragung; =C4nderung (Buchung?, Eintragung?, =DCbertragung=
?, "
+"Sendung?, =DCbergabe?, Einspielung?, Ablagevorgang?)"
=20
 #. "The action of storing a new snapshot of the project's state in the=
 git history."
 msgid "commit [verb]"
-msgstr "=FCbertragen (TortoiseSVN: =FCbertragen; Source Safe: eincheck=
en; senden?, =FCbergeben?, einspielen?, einpflegen?, ablegen?)"
+msgstr ""
+"eintragen (TortoiseSVN: =FCbertragen; Source Safe: einchecken; senden=
?, "
+"=FCbergeben?, einspielen?, einpflegen?, ablegen?)"
=20
 #. ""
 msgid "diff [noun]"
@@ -87,7 +106,11 @@ msgstr "zusammenf=FChren"
=20
 #. ""
 msgid "message"
-msgstr "Meldung (Nachricht?; Source Safe: Kommentar)"
+msgstr "Beschreibung (Meldung?, Nachricht?; Source Safe: Kommentar)"
+
+#. ""
+msgid "prune"
+msgstr "l=F6schen"
=20
 #. "Pulling a branch means to fetch it and merge it."
 msgid "pull"
--=20
1.5.3.rc2.6.g40240
