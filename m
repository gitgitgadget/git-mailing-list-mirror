From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 5/6] manual: use 'URL' instead of 'url'.
Date: Tue, 9 Oct 2007 23:03:55 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071009210355.GG31317@ins.uni-bonn.de>
References: <20071009205755.GB31317@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 23:04:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfMFv-0003L1-Hz
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445AbXJIVEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 17:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754603AbXJIVEe
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:04:34 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:34402 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441AbXJIVEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 17:04:34 -0400
Received: from localhost.localdomain (xdsl-87-78-163-242.netcologne.de [87.78.163.242])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 1DF82400009E5
	for <git@vger.kernel.org>; Tue,  9 Oct 2007 23:04:33 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1IfMF9-0000mq-Ed
	for git@vger.kernel.org; Tue, 09 Oct 2007 23:03:55 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071009205755.GB31317@ins.uni-bonn.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60440>

Just for consistency, use the spelling URL everywhere.
---
 Documentation/user-manual.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index df482e6..38e35d8 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1782,7 +1782,7 @@ $ git clone /path/to/repository
 $ git pull /path/to/other/repository
 -------------------------------------------------
 
-or an ssh url:
+or an ssh URL:
 
 -------------------------------------------------
 $ git clone ssh://yourhost/~you/repository
@@ -1843,7 +1843,7 @@ Exporting a git repository via the git protocol
 This is the preferred method.
 
 If someone else administers the server, they should tell you what
-directory to put the repository in, and what git:// url it will appear
+directory to put the repository in, and what git:// URL it will appear
 at.  You can then skip to the section
 "<<pushing-changes-to-a-public-repository,Pushing changes to a public
 repository>>", below.
@@ -1880,8 +1880,8 @@ $ chmod a+x hooks/post-update
 gitlink:git-update-server-info[1], and the documentation
 link:hooks.html[Hooks used by git].)
 
-Advertise the url of proj.git.  Anybody else should then be able to
-clone or pull from that url, for example with a command line like:
+Advertise the URL of proj.git.  Anybody else should then be able to
+clone or pull from that URL, for example with a command line like:
 
 -------------------------------------------------
 $ git clone http://yourserver.com/~you/proj.git
-- 
1.5.3.3.g34c6d
