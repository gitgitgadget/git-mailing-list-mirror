From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] ctype.c: fix typo in comment
Date: Fri, 01 May 2009 22:03:07 +0200
Message-ID: <49FB557B.2020702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 22:03:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzyxh-0001Wf-RD
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 22:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbZEAUDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 16:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761855AbZEAUDp
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 16:03:45 -0400
Received: from india601.server4you.de ([85.25.151.105]:36981 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758928AbZEAUDo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 16:03:44 -0400
Received: from [10.0.1.101] (p57B7D83D.dip.t-dialin.net [87.183.216.61])
	by india601.server4you.de (Postfix) with ESMTPSA id 2F2BF2F804C;
	Fri,  1 May 2009 22:03:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118094>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 ctype.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ctype.c b/ctype.c
index b90ec00..7ee64c7 100644
--- a/ctype.c
+++ b/ctype.c
@@ -10,7 +10,7 @@ enum {
 	A = GIT_ALPHA,
 	D = GIT_DIGIT,
 	G = GIT_GLOB_SPECIAL,	/* *, ?, [, \\ */
-	R = GIT_REGEX_SPECIAL,	/* $, (, ), +, ., ^, {, | * */
+	R = GIT_REGEX_SPECIAL,	/* $, (, ), +, ., ^, {, | */
 };
 
 unsigned char sane_ctype[256] = {
-- 
1.6.3.rc3.40.g75b44
