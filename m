From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-merge.sh: fix typo in usage message: sucesses --> succeeds
Date: Wed, 18 Jun 2008 15:16:08 -0500
Message-ID: <bLvA8kwmAUxdoCYs9oZWp1irRPzvQcgSR5K4gw8EIkh6QJ7WRyIG4A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 22:19:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K947h-0006QB-Jd
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 22:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbYFRUSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 16:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbYFRUSW
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 16:18:22 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34242 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbYFRUSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 16:18:22 -0400
Received: by mail.nrlssc.navy.mil id m5IKG9bf026288; Wed, 18 Jun 2008 15:16:09 -0500
X-OriginalArrivalTime: 18 Jun 2008 20:16:09.0211 (UTC) FILETIME=[25507CB0:01C8D180]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85408>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 git-merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 5fc5f52..8026ccf 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -13,7 +13,7 @@ n                    don't show a diffstat at the end of the merge
 summary              (synonym to --stat)
 log                  add list of one-line log to merge commit message
 squash               create a single commit instead of doing a merge
-commit               perform a commit if the merge sucesses (default)
+commit               perform a commit if the merge succeeds (default)
 ff                   allow fast forward (default)
 s,strategy=          merge strategy to use
 m,message=           message to be used for the merge commit (if any)
-- 
1.5.5.3
