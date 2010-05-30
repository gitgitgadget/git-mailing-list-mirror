From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Update URL of parsecvs repository in documentation
Date: Sun, 30 May 2010 16:12:11 +0100
Message-ID: <20100530151211.GA19064@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 30 17:12:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIkBZ-0003fL-Ov
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 17:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389Ab0E3PMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 11:12:17 -0400
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36311 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116Ab0E3PMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 11:12:16 -0400
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4UFCCqA019778
	for <git@vger.kernel.org>; Sun, 30 May 2010 16:12:13 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4UFCBla019777
	for git@vger.kernel.org; Sun, 30 May 2010 16:12:11 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148007>

The parsecvs repository has moved.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 Documentation/git-cvsimport.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 8bcd875..d38f8a8 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -215,7 +215,7 @@ want to import consider using these alternative tools which proved to be
 more stable in practice:
 
 * cvs2git (part of cvs2svn), `http://cvs2svn.tigris.org`
-* parsecvs, `http://cgit.freedesktop.org/~keithp/parsecvs`
+* parsecvs, `git://anongit.freedesktop.org/git/users/keithp/repos/parsecvs.git/`
 
 Author
 ------
