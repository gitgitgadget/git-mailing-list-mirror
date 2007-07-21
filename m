From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 5/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 14:41:24 +0200
Message-ID: <200707211441.25119.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707211436.44672.stimming@tuhh.de> <200707211437.43524.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 14:41:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICEGs-00015O-2p
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 14:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762462AbXGUMlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Jul 2007 08:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762619AbXGUMlO
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 08:41:14 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:36986 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761875AbXGUMlO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 08:41:14 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6LCf9id031767
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 21 Jul 2007 14:41:09 +0200
Received: from [192.168.2.102] (p549012DA.dip0.t-ipconnect.de [84.144.18.218])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6LCf8CR008912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 14:41:09 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <200707211437.43524.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53164>

=46rom f074190d3bf1c08cd833afaa7ba42731b1e7f572 Mon Sep 17 00:00:00 200=
1
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Sat, 21 Jul 2007 14:39:24 +0200
Subject: [PATCH] Add glossary to ensure consistent translations.


Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
And last but not least an initial list of the most important terms thro=
ughout git=20
and git-gui; out of convenience I've already included my decisions on G=
erman=20
translation wordings but in the future those translations will probably=
 be collected=20
elsewhere.

 po/glossary.csv |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 po/glossary.csv

diff --git a/po/glossary.csv b/po/glossary.csv
new file mode 100644
index 0000000..e6ffe46
--- /dev/null
+++ b/po/glossary.csv
@@ -0,0 +1,24 @@
+"English Term"	"de translation"
+"amend"	"erg=E4nzen"
+"annotate"	"annotieren"
+"branch"	"Zweig, verzweigen"
+"checkout"	"Auschecken"
+"commit"	"=FCbertragen (senden?, =FCbergeben?)"
+"diff"	"vergleichen"
+"fetch"	"holen"
+"merge"	"zusammenf=FChren"
+"message"	"Meldung"
+"pull"	"ziehen (=FCbernehmen?)"
+"push"	"schieben (hochladen? verschicken?)"
+"redo"	"Wiederholen"
+"repository"	"Projektarchiv"
+"reset"	"Zur=FCcksetzen"
+"revert"	"zur=FCckkehren"
+"revision"	"Revision"
+"sign off"	"freizeichnen"
+"staging area"	"Bereitstellung"
+"status"	"Status"
+"tag"	"Markierung, markieren"
+"undo"	"R=FCckg=E4ngig"
+"update"	"aktualisieren"
+"working copy"	"Arbeitskopie"
--=20
1.5.2
