From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [PATCH] Document the -n option for git-log
Date: Sat, 6 Jan 2007 13:38:33 -0500
Message-ID: <20070106183833.GB12543@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Jan 06 19:38:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3GRE-0004q1-EN
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 19:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbXAFSih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 13:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbXAFSih
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 13:38:37 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:56978 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbXAFSig (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 13:38:36 -0500
Received: from filer.fsl.cs.sunysb.edu (IDENT:RKGh9cq3b8Ce6BAnmovbj+aTmKsvHAsh@localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l06IcXHC014909;
	Sat, 6 Jan 2007 13:38:33 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l06IcXYR014907;
	Sat, 6 Jan 2007 13:38:33 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36093>


Signed-off-by: Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
---
 Documentation/git-log.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index e9f746b..4a71847 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -27,7 +27,7 @@ OPTIONS
 
 include::pretty-formats.txt[]
 
---max-count=<n>::
+-n <n>, --max-count=<n>::
 	Limits the number of commits to show.
 
 <since>..<until>::
-- 
1.5.0.rc0.g7562
