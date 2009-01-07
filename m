From: Joey Hess <joey@kitenet.net>
Subject: [PATCH] tutorial.txt renamed
Date: Tue, 6 Jan 2009 23:23:37 -0500
Message-ID: <20090107042337.GA24735@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 05:25:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKPye-0003e5-4a
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 05:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbZAGEXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 23:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754159AbZAGEXo
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 23:23:44 -0500
Received: from wren.kitenet.net ([80.68.85.49]:36897 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754069AbZAGEXn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 23:23:43 -0500
Received: from gnu.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 95E563142F4
	for <git@vger.kernel.org>; Tue,  6 Jan 2009 23:23:39 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 68459A8AA5; Tue,  6 Jan 2009 23:23:37 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8840/Tue Jan  6 15:03:01 2009 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104753>

The tutorial.txt file was renamed to gittutorial.txt some time ago, update
README.

Signed-off-by: Joey Hess <joey@gnu.kitenet.net>
---
 README |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/README b/README
index 548142c..5fa41b7 100644
--- a/README
+++ b/README
@@ -24,7 +24,7 @@ It was originally written by Linus Torvalds with help of a group of
 hackers around the net. It is currently maintained by Junio C Hamano.
 
 Please read the file INSTALL for installation instructions.
-See Documentation/tutorial.txt to get started, then see
+See Documentation/gittutorial.txt to get started, then see
 Documentation/everyday.txt for a useful minimum set of commands,
 and "man git-commandname" for documentation of each command.
 CVS users may also want to read Documentation/cvs-migration.txt.
-- 
1.5.6.5

-- 
see shy jo
