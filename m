From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/5] gettext: Add a skeleton po/is.po
Date: Sat, 29 May 2010 22:45:24 +0000
Message-ID: <1275173125-21010-5-git-send-email-avarab@gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 30 00:46:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIUnL-0006Bn-9o
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 00:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756945Ab0E2WqA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 May 2010 18:46:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61205 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756668Ab0E2Wpy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 18:45:54 -0400
Received: by mail-fx0-f46.google.com with SMTP id 10so1533810fxm.19
        for <git@vger.kernel.org>; Sat, 29 May 2010 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lmIFE9BT4miamnh+d1ZnIA7OYreaBXVxcI02yj/xbpM=;
        b=nrUp2ifSEq3G456cICgTmQ9dI6B2gLo8+bSxyLDsBOGIYIQ7Mxi9r+BKFyQJtD97ne
         7VvHXbS0GTfvKI1CMPFbE1ZGh6DHBTOiRehB05tOqAMF6E7jRxc/UzEc9krH4Iz96Dzh
         P/Oq8gCL9wjESQA4Vb0KrBU/3xSTX+xO25rjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KFNXgqjbUN86TsiLioy77cuHHBaYF1H3r2DOBidKl28/puhAxWv+LfAZ4jevTZRq7F
         /bL/5zxAjcR6AYnUy1zlzgfAnQX10o1oZxd1/YErWkQ6NqnlI3QdezL5N/xbFZnll4HA
         pOl/9QbiCVicldpkXB21NrNlkGVpJw7e+sBVE=
Received: by 10.223.26.69 with SMTP id d5mr2860458fac.20.1275173153328;
        Sat, 29 May 2010 15:45:53 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id y12sm24351890faj.17.2010.05.29.15.45.51
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 15:45:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.242.ge2b63.dirty
In-Reply-To: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147977>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/is.po |  288 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 288 insertions(+), 0 deletions(-)
 create mode 100644 po/is.po

