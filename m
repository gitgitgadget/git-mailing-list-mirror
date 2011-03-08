From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/3] rev-list-options.txt: typo fix
Date: Tue,  8 Mar 2011 09:31:24 +0100
Message-ID: <2862dfc9969beb42636ec44292d3509ddb215285.1299572814.git.git@drmicha.warpmail.net>
References: <4D75E92C.1090506@drmicha.warpmail.net>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 09:35:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwsNf-0002EB-4J
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 09:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab1CHIey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 03:34:54 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:57571 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753459Ab1CHIex (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 03:34:53 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 12E2E20B0C;
	Tue,  8 Mar 2011 03:34:53 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 08 Mar 2011 03:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=LUHnDLu/KqPTUu28N7kMmxWLNQY=; b=L2buad8HdgYirMDx5O3zc1KEStsxF+wHJqjB/FIKh0WZNXp3FJAk0SapuYpE33J0sjsWRibMYoV9pkw3NVp+fOaZxt23vXeE3J37+O8p52RAGuzJRJgf6uGxhF+FbvnYx9wweX2BfDPqqTWU8u6Orgv3dLVPCHArNY4VeCbkC5U=
X-Sasl-enc: LsdOox9XE5ZwAv/Z1+iP0hZW900i87XipSsicrS9Cylm 1299573292
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8D9D1447216;
	Tue,  8 Mar 2011 03:34:52 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.299.g567d7.dirty
In-Reply-To: <4D75E92C.1090506@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168644>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/rev-list-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 95d209c..76add13 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -165,7 +165,7 @@ limiting may be applied.
 -n 'number'::
 --max-count=<number>::
 
-	Limit the number of commits output.
+	Limit the number of commits to output.
 
 --skip=<number>::
 
-- 
1.7.4.1.299.g567d7.dirty
