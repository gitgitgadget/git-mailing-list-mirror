From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 5 messages
Date: Tue,  6 Aug 2013 20:29:54 +0200
Message-ID: <1375813794-4578-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue Aug 06 20:30:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6m1K-0003XR-NI
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 20:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab3HFSaF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Aug 2013 14:30:05 -0400
Received: from mail-bk0-f47.google.com ([209.85.214.47]:40555 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756675Ab3HFSaD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 14:30:03 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg9so285514bkc.34
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=x+X5hvYmMuiVLYRSc9rxtjgyJLBSgCJ5PLpIcPDmiVA=;
        b=LlOnb5uKl/iCOIpiOiyLhxnOpMqLaADUc2N+hXdwQChlv9jvPun1eO/VG4TxeaB0v6
         RLycUszywJBICBpaykySX++SjzRmyvWow1wRVWUJEB33VKU5bP16CKEYzVvRj1jHEErK
         23WU4Wdp+dM03TtnyDprMryFfzPUzZQP8zT/PfPEIoXDS7bXwr9p2F0hakyWf0p73ASQ
         3FPK2FvS86nl6W8JQ4KnzzA9yJ7b0RZBPku4bUfYAdA2w01nj8RqBx+MZ6PmJHI4LS35
         MOukm7eJ/vOjZk0xgFqQ/AHk/wHJG+RyX0Yr2WNApP7VarY6rMRMQcg7VPWNPxCzjBZJ
         lFcA==
X-Received: by 10.205.114.144 with SMTP id fa16mr598610bkc.84.1375813802118;
        Tue, 06 Aug 2013 11:30:02 -0700 (PDT)
Received: from localhost (dslb-178-005-189-036.pools.arcor-ip.net. [178.5.189.36])
        by mx.google.com with ESMTPSA id od6sm1048744bkb.11.2013.08.06.11.30.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 11:30:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1873.gfc589a4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231773>

Translate 5 new messages came from git.pot update in b8ecf23
(l10n: git.pot: v1.8.4 round 2 (5 new, 3 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/po/de.po b/po/de.po
index 7599f9c..11dde11 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1210,11 +1210,10 @@ msgstr "Kann nicht als allerersten Commit einen=
 Revert ausf=C3=BChren."
 #: sequencer.c:1130
 msgid "Can't cherry-pick into empty head"
 msgstr "Kann nicht als allerersten Commit einen Cherry-Pick ausf=C3=BC=
hren."
=20
 #: sha1_name.c:440
-#, fuzzy
 msgid ""
 "Git normally never creates a ref that ends with 40 hex characters\n"
 "because it will be ignored when you just specify 40-hex. These refs\n=
"
 "may be created by mistake. For example,\n"
 "\n"
@@ -1232,11 +1231,11 @@ msgstr ""
 "  git checkout -b $br $(git rev-parse ...)\n"
 "\n"
 "wobei \"$br\" leer ist und eine 40-Hex-Referenz erzeugt\n"
 "wurde. Bitte pr=C3=BCfen Sie diese Referenzen und l=C3=B6schen\n"
 "Sie sie gegebenenfalls. Unterdr=C3=BCcken Sie diese Meldung\n"
-"indem Sie \"git config advice.object_name_warning false\"\n"
+"indem Sie \"git config advice.objectNameWarning false\"\n"
 "ausf=C3=BChren."
=20
 #: sha1_name.c:1097
 msgid "HEAD does not point to a branch"
 msgstr "HEAD zeigt auf keinen Branch"
@@ -4000,11 +3999,10 @@ msgstr ""
 "Sie fragten den j=C3=BCngsten Commit nachzubessern, aber das w=C3=BCr=
de diesen leer\n"
 "machen. Sie k=C3=B6nnen Ihr Kommando mit --allow-empty wiederholen, o=
der diesen\n"
 "Commit mit \"git reset HEAD^\" vollst=C3=A4ndig entfernen.\n"
=20
 #: builtin/commit.c:62
-#, fuzzy
 msgid ""
 "The previous cherry-pick is now empty, possibly due to conflict resol=
ution.\n"
 "If you wish to commit it anyway, use:\n"
 "\n"
 "    git commit --allow-empty\n"
@@ -4014,25 +4012,30 @@ msgstr ""
 "Konfliktaufl=C3=B6sung.\n"
 "Wenn Sie dies trotzdem committen wollen, benutzen Sie:\n"
 "\n"
 "    git commit --allow-empty\n"
 "\n"
-"Andernfalls benutzen Sie bitte 'git reset'\n"
=20
 #: builtin/commit.c:69
 msgid "Otherwise, please use 'git reset'\n"
-msgstr ""
+msgstr "Andernfalls benutzen Sie bitte 'git reset'\n"
=20
 #: builtin/commit.c:72
 msgid ""
 "If you wish to skip this commit, use:\n"
 "\n"
 "    git reset\n"
 "\n"
 "Then \"git cherry-pick --continue\" will resume cherry-picking\n"
 "the remaining commits.\n"
 msgstr ""
+"Wenn Sie diesen Commit auslassen m=C3=B6chten, benutzen Sie:\n"
+"\n"
+"    git reset\n"
+"\n"
+"Benutzen Sie anschlie=C3=9Fend \"git cherry-pick --continue\", um die=
\n"
+"Cherry-Pick-Operation mit den verbleibenden Commits fortzusetzen.\n"
=20
 #: builtin/commit.c:279
 msgid "failed to unpack HEAD tree object"
 msgstr "Fehler beim Entpacken des \"Tree\"-Objektes von HEAD."
=20
@@ -10040,11 +10043,10 @@ msgstr "\"autostash\" angewendet."
 #, sh-format
 msgid "Cannot store $stash_sha1"
 msgstr "Kann $stash_sha1 nicht speichern."
=20
 #: git-rebase.sh:160
-#, fuzzy
 msgid ""
 "Applying autostash resulted in conflicts.\n"
 "Your changes are safe in the stash.\n"
 "You can run \"git stash pop\" or \"git stash drop\" at any time.\n"
 msgstr ""
--=20
1.8.2.1873.gfc589a4
