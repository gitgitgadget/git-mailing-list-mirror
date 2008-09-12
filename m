From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Fix some manual typos.
Date: Fri, 12 Sep 2008 21:10:26 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080912191026.GB32380@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 21:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeELD-0003n0-Pi
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 21:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbYILT24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 15:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755087AbYILT24
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 15:28:56 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:45273 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbYILT24 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 15:28:56 -0400
X-Greylist: delayed 1098 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Sep 2008 15:28:55 EDT
Received: from localhost.localdomain (xdsl-87-79-251-167.netcologne.de [87.79.251.167])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 2F24B40004147
	for <git@vger.kernel.org>; Fri, 12 Sep 2008 21:10:36 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1KeE2E-0003LN-PR
	for git@vger.kernel.org; Fri, 12 Sep 2008 21:10:26 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95761>

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

Thanks for git!

Cheers,
Ralf

 Documentation/git-web--browse.txt |    2 +-
 Documentation/gitattributes.txt   |    2 +-
 Documentation/merge-config.txt    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 36afad8..7f7a45b 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -77,7 +77,7 @@ the URLs passed as arguments.
 Note about konqueror
 --------------------
 
-When 'konqueror' is specified by the a command line option or a
+When 'konqueror' is specified by a command line option or a
 configuration variable, we launch 'kfmclient' to try to open the HTML
 man page on an already opened konqueror in a new tab if possible.
 
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 75124d2..6f3551d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -313,7 +313,7 @@ patterns are available:
 
 - `html` suitable for HTML/XHTML documents.
 
-- `java` suitable for source code in the Java lanugage.
+- `java` suitable for source code in the Java language.
 
 - `pascal` suitable for source code in the Pascal/Delphi language.
 
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 00277e0..c735788 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -1,5 +1,5 @@
 merge.stat::
-	Whether to print the diffstat between ORIG_HEAD and merge result
+	Whether to print the diffstat between ORIG_HEAD and the merge result
 	at the end of the merge.  True by default.
 
 merge.log::
-- 
1.6.0.1.309.g48068
