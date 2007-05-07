From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 6/6] user-manual: stop deprecating the manual
Date: Mon,  7 May 2007 01:14:02 -0400
Message-ID: <16693.8173388646$1178514875@news.gmane.org>
References: <11785148422793-git-send-email->
 <11785148433801-git-send-email->
 <11785148442263-git-send-email->
 <1178514845119-git-send-email->
 <11785148452962-git-send-email->
 <11785148461307-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 07:14:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkvYO-0008WF-Rq
	for gcvg-git@gmane.org; Mon, 07 May 2007 07:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbXEGFOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 01:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbXEGFOR
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 01:14:17 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53671 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999AbXEGFOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 01:14:10 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HkvY0-0005a9-8i; Mon, 07 May 2007 01:14:08 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <11785148461307-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46415>

From: J. Bruce Fields <bfields@citi.umich.edu>

It's just as much a work-in-progress, but at least now it's gotten
enough technical review to shake out most of the really bad lies, so
hopefully it doesn't do any actual damage.  And if we encourage people
to read it, they'll be more likely to whine about it, which will help
get it fixed faster.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/git.txt |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index aa65802..c2b7f3f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -21,10 +21,9 @@ and full access to internals.
 See this link:tutorial.html[tutorial] to get started, then see
 link:everyday.html[Everyday Git] for a useful minimum set of commands, and
 "man git-commandname" for documentation of each command.  CVS users may
-also want to read link:cvs-migration.html[CVS migration].
-link:user-manual.html[Git User's Manual] is still work in
-progress, but when finished hopefully it will guide a new user
-in a coherent way to git enlightenment ;-).
+also want to read link:cvs-migration.html[CVS migration].  See
+link:user-manual.html[Git User's Manual] for a more in-depth
+introduction.
 
 The COMMAND is either a name of a Git command (see below) or an alias
 as defined in the configuration file (see gitlink:git-config[1]).
-- 
1.5.1.1.98.gedb4f
