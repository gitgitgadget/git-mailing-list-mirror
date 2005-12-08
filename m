From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 15/17] Documentation/git-update-server-info.txt: Add -f alias for --force to documentation.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844852368-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844853429-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCN-0004lM-Cy
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742AbVLHX20 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbVLHX2Z
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:25 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:19918 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932734AbVLHX2U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:20 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051208232814.VWYU17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:14 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 09 Dec 2005 00:28:33 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,232,1131318000"; 
   d="scan'208"; a="16674754:sNHT144252810"
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id E622BADFFA;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844853429-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13389>

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-update-server-info.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

32baeb613526b51ebc7689311ec0a164fdc36c27
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index 3d0dea0..527fb30 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -22,7 +22,7 @@ pull decisions.  This command generates 
 OPTIONS
 -------
 
---force::
+-f|--force::
 	Update the info files from scratch.
 
 
-- 
0.99.9l
