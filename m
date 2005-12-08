From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 7/17] Documentation/git-cvsimport.txt: Fix a slight glitch in description heading.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <1134084485683-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <1134084485869-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCJ-0004lM-FO
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbVLHX2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbVLHX2Q
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:16 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:1998 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932716AbVLHX2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:13 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051208232807.VWYD17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:07 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 09 Dec 2005 00:28:32 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,232,1131318000"; 
   d="scan'208"; a="16674747:sNHT30765483"
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 770B4ADFEF;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <1134084485869-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13393>

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-cvsimport.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

98723ba21e0ffdbfc183a2b878938ab17744317d
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 88bd3b0..f89b251 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -60,7 +60,7 @@ the old cvs2git tool.
 +
 If you need to pass multiple options, separate them with a comma.
 
--P:: <cvsps-output-file>
+-P <cvsps-output-file>::
 	Instead of calling cvsps, read the provided cvsps output file. Useful
 	for debugging or when cvsps is being handled outside cvsimport.
 
-- 
0.99.9l
