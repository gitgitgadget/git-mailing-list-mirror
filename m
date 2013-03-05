From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 1 new message
Date: Tue,  5 Mar 2013 06:39:10 +0100
Message-ID: <1362461950-3055-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue Mar 05 06:39:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCkbG-0006My-3l
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 06:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009Ab3CEFjQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Mar 2013 00:39:16 -0500
Received: from mail-ea0-f178.google.com ([209.85.215.178]:36882 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab3CEFjP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 00:39:15 -0500
Received: by mail-ea0-f178.google.com with SMTP id a14so1048370eaa.23
        for <git@vger.kernel.org>; Mon, 04 Mar 2013 21:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Zu9s4s597d8dqO5+JJm92BJCZkgxUR4JoGA22w7LYDI=;
        b=y7/UluBX6bgUZXVZ4TIIYdc1b+yj5KoEZMc1ooSU8c7acwTWDT0O0S+97hLkUtQm+e
         0bXclsn11YUSN26QYXhyYKvI28ayX3i7Rqc/nLNRdkqqCeAX3YAhfCY0+Z5jcXUlNoXe
         vkoxMpf2wGfSOAiMgZetujkhQazmAC0LhVztv2cFbQpxyqd8qW6mNfjJb4AG3hFwR7Sd
         +7PdWKaxlucSmZmvsRkgxoTSP0xUdX7X9bVpVr1DLA/nWGxkuPDC3LlN8r7CBYihYIkI
         eQkzL0L0EGnfxDeV+fPOUyOI8GvsNu8F6l3Mtql+/VWR+JBHC9zaOCS2SsBzxz5V31as
         Fcow==
X-Received: by 10.14.210.132 with SMTP id u4mr66408039eeo.19.1362461954313;
        Mon, 04 Mar 2013 21:39:14 -0800 (PST)
Received: from localhost (dslb-178-012-126-061.pools.arcor-ip.net. [178.12.126.61])
        by mx.google.com with ESMTPS id u44sm35554765eel.7.2013.03.04.21.39.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 Mar 2013 21:39:13 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc2.4.g7799588
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217430>

Translate 1 new message came from git.pot update in
ed1ddaf (l10n: git.pot: v1.8.2 round 4 (1 changed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index 37aa24d..83c30b1 100644
--- a/po/de.po
+++ b/po/de.po
@@ -126,12 +126,11 @@ msgid "path to the remote git-upload-archive comm=
and"
 msgstr "Pfad zum externen \"git-upload-archive\"-Programm"
=20
 #: attr.c:259
-#, fuzzy
 msgid ""
 "Negative patterns are ignored in git attributes\n"
 "Use '\\!' for literal leading exclamation."
 msgstr ""
-"Verneinende Muster sind in Git-Attributen verboten.\n"
+"Verneinende Muster werden in Git-Attributen ignoriert.\n"
 "Benutzen Sie '\\!' f=C3=BCr f=C3=BChrende Ausrufezeichen."
=20
 #: bundle.c:36
--=20
1.8.2.rc2.4.g7799588
