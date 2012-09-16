From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 4/8] Doc: 'git' has a discussion section
Date: Sun, 16 Sep 2012 11:57:59 +0100
Message-ID: <1347793083-4136-5-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 14:34:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDE3Z-0005pD-Ss
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 14:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab2IPMeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 08:34:16 -0400
Received: from smtp2go.com ([207.58.142.213]:35642 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004Ab2IPMeE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 08:34:04 -0400
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205615>

Highlight there is a further discussion section later in
git man page

Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 34d8a1b..56685c7 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -30,6 +30,7 @@ After you mastered the basic concepts, you can come back to this
 page to learn what commands git offers.  You can learn more about
 individual git commands with "git help command".  linkgit:gitcli[7]
 manual page gives you an overview of the command line command syntax.
+See also the Discussion and Further Documentation sections below.
 
 Formatted and hyperlinked version of the latest git documentation
 can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.
-- 
1.7.8.msysgit.0
