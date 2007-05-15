From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] Documentation/branch: fix small typo in -D example
Date: Tue, 15 May 2007 12:51:02 +1000
Message-ID: <46492016.2050304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 15 04:51:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnn83-0000S1-Mb
	for gcvg-git@gmane.org; Tue, 15 May 2007 04:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758696AbXEOCvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 22:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755138AbXEOCvH
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 22:51:07 -0400
Received: from pecan.exetel.com.au ([220.233.0.17]:37360 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758696AbXEOCvG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 22:51:06 -0400
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95] helo=[192.168.64.35])
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1Hnn7v-0005tX-Lq; Tue, 15 May 2007 12:51:03 +1000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
X-Enigmail-Version: 0.94.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47310>


Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---
 Documentation/git-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 603f87f..8dc5171 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -136,7 +136,7 @@ $ git branch -D test               <2>
 +
 <1> delete remote-tracking branches "todo", "html", "man"
 <2> delete "test" branch even if the "master" branch does not have all
-commits from todo branch.
+commits from test branch.
 
 
 Notes
-- 
1.5.2.rc3.2q
