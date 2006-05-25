From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Built git-upload-tar should be ignored.
Date: Wed, 24 May 2006 22:48:39 -0400
Message-ID: <20060525024839.GA4356@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 04:48:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj5u9-0006I8-E5
	for gcvg-git@gmane.org; Thu, 25 May 2006 04:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWEYCsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 22:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWEYCsq
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 22:48:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:23443 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964817AbWEYCsq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 22:48:46 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fj5to-0003bY-BI; Wed, 24 May 2006 22:48:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 71FBF20FB0C; Wed, 24 May 2006 22:48:40 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20719>


Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 18a7295..afd0876 100644
--- a/.gitignore
+++ b/.gitignore
@@ -116,6 +116,7 @@ git-update-index
 git-update-ref
 git-update-server-info
 git-upload-pack
+git-upload-tar
 git-var
 git-verify-pack
 git-verify-tag
-- 
1.3.3.g45d8
