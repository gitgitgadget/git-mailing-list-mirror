From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 17/17] Documentation/git-read-tree.txt: Add --reset to SYNOPSIS.
Date: Fri, 9 Dec 2005 00:28:06 +0100
Message-ID: <11340844863788-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844851233-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCL-0004lM-MU
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbVLHX23 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbVLHX22
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:28 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:40910 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932733AbVLHX2W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:22 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051208232821.VWZN17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:21 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 09 Dec 2005 00:28:33 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,232,1131318000"; 
   d="scan'208"; a="16674761:sNHT379253826"
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 0BDDAADFFC;
	Fri,  9 Dec 2005 00:28:06 +0100 (CET)
In-Reply-To: <11340844851233-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13390>

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-read-tree.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

2464fb38eb9ce5c1dcf9eec6aea809454a5ef770
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 27ee590..6fbd6d9 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -8,7 +8,7 @@ git-read-tree - Reads tree information i
 
 SYNOPSIS
 --------
-'git-read-tree' (<tree-ish> | [-m [-u|-i]] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
+'git-read-tree' (<tree-ish> | [[-m | --reset] [-u | -i]] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
 
 
 DESCRIPTION
-- 
0.99.9l
