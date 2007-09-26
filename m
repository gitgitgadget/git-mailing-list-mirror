From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] core-tutorial: correct URL
Date: Tue, 25 Sep 2007 22:02:28 -0700
Organization: YPO4
Message-ID: <20070925220228.750ceffe.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 07:02:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaP2l-0005Cp-1d
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 07:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbXIZFCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 01:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbXIZFCc
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 01:02:32 -0400
Received: from xenotime.net ([66.160.160.81]:32779 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752426AbXIZFCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 01:02:32 -0400
Received: from midway.site ([71.117.233.180]) by xenotime.net for <git@vger.kernel.org>; Tue, 25 Sep 2007 22:02:28 -0700
X-Mailer: Sylpheed 2.4.6 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59214>

From: Randy Dunlap <rdunlap@xenotime.net>

The tinyurl is incorrect -- it attempts to go to groups.osdl.org,
which is gone.  Either use the full URL (in patch) or create a new
tinyurl for this URL.

Is the web page (where I first saw this problem) generated from
this txt file?
http://www.kernel.org/pub/software/scm/git/docs/core-tutorial.html
If not, it needs to be updated also.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/core-tutorial.txt |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- git-1.5.1.orig/Documentation/core-tutorial.txt
+++ git-1.5.1/Documentation/core-tutorial.txt
@@ -1470,7 +1470,8 @@ Although git is a truly distributed syst
 convenient to organize your project with an informal hierarchy
 of developers. Linux kernel development is run this way. There
 is a nice illustration (page 17, "Merges to Mainline") in
-link:http://tinyurl.com/a2jdg[Randy Dunlap's presentation].
+link:http://www.xenotime.net/linux/mentor/linux-mentoring-2006.pdf
+[Randy Dunlap's presentation].
 
 It should be stressed that this hierarchy is purely *informal*.
 There is nothing fundamental in git that enforces the "chain of
