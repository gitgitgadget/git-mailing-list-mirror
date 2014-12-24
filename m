From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 1/3] Documentation: add missing article in rev-list-options.txt
Date: Wed, 24 Dec 2014 23:05:38 +0000
Message-ID: <1419462340-769147-2-git-send-email-sandals@crustytoothpaste.net>
References: <1419462340-769147-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 25 00:06:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3v0a-0006Er-NP
	for gcvg-git-2@plane.gmane.org; Thu, 25 Dec 2014 00:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbaLXXGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 18:06:05 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55959 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751512AbaLXXGC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Dec 2014 18:06:02 -0500
Received: from vauxhall.hsd1.tx.comcast.net. (unknown [98.201.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7745F28090;
	Wed, 24 Dec 2014 23:05:54 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1419462340-769147-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261817>

Add the missing article "a".

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index afccfdc..2277fcb 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -653,7 +653,7 @@ These options are mostly targeted for packing of Git repositories.
 --objects-edge::
 	Similar to `--objects`, but also print the IDs of excluded
 	commits prefixed with a ``-'' character.  This is used by
-	linkgit:git-pack-objects[1] to build ``thin'' pack, which records
+	linkgit:git-pack-objects[1] to build a ``thin'' pack, which records
 	objects in deltified form based on objects contained in these
 	excluded commits to reduce network traffic.
 
-- 
2.2.1.209.g41e5f3a
