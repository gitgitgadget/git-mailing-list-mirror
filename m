From: Osamu OKANO <okano.osamu@gmail.com>
Subject: [PATCH 3/7] cp git-stage.pot ja/git-stage.po
Date: Fri, 13 May 2011 22:14:14 +0900
Message-ID: <1305292458-3920-4-git-send-email-okano.osamu@gmail.com>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Cc: Osamu OKANO <okano.osamu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 15:15:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKsD1-0006sv-GT
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 15:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578Ab1EMNOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 09:14:45 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62863 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759311Ab1EMNOk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 09:14:40 -0400
Received: by pwi15 with SMTP id 15so1169910pwi.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=wzsnaG7ioj49hnO4HyY8mL3JeR4jWBT2rULXC3YMK/c=;
        b=BompPfaUZeQysFR4N3SzCAy0EmaovS2t1X+QDcbTrKlyIS8hZXXx4jomg1mWCNRu9O
         MBlk1zqCD3WGAajcptw3XpUSda1AprAupmkAygjEgaJrIkYOcyBlAUXczs0f5yMlAiar
         qzYyb8NQxFQWm88wP4sxZtqXRbCc3mVi/BiiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fTwOUC5iNWW0JBEyjZIiEjsOxb3hjwHcBfNitmotg7/3qZsHAVgdYPuE9j+GhzphME
         8xvK671vssEyG1XZ8labKagZ9aX7TtYrcD9SdmScrVnuVTZrCioA/j33GO1fFCe2GTna
         3yFWEovSyIJqV8EuVcoXMKpOMueNBFU7rAN6Q=
Received: by 10.68.19.131 with SMTP id f3mr380050pbe.379.1305292480311;
        Fri, 13 May 2011 06:14:40 -0700 (PDT)
Received: from localhost.localdomain (i118-20-60-90.s04.a013.ap.plala.or.jp [118.20.60.90])
        by mx.google.com with ESMTPS id q20sm1358319pbt.72.2011.05.13.06.14.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2011 06:14:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.169.g505a1.dirty
In-Reply-To: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173532>

---
 Documentation/ja/git-stage.po |   71 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ja/git-stage.po

diff --git a/Documentation/ja/git-stage.po b/Documentation/ja/git-stage.po
new file mode 100644
index 0000000..18c057f
--- /dev/null
+++ b/Documentation/ja/git-stage.po
@@ -0,0 +1,71 @@
+# SOME DESCRIPTIVE TITLE
+# Copyright (C) YEAR Free Software Foundation, Inc.
+# This file is distributed under the same license as the PACKAGE package.
+# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: PACKAGE VERSION\n"
+"POT-Creation-Date: 2011-05-13 11:06+0900\n"
+"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
+"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
+"Language-Team: LANGUAGE <LL@li.org>\n"
+"Language: \n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=CHARSET\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#. type: Plain text
+#: git-stage.txt:2
+msgid "git-stage(1)"
+msgstr ""
+
+#. type: Title -
+#: git-stage.txt:5
+#, no-wrap
+msgid "NAME\n"
+msgstr ""
+
+#. type: delimited block =
+#: git-stage.txt:7
+msgid "git-stage - Add file contents to the staging area"
+msgstr ""
+
+#. type: Title -
+#: git-stage.txt:10
+#, no-wrap
+msgid "SYNOPSIS\n"
+msgstr ""
+
+#. type: delimited block =
+#: git-stage.txt:13
+#, no-wrap
+msgid "'git stage' args...\n"
+msgstr ""
+
+#. type: Title -
+#: git-stage.txt:16
+#, no-wrap
+msgid "DESCRIPTION\n"
+msgstr ""
+
+#. type: delimited block =
+#: git-stage.txt:20
+msgid ""
+"This is a synonym for linkgit:git-add[1].  Please refer to the documentation "
+"of that command."
+msgstr ""
+
+#. type: delimited block =
+#: git-stage.txt:22
+#, no-wrap
+msgid ""
+"GIT\n"
+"---\n"
+msgstr ""
+
+#. type: delimited block =
+#: git-stage.txt:23
+msgid "Part of the linkgit:git[1] suite"
+msgstr ""
-- 
1.7.5.1.169.g505a1.dirty
