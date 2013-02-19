From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 5 new messages
Date: Tue, 19 Feb 2013 18:12:46 +0100
Message-ID: <1361293966-3975-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue Feb 19 18:13:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7qkl-0005ZG-4q
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 18:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932Ab3BSRMv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2013 12:12:51 -0500
Received: from mail-bk0-f45.google.com ([209.85.214.45]:56840 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666Ab3BSRMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 12:12:50 -0500
Received: by mail-bk0-f45.google.com with SMTP id i18so3165666bkv.18
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=DZrICJKZ8yvPnM5H8xziQV3R4eiJ0n24+xP+IfwRimk=;
        b=q85c+D39Ojd9++RfBAzmUxEfHM5itQk5kYEklJ0kAKzsEwvuXbe4O33gYUU9bMsfHZ
         UHOCb4RSFGF7qp+REwitiGKBU8o9SXNWkxIKCw9jjQLnjcf/V1KhYfW2WptGZ1Av0i28
         aEvLFydEjNcBvzSBE2uN02sVPwtfNEK5u/Ww5iD8KUhkxHhyBlkTYut3rVF1PNjcYY/l
         QTKpCAtdtJ9sKeC9ZTb+IRqiJinMkbbWI979Qb5RY0oNFqaLN7I/7gF6W/mFGyH8Dpxn
         jjdUV2+6CM308tmaueccA9pjfebKzHcS5FhTTHBOz/w1hqjhGzYYPe9gti++uQCqZf7e
         bKLg==
X-Received: by 10.204.145.86 with SMTP id c22mr7090343bkv.5.1361293969160;
        Tue, 19 Feb 2013 09:12:49 -0800 (PST)
Received: from localhost (dslb-094-223-176-203.pools.arcor-ip.net. [94.223.176.203])
        by mx.google.com with ESMTPS id x18sm18406037bkw.4.2013.02.19.09.12.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Feb 2013 09:12:48 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.16.g20a599e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216635>

Translate 5 new messages came from git.pot update in 235537a
(l10n: git.pot: v1.8.2 round 3 (5 new)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/po/de.po b/po/de.po
index ed813ef..c0e5398 100644
--- a/po/de.po
+++ b/po/de.po
@@ -731,7 +731,7 @@ msgstr "    %s"
=20
 #: parse-options.c:548
 msgid "-NUM"
-msgstr ""
+msgstr "-NUM"
=20
 #: pathspec.c:83
 #, c-format
@@ -1271,9 +1271,9 @@ msgstr ""
 "wiederherzustellen)"
=20
 #: wt-status.c:879 wt-status.c:896
-#, fuzzy, c-format
+#, c-format
 msgid "You are currently rebasing branch '%s' on '%s'."
-msgstr "Sie sind gerade beim Neuaufbau."
+msgstr "Sie sind gerade beim Neuaufbau von Zweig '%s' auf '%s'."
=20
 #: wt-status.c:884 wt-status.c:901
 msgid "You are currently rebasing."
@@ -1300,10 +1300,11 @@ msgid "  (all conflicts fixed: run \"git rebase=
 --continue\")"
 msgstr "  (alle Konflikte behoben: f=C3=BChren Sie \"git rebase --cont=
inue\" aus)"
=20
 #: wt-status.c:908
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "You are currently splitting a commit while rebasing branch '%s' on '%=
s'."
-msgstr "Sie teilen gerade eine Version w=C3=A4hrend eines Neuaufbaus a=
uf."
+msgstr "Sie teilen gerade eine Version auf, w=C3=A4hrend ein Neuaufbau=
 von Zweig "
+"'%s' auf '%s' im Gange ist."
=20
 #: wt-status.c:913
 msgid "You are currently splitting a commit during a rebase."
@@ -1316,9 +1317,10 @@ msgstr ""
 "continue\" aus)"
=20
 #: wt-status.c:920
-#, fuzzy, c-format
+#, c-format
 msgid "You are currently editing a commit while rebasing branch '%s' o=
n '%s'."
-msgstr "Sie editieren gerade eine Version w=C3=A4hrend eines Neuaufbau=
s."
+msgstr "Sie editieren gerade eine Version w=C3=A4hrend eines Neuaufbau=
s von Zweig "
+"'%s' auf '%s'."
=20
 #: wt-status.c:925
 msgid "You are currently editing a commit during a rebase."
@@ -1345,9 +1347,9 @@ msgid "  (all conflicts fixed: run \"git commit\"=
)"
 msgstr "  (alle Konflikte behoben: f=C3=BChren Sie \"git commit\" aus)=
"
=20
 #: wt-status.c:958
-#, fuzzy, c-format
+#, c-format
 msgid "You are currently bisecting branch '%s'."
-msgstr "Sie sind gerade beim Halbieren."
+msgstr "Sie sind gerade beim Halbieren in Zweig '%s'."
=20
 #: wt-status.c:962
 msgid "You are currently bisecting."
--=20
1.8.2.rc0.16.g20a599e
