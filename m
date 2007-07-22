From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Add it.po file
Date: Sun, 22 Jul 2007 12:40:37 +0200
Message-ID: <20070722124037.68f209cf@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 12:40:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICYrl-0003J4-2M
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 12:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597AbXGVKkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 06:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbXGVKkl
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 06:40:41 -0400
Received: from hu-out-0506.google.com ([72.14.214.232]:56795 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710AbXGVKkk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 06:40:40 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1020328hue
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 03:40:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=o0Yr/wZZwiu6IH6+kDFSfdV4qbaQwUmtQSdSh/Oy20qU+JBdKWI0d40tLiTlWg667SFUDVm54XsX5HDRlCTM3sYjkX4tY9Rz1sGA7IVJfMQLXuqPN/8u7MB1uncGKIV3ymp6P9ZAAEtW7uXMxfpUaaB0W3PPnJ9vchkJa0Z3DFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=TRp2JVaCbpS8vPGJj+O23zTHG/r7AzK2N3EFwAde8AIMuUpJTWgq+eb7bXAD2hRJCK96+OoKyQcjRRzzbTbDhd8VmnD7euZj+i7KSuAxvrc85U+hSqVAIJfNQ+Q+Qe5WuOWFfSXKOoZrfLdUxGgQz6r98y267FBB9k5RGsqFDU0=
Received: by 10.86.57.9 with SMTP id f9mr1657795fga.1185100838526;
        Sun, 22 Jul 2007 03:40:38 -0700 (PDT)
Received: from paolo-desktop ( [82.48.1.34])
        by mx.google.com with ESMTPS id 5sm5150080nfv.2007.07.22.03.40.36
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2007 03:40:37 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53245>

This patch add a file, it.po that will be translated in Italian with the following patch

---
 po/it.po |  258 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 258 insertions(+), 0 deletions(-)
 create mode 100644 po/it.po

diff --git a/po/it.po b/po/it.po
new file mode 100644
index 0000000..e8b8cdb
--- /dev/null
+++ b/po/it.po
@@ -0,0 +1,258 @@
+# SOME DESCRIPTIVE TITLE.
+# Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
+# This file is distributed under the same license as the PACKAGE package.
+# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: PACKAGE VERSION\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-07-21 20:31+0100\n"
+"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
+"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
+"Language-Team: LANGUAGE <LL@li.org>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=CHARSET\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: git-gui.sh:1669
+msgid "Repository"
+msgstr ""
+
+#: git-gui.sh:1670
+msgid "Edit"
+msgstr ""
+
+#: git-gui.sh:1672
+msgid "Branch"
+msgstr ""
+
+#: git-gui.sh:1675 git-gui.sh:1853 git-gui.sh:2192
+msgid "Commit"
+msgstr ""
+
+#: git-gui.sh:1678
+msgid "Merge"
+msgstr ""
+
+#: git-gui.sh:1679
+msgid "Fetch"
+msgstr ""
+
+#: git-gui.sh:1680 git-gui.sh:2198
+msgid "Push"
+msgstr ""
+
+#: git-gui.sh:1689
+msgid "Browse Current Branch's Files"
+msgstr ""
+
+#: git-gui.sh:1698
+msgid "Visualize Current Branch's History"
+msgstr ""
+
+#: git-gui.sh:1702
+msgid "Visualize All Branch History"
+msgstr ""
+
+#: git-gui.sh:1707
+msgid "Database Statistics"
+msgstr ""
+
+#: git-gui.sh:1710
+msgid "Compress Database"
+msgstr ""
+
+#: git-gui.sh:1713
+msgid "Verify Database"
+msgstr ""
+
+#: git-gui.sh:1720 git-gui.sh:1724 git-gui.sh:1728
+msgid "Create Desktop Icon"
+msgstr ""
+
+#: git-gui.sh:1733
+msgid "Quit"
+msgstr ""
+
+#: git-gui.sh:1740
+msgid "Undo"
+msgstr ""
+
+#: git-gui.sh:1743
+msgid "Redo"
+msgstr ""
+
+#: git-gui.sh:1747 git-gui.sh:2262
+msgid "Cut"
+msgstr ""
+
+#: git-gui.sh:1750 git-gui.sh:2265 git-gui.sh:2336 git-gui.sh:2408
+msgid "Copy"
+msgstr ""
+
+#: git-gui.sh:1753 git-gui.sh:2268
+msgid "Paste"
+msgstr ""
+
+#: git-gui.sh:1756 git-gui.sh:2271
+msgid "Delete"
+msgstr ""
+
+#: git-gui.sh:1760 git-gui.sh:2275 git-gui.sh:2412
+msgid "Select All"
+msgstr ""
+
+#: git-gui.sh:1769
+msgid "Create..."
+msgstr ""
+
+#: git-gui.sh:1775
+msgid "Checkout..."
+msgstr ""
+
+#: git-gui.sh:1781
+msgid "Rename..."
+msgstr ""
+
+#: git-gui.sh:1786 git-gui.sh:1884
+msgid "Delete..."
+msgstr ""
+
+#: git-gui.sh:1791
+msgid "Reset..."
+msgstr ""
+
+#: git-gui.sh:1803 git-gui.sh:2209
+msgid "New Commit"
+msgstr ""
+
+#: git-gui.sh:1811 git-gui.sh:2216
+msgid "Amend Last Commit"
+msgstr ""
+
+#: git-gui.sh:1820 git-gui.sh:2176
+msgid "Rescan"
+msgstr ""
+
+#: git-gui.sh:1826
+msgid "Add To Commit"
+msgstr ""
+
+#: git-gui.sh:1831
+msgid "Add Existing To Commit"
+msgstr ""
+
+#: git-gui.sh:1837
+msgid "Unstage From Commit"
+msgstr ""
+
+#: git-gui.sh:1842
+msgid "Revert Changes"
+msgstr ""
+
+#: git-gui.sh:1849 git-gui.sh:2188 git-gui.sh:2286
+msgid "Sign Off"
+msgstr ""
+
+#: git-gui.sh:1864
+msgid "Local Merge..."
+msgstr ""
+
+#: git-gui.sh:1869
+msgid "Abort Merge..."
+msgstr ""
+
+#: git-gui.sh:1881
+msgid "Push..."
+msgstr ""
+
+#: git-gui.sh:1891
+msgid "Apple"
+msgstr ""
+
+#: git-gui.sh:1894 git-gui.sh:1941
+#, tcl-format
+msgid "About %s"
+msgstr ""
+
+#: git-gui.sh:1896 git-gui.sh:1902 git-gui.sh:2454
+msgid "Options..."
+msgstr ""
+
+#: git-gui.sh:1937
+msgid "Help"
+msgstr ""
+
+#: git-gui.sh:1978
+msgid "Online Documentation"
+msgstr ""
+
+#: git-gui.sh:2094
+msgid "Current Branch:"
+msgstr ""
+
+#: git-gui.sh:2115
+msgid "Staged Changes (Will Be Committed)"
+msgstr ""
+
+#: git-gui.sh:2135
+msgid "Unstaged Changes (Will Not Be Committed)"
+msgstr ""
+
+#: git-gui.sh:2182
+msgid "Add Existing"
+msgstr ""
+
+#: git-gui.sh:2228
+msgid "Initial Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2229
+msgid "Amended Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2230
+msgid "Amended Initial Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2231
+msgid "Amended Merge Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2232
+msgid "Merge Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2233
+msgid "Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2278 git-gui.sh:2416
+msgid "Copy All"
+msgstr ""
+
+#: git-gui.sh:2404
+msgid "Refresh"
+msgstr ""
+
+#: git-gui.sh:2425
+msgid "Apply/Reverse Hunk"
+msgstr ""
+
+#: git-gui.sh:2431
+msgid "Decrease Font Size"
+msgstr ""
+
+#: git-gui.sh:2435
+msgid "Increase Font Size"
+msgstr ""
+
+#: git-gui.sh:2440
+msgid "Show Less Context"
+msgstr ""
+
+#: git-gui.sh:2447
+msgid "Show More Context"
+msgstr ""
-- 
1.5.3.rc2.29.gc4640f
