From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 1/4] Documentation: add missing article in rev-list-options.txt
Date: Tue, 23 Dec 2014 12:01:19 +0000
Message-ID: <1419336082-283091-2-git-send-email-sandals@crustytoothpaste.net>
References: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 13:01:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3O9o-0002sg-8K
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 13:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046AbaLWMBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 07:01:35 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55910 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756034AbaLWMBd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Dec 2014 07:01:33 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 20C3728090;
	Tue, 23 Dec 2014 12:01:30 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261725>

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
