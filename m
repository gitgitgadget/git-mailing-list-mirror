From: Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH] Documentation: Expand a couple of abbreviations
Date: Tue,  3 Mar 2009 19:29:21 +0000
Message-ID: <1236108562-31469-2-git-send-email-mike@abacus.co.uk>
References: <1236108562-31469-1-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 20:53:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeafY-0007zo-8f
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbZCCTvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 14:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbZCCTvN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:51:13 -0500
Received: from [82.109.193.99] ([82.109.193.99]:21425 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752069AbZCCTvN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 14:51:13 -0500
X-Greylist: delayed 2013 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2009 14:51:13 EST
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id B53EE195DCB; Tue,  3 Mar 2009 19:29:22 +0000 (GMT)
X-Mailer: git-send-email 1.6.0.2.229.g1293c
In-Reply-To: <1236108562-31469-1-git-send-email-mike@abacus.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112161>

These may not be obvious to non-native English speakers

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 Documentation/git-am.txt |    2 +-
 Documentation/gitk.txt   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index ff307eb..75081d9 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -121,7 +121,7 @@ the commit, after stripping common prefix "[PATCH <anything>]".
 It is supposed to describe what the commit is about concisely as
 a one line text.
 
-The body of the message (iow, after a blank line that terminates
+The body of the message (in other words, after a blank line that terminates
 RFC2822 headers) can begin with "Subject: " and "From: " lines
 that are different from those of the mail header, to override
 the values of these fields.
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index bd005bc..cf465cb 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -74,7 +74,7 @@ frequently used options.
 <path>...::
 
 	Limit commits to the ones touching files in the given paths. Note, to
-	avoid ambiguity wrt. revision names use "--" to separate the paths
+	avoid ambiguity with respect to revision names use "--" to separate the paths
 	from any preceding options.
 
 Examples
-- 
1.6.0.2.229.g1293c.dirty
