From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 01/10] Docs: git tag: Add `the'
Date: Mon, 28 Mar 2011 14:35:20 +0000
Message-ID: <1301327622-8595-2-git-send-email-mfwitten@gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:54:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Elz-0004Dy-D7
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab1C1PyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:54:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45043 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab1C1PyW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:54:22 -0400
Received: by ewy4 with SMTP id 4so1221676ewy.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:message-id:x-mailer
         :in-reply-to:references:date;
        bh=Q259GShi7Qs5rjHUpB1bDC1d7+h0q9KHGDwBy4LhyeY=;
        b=kdxuUlH7kMCVk940IOb6rAQD/rCiiRnczPxPKNML0eVC66k851h0CIDmCgiJj8Xlhl
         s+w4hv9mkXG0nRPZ/FyUu9i8pt3ZMQ2Zjnh5IGSM+9qiYhCtDhwdEbVJybR8ijbMOaNn
         k+yz6SBPOto1XGbNZQqBDd2p/p3shrsVx/PqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:message-id:x-mailer:in-reply-to:references:date;
        b=RkDy6dk07WStW9RiJtKp2yfEm9xCXIOCdpjcPfXY1Hx7zksuK3u7uMQqlHtJnyG3N7
         7CSBOVnrB3EeTuobU84Ydt12tY7LvYOo7Aybi53+k+QUxBT6cKm1GNF5lejkCVhWo01x
         4uY8gUzfRbJ5nwPheVnzB5IaIHj826BWmv4KE=
Received: by 10.14.8.131 with SMTP id 3mr1772098eer.134.1301327661184;
        Mon, 28 Mar 2011 08:54:21 -0700 (PDT)
Received: from localhost.localdomain ([174.143.243.243])
        by mx.google.com with ESMTPS id v1sm2878807eeh.6.2011.03.28.08.54.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 08:54:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.18.g68fe8
In-Reply-To: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170139>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-tag.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 61263fa..7844ff1 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -165,7 +165,7 @@ You can test which tag you have by doing
 
 which should return 0123456789abcdef.. if you have the new version.
 
-Sorry for inconvenience.
+Sorry for the inconvenience.
 ------------
 
 Does this seem a bit complicated?  It *should* be. There is no
-- 
1.7.4.18.g68fe8
