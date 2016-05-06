From: Li Peng <lip@dtdream.com>
Subject: [PATCH] pack-protocol.txt: fix duplicate words of "the"
Date: Fri,  6 May 2016 20:00:13 +0800
Message-ID: <1462536013-16557-1-git-send-email-lip@dtdream.com>
Cc: peff@peff.net, Li Peng <lip@dtdream.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 14:00:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayeR5-00089c-0e
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 14:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbcEFMAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 08:00:43 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:59377 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932200AbcEFMAn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 08:00:43 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04987657|-1;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03288;MF=lip@dtdream.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_----4mMLI1Y_1462536015;
Received: from localhost.localdomain(mailfrom:lip@dtdream.com ip:111.198.29.130)
          by smtp.aliyun-inc.com(10.147.41.138);
          Fri, 06 May 2016 20:00:21 +0800
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293763>

Remove duplicate "the".

Signed-off-by: Li Peng <lip@dtdream.com>
---
 Documentation/technical/pack-protocol.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index c6977bb..8b36343 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -526,7 +526,7 @@ Push Certificate
 
 A push certificate begins with a set of header lines.  After the
 header and an empty line, the protocol commands follow, one per
-line. Note that the the trailing LF in push-cert PKT-LINEs is _not_
+line. Note that the trailing LF in push-cert PKT-LINEs is _not_
 optional; it must be present.
 
 Currently, the following header fields are defined:
-- 
1.8.3.1
