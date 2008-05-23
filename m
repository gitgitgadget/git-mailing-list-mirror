From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 1/8] Move git-hash-object tests from t5303 to t1007
Date: Fri, 23 May 2008 16:19:36 +0200
Message-ID: <1211552384-29636-2-git-send-email-barra_cuda@katamail.com>
References: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Cc: git@vger.kernel.org
To: aroben@apple.com
X-From: git-owner@vger.kernel.org Fri May 23 16:17:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY55-00066y-B7
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbYEWOQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753698AbYEWOQR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:16:17 -0400
Received: from smtp.katamail.com ([62.149.157.154]:51073 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751507AbYEWOQM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:16:12 -0400
Received: (qmail 31490 invoked by uid 89); 23 May 2008 14:14:49 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_60,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.207)
  by smtp1-pc with SMTP; 23 May 2008 14:14:48 -0000
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82703>

From: Adam Roben <aroben@apple.com>

This is a more appropriate location according to t/README.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 t/{t5303-hash-object.sh => t1007-hash-object.sh} |    0 
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t5303-hash-object.sh => t1007-hash-object.sh} (100%)

diff --git a/t/t5303-hash-object.sh b/t/t1007-hash-object.sh
similarity index 100%
rename from t/t5303-hash-object.sh
rename to t/t1007-hash-object.sh
-- 
1.5.5.1
