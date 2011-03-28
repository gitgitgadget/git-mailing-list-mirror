From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 05/10] Docs: git tag: Streamline a sentence.
Date: Mon, 28 Mar 2011 14:53:12 +0000
Message-ID: <1301327622-8595-6-git-send-email-mfwitten@gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:55:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Ema-0004Wa-96
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab1C1Pyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:54:44 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49622 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab1C1Pyn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:54:43 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1202218eyx.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:message-id:x-mailer
         :in-reply-to:references:date;
        bh=1rNK4Flo7fJFgrk2O5q738izu79kMkXGKQuhQKOEs3I=;
        b=Kg8GvN7pDZ5gojUFL+q5TSR1KrDy8x34wYbVsjpIACiax1EyOt4wZc5klM36aIKvsc
         1bXfy3T4UySBsHr5gtV2uAsgPQNBIwWNcEbofdPJeCbeSxAfUR+65k3Y4wdo8zH9VE1a
         Hl8+aVwcjY8wmT85MNKKAdktqqaDCpyHm9dxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:message-id:x-mailer:in-reply-to:references:date;
        b=qmEibJRSXDgzRtlSFjLbs/P0D7iJ+bgx8tBdLoKzRg+CUatXP/5YAYmSs175PUKbWz
         h4r/23X4HAG+fN8ihF4bIfSnsOvBkZsMXW+xYQ6a+YrSfiaW4gBCGn7/RUwFavANZ6lz
         TnkqItsIzLwnY8f0ZseRRi4PUCrCNXv3F2JDY=
Received: by 10.213.32.10 with SMTP id a10mr1324940ebd.74.1301327682150;
        Mon, 28 Mar 2011 08:54:42 -0700 (PDT)
Received: from localhost.localdomain ([174.143.243.243])
        by mx.google.com with ESMTPS id v1sm2878807eeh.6.2011.03.28.08.54.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 08:54:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.18.g68fe8
In-Reply-To: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170145>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-tag.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index b348c3d..9ec2715 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -211,8 +211,8 @@ $ git pull git://git..../proj.git master
 In such a case, you do not want to automatically follow the other
 person's tags.
 
-One important aspect of git is it is distributed, and being
-distributed largely means there is no inherent "upstream" or
+One important aspect of git is its distributed nature, which
+largely means there is no inherent "upstream" or
 "downstream" in the system.  On the face of it, the above
 example might seem to indicate that the tag namespace is owned
 by upper echelon of people and tags only flow downwards, but
-- 
1.7.4.18.g68fe8
