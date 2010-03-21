From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/4] Documentation/gitdiffcore: Remove misleading date in heading
Date: Sun, 21 Mar 2010 18:30:17 +0100
Message-ID: <adf3d89cc4c3f586e9946017e2f17c0454bc509e.1269192495.git.git@drmicha.warpmail.net>
References: <cover.1269192495.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 18:30:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtOyl-00035z-Vb
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 18:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222Ab0CURaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 13:30:12 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53713 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753180Ab0CURaK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 13:30:10 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CDF19E9C8E;
	Sun, 21 Mar 2010 13:30:08 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sun, 21 Mar 2010 13:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=/V3H7X0mPxrlcoppr4m3Ptiy7Tw=; b=rof7RcozjaZ62CrMS++3QPgz9HtqOipIYHTqEGgdf4PgPDKWf+64IakeesEuFeSpdRU4MaqKUdfDM+7YyWimqt0r0AbEpS0Ux1GF/hoh8WaXJAaAancd60s3ERf9tDGoE7IOGJtJK2BbW8KwvNQEatJiLbCaHsL8MHlQ81PuTqM=
X-Sasl-enc: KYSl6HSNIIKLLtsrZ+R4NB+Xzy0J9wMWzlq0QlOphvb+ 1269192607
Received: from localhost (p3EE280DF.dip0.t-ipconnect.de [62.226.128.223])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B49273FBE1;
	Sun, 21 Mar 2010 13:30:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.2.358.g30511
In-Reply-To: <cover.1269192495.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142842>

Ever since the automatic conversion into man form, the heading
contained a misidentified subheading reading "June 2005".
Remove this since the documentation is more recent, and the correct
date is in the footer.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/gitdiffcore.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index dcdea54..9de8caf 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -3,7 +3,7 @@ gitdiffcore(7)
 
 NAME
 ----
-gitdiffcore - Tweaking diff output (June 2005)
+gitdiffcore - Tweaking diff output
 
 SYNOPSIS
 --------
-- 
1.7.0.2.358.g30511
