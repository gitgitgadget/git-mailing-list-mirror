From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] gitk: Add accelerator to German locale
Date: Tue, 20 Oct 2015 14:33:04 +0200
Message-ID: <1445344384-12762-5-git-send-email-tiwai@suse.de>
References: <1445344384-12762-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 14:34:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoW6y-0006hp-NZ
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 14:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbbJTMdp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2015 08:33:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35275 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbbJTMdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 08:33:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C3264ACD3;
	Tue, 20 Oct 2015 12:33:16 +0000 (UTC)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1445344384-12762-1-git-send-email-tiwai@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279909>

Assigned either to the first letter or some unique letter.  At least
there are no conflicts, as far as I see...

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 gitk-git/po/de.po | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/gitk-git/po/de.po b/gitk-git/po/de.po
index 56c053b98428..d9ba4052e20b 100644
--- a/gitk-git/po/de.po
+++ b/gitk-git/po/de.po
@@ -9,7 +9,7 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2015-05-17 14:32+1000\n"
-"PO-Revision-Date: 2010-01-27 20:27+0100\n"
+"PO-Revision-Date: 2015-10-20 14:20+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "Language: \n"
@@ -90,71 +90,71 @@ msgstr "Abbrechen"
=20
 #: gitk:2069
 msgid "&Update"
-msgstr "Aktualisieren"
+msgstr "&Aktualisieren"
=20
 #: gitk:2070
 msgid "&Reload"
-msgstr "Neu laden"
+msgstr "&Neu laden"
=20
 #: gitk:2071
 msgid "Reread re&ferences"
-msgstr "Zweige neu laden"
+msgstr "&Zweige neu laden"
=20
 #: gitk:2072
 msgid "&List references"
-msgstr "Zweige/Markierungen auflisten"
+msgstr "Zweige/Markierungen auf&listen"
=20
 #: gitk:2074
 msgid "Start git &gui"
-msgstr "=C2=BBgit gui=C2=AB starten"
+msgstr "=C2=BBgit &gui=C2=AB starten"
=20
 #: gitk:2076
 msgid "&Quit"
-msgstr "Beenden"
+msgstr "&Beenden"
=20
 #: gitk:2068
 msgid "&File"
-msgstr "Datei"
+msgstr "&Datei"
=20
 #: gitk:2080
 msgid "&Preferences"
-msgstr "Einstellungen"
+msgstr "&Einstellungen"
=20
 #: gitk:2079
 msgid "&Edit"
-msgstr "Bearbeiten"
+msgstr "&Bearbeiten"
=20
 #: gitk:2084
 msgid "&New view..."
-msgstr "Neue Ansicht ..."
+msgstr "&Neue Ansicht ..."
=20
 #: gitk:2085
 msgid "&Edit view..."
-msgstr "Ansicht bearbeiten ..."
+msgstr "Ansicht &bearbeiten ..."
=20
 #: gitk:2086
 msgid "&Delete view"
-msgstr "Ansicht entfernen"
+msgstr "Ansicht &entfernen"
=20
 #: gitk:2088 gitk:4043
 msgid "&All files"
-msgstr "Alle Dateien"
+msgstr "&Alle Dateien"
=20
 #: gitk:2083 gitk:4067
 msgid "&View"
-msgstr "Ansicht"
+msgstr "&Ansicht"
=20
 #: gitk:2093 gitk:2103 gitk:3012
 msgid "&About gitk"
-msgstr "=C3=9Cber gitk"
+msgstr "=C3=9Cber &gitk"
=20
 #: gitk:2094 gitk:2108
 msgid "&Key bindings"
-msgstr "Tastenk=C3=BCrzel"
+msgstr "&Tastenk=C3=BCrzel"
=20
 #: gitk:2092 gitk:2107
 msgid "&Help"
-msgstr "Hilfe"
+msgstr "&Hilfe"
=20
 #: gitk:2185 gitk:8652
 msgid "SHA1 ID:"
--=20
2.6.1
