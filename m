From: Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH 1/3] Documentation: fix typos / spelling mistakes
Date: Fri, 17 Apr 2009 19:13:28 +0100
Message-ID: <1239992010-16698-2-git-send-email-mike@abacus.co.uk>
References: <1239992010-16698-1-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:40:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lusyk-0008E2-53
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 20:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760281AbZDQSiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 14:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759702AbZDQSiR
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 14:38:17 -0400
Received: from [82.109.193.99] ([82.109.193.99]:31744 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759465AbZDQSiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 14:38:14 -0400
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id 12C921D5395; Fri, 17 Apr 2009 19:13:30 +0100 (BST)
X-Mailer: git-send-email 1.6.0.2.229.g1293c
In-Reply-To: <1239992010-16698-1-git-send-email-mike@abacus.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116769>

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 Documentation/git-cvsimport.txt         |    2 +-
 Documentation/git-format-patch.txt      |    2 +-
 contrib/thunderbird-patch-inline/README |    4 ++--
 gitweb/README                           |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index d7bab13..614e769 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -196,7 +196,7 @@ Problems related to tags:
 
 If you suspect that any of these issues may apply to the repository you
 want to import consider using these alternative tools which proved to be
-more stable in practise:
+more stable in practice:
 
 * cvs2git (part of cvs2svn), `http://cvs2svn.tigris.org`
 * parsecvs, `http://cgit.freedesktop.org/~keithp/parsecvs`
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index eb2fbcf..5eddca9 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -194,7 +194,7 @@ CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message
 in the repository configuration, new defaults for the subject prefix
-and file suffix, control attachements, and number patches when outputting
+and file suffix, control attachments, and number patches when outputting
 more than one.
 
 ------------
diff --git a/contrib/thunderbird-patch-inline/README b/contrib/thunderbird-patch-inline/README
index 39f96aa..000147b 100644
--- a/contrib/thunderbird-patch-inline/README
+++ b/contrib/thunderbird-patch-inline/README
@@ -1,12 +1,12 @@
 appp.sh is a script that is supposed to be used together with ExternalEditor
-for Mozilla Thundebird. It will let you include patches inline in e-mails
+for Mozilla Thunderbird. It will let you include patches inline in e-mails
 in an easy way.
 
 Usage:
 - Generate the patch with git format-patch.
 - Start writing a new e-mail in Thunderbird.
 - Press the external editor button (or Ctrl-E) to run appp.sh
-- Select the previosly generated patch file.
+- Select the previously generated patch file.
 - Finish editing the e-mail.
 
 Any text that is entered into the message editor before appp.sh is called
diff --git a/gitweb/README b/gitweb/README
index 8433dd1..ad73c6a 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -206,7 +206,7 @@ not include variables usually directly set during build):
  * $fallback_encoding
    Gitweb assumes this charset if line contains non-UTF-8 characters.
    Fallback decoding is used without error checking, so it can be even
-   'utf-8'. Value mist be valid encodig; see Encoding::Supported(3pm) man
+   'utf-8'. Value mist be valid encoding; see Encoding::Supported(3pm) man
    page for a list.   By default 'latin1', aka. 'iso-8859-1'.
  * @diff_opts
    Rename detection options for git-diff and git-diff-tree. By default
-- 
1.6.0.2.229.g1293c.dirty