diff --git a/po/is.po b/po/is.po
new file mode 100644
index 0000000..4aac4e9
--- /dev/null
+++ b/po/is.po
@@ -0,0 +1,288 @@
+# SOME DESCRIPTIVE TITLE.
+# Copyright (C) YEAR Free Software Foundation, Inc.
+# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: PACKAGE VERSION\n"
+"PO-Revision-Date: YEAR-MO-DA HO:MI +ZONE\n"
+"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
+"Language-Team: LANGUAGE <LL@li.org>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DCHARSET\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+# SOME DESCRIPTIVE TITLE.#~=20
+# Copyright (C) YEAR Free Software Foundation, Inc.#~=20
+# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.#~=20
+##~=20
+#, fuzzy#~=20
+msgid ""#~=20
+msgstr ""#~=20
+"Project-Id-Version: Git\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2010-05-29 21:17+0000\n"
+"PO-Revision-Date: \n"
+"Last-Translator: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
=2Ecom>\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"X-Poedit-Language: English\n"
+"X-Poedit-SourceCharset: utf-8\n"
+
+#: wt-status.c:53
+msgid "# Unmerged paths:"
+msgstr ""
+
+#: wt-status.c:59 wt-status.c:76
+#, c-format
+msgid "#   (use \"git reset %s <file>...\" to unstage)"
+msgstr ""
+
+#: wt-status.c:61 wt-status.c:78
+msgid "#   (use \"git rm --cached <file>...\" to unstage)"
+msgstr ""
+
+#: wt-status.c:62
+msgid "#   (use \"git add/rm <file>...\" as appropriate to mark resolu=
tion)"
+msgstr ""
+
+#: wt-status.c:63 wt-status.c:79 wt-status.c:98 wt-status.c:110
+#: wt-status.c:115 wt-status.c:638 wt-status.c:640
+msgid "#"
+msgstr ""
+
+#: wt-status.c:70
+msgid "# Changes to be committed:"
+msgstr ""
+
+#: wt-status.c:88
+msgid "# Changed but not updated:"
+msgstr ""
+
+#: wt-status.c:92
+msgid "#   (use \"git add <file>...\" to update what will be committed=
)"
+msgstr ""
+
+#: wt-status.c:94
+msgid "#   (use \"git add/rm <file>...\" to update what will be commit=
ted)"
+msgstr ""
+
+#: wt-status.c:95
+msgid ""
+"#   (use \"git checkout -- <file>...\" to discard changes in working =
"
+"directory)"
+msgstr ""
+
+#: wt-status.c:97
+msgid "#   (commit or discard the untracked or modified content in sub=
modules)"
+msgstr ""
+
+#: wt-status.c:106
+#, c-format
+msgid "# %s files:"
+msgstr ""
+
+#: wt-status.c:109
+#, c-format
+msgid "#   (use \"git %s <file>...\" to include in what will be commit=
ted)"
+msgstr ""
+
+#: wt-status.c:126
+msgid "bug"
+msgstr ""
+
+#: wt-status.c:129 wt-status.c:182
+msgid "#\t"
+msgstr ""
+
+#: wt-status.c:131
+msgid "both deleted:"
+msgstr ""
+
+#: wt-status.c:132
+msgid "added by us:"
+msgstr ""
+
+#: wt-status.c:133
+msgid "deleted by them:"
+msgstr ""
+
+#: wt-status.c:134
+msgid "added by them:"
+msgstr ""
+
+#: wt-status.c:135
+msgid "deleted by us:"
+msgstr ""
+
+#: wt-status.c:136
+msgid "both added:"
+msgstr ""
+
+#: wt-status.c:137
+msgid "both modified:"
+msgstr ""
+
+#: wt-status.c:139
+#, c-format
+msgid "%-20s%s\n"
+msgstr ""
+
+#: wt-status.c:165
+msgid " ("
+msgstr ""
+
+#: wt-status.c:167
+msgid "new commits, "
+msgstr ""
+
+#: wt-status.c:169
+msgid "modified content, "
+msgstr ""
+
+#: wt-status.c:171
+msgid "untracked content, "
+msgstr ""
+
+#: wt-status.c:185
+#, c-format
+msgid "new file:   %s"
+msgstr ""
+
+#: wt-status.c:188
+#, c-format
+msgid "copied:     %s -> %s"
+msgstr ""
+
+#: wt-status.c:191
+#, c-format
+msgid "deleted:    %s"
+msgstr ""
+
+#: wt-status.c:194
+#, c-format
+msgid "modified:   %s"
+msgstr ""
+
+#: wt-status.c:197
+#, c-format
+msgid "renamed:    %s -> %s"
+msgstr ""
+
+#: wt-status.c:200
+#, c-format
+msgid "typechange: %s"
+msgstr ""
+
+#: wt-status.c:203
+#, c-format
+msgid "unknown:    %s"
+msgstr ""
+
+#: wt-status.c:206
+#, c-format
+msgid "unmerged:   %s"
+msgstr ""
+
+#: wt-status.c:209
+#, c-format
+msgid "bug: unhandled diff status %c"
+msgstr ""
+
+#: wt-status.c:212
+#, c-format
+msgid "%s"
+msgstr ""
+
+#: wt-status.c:215
+#, c-format
+msgid "\n"
+msgstr ""
+
+#: wt-status.c:622
+msgid "On branch "
+msgstr "=C3=81 greininni "
+
+#: wt-status.c:629
+msgid "Not currently on any branch."
+msgstr "Ekki =C3=A1 neinni grein."
+
+#: wt-status.c:639
+msgid "# Initial commit"
+msgstr ""
+
+#: wt-status.c:651
+msgid "Untracked"
+msgstr ""
+
+#: wt-status.c:651
+msgid "add"
+msgstr ""
+
+#: wt-status.c:653
+msgid "Ignored"
+msgstr ""
+
+#: wt-status.c:653
+msgid "add -f"
+msgstr ""
+
+#: wt-status.c:655
+#, c-format
+msgid "# Untracked files not listed%s\n"
+msgstr ""
+
+#: wt-status.c:657
+msgid " (use -u option to show untracked files)"
+msgstr ""
+
+#: wt-status.c:663
+#, c-format
+msgid "# No changes\n"
+msgstr "# Engar breytingar\n"
+
+#: wt-status.c:667
+#, c-format
+msgid "no changes added to commit%s\n"
+msgstr ""
+
+#: wt-status.c:669
+msgid " (use \"git add\" and/or \"git commit -a\")"
+msgstr ""
+
+#: wt-status.c:671
+#, c-format
+msgid "nothing added to commit but untracked files present%s\n"
+msgstr ""
+
+#: wt-status.c:673
+msgid " (use \"git add\" to track)"
+msgstr ""
+
+#: wt-status.c:676
+msgid " (create/copy files and use \"git add\" to track)"
+msgstr ""
+
+#: wt-status.c:678 wt-status.c:681
+#, c-format
+msgid "nothing to commit%s\n"
+msgstr ""
+
+#: wt-status.c:679
+msgid " (use -u to show untracked files)"
+msgstr ""
+
+#: wt-status.c:682
+msgid " (working directory clean)"
+msgstr ""
+
+#: git-pull.sh:124
+msgid "Fetching tags only, you probably meant:"
+msgstr ""
+
+#: git-pull.sh:125
+msgid "  git fetch --tags"
+msgstr ""
--=20
1.7.1.242.ge2b63.dirty
