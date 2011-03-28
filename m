From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 06/10] Docs: git tag: Add missing 'the'
Date: Mon, 28 Mar 2011 14:55:37 +0000
Message-ID: <1301327622-8595-7-git-send-email-mfwitten@gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:55:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Ema-0004Wa-TH
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab1C1Pyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:54:49 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45043 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab1C1Pys (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:54:48 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1221676ewy.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:message-id:x-mailer
         :in-reply-to:references:date;
        bh=J32iKnlUhYrKrOwRd/khKClPS3Ghzgv197H4kBiAM5g=;
        b=JLTKtd9/icQ7xwB3vabuX2eM6/ldSKIxG/EznIoqyUFhHg8Pi8I+919Pwzgk6iIMTr
         QbHTzfX0JQT4OPaS1ZcJwA18LXvI96p1BvNPI/ldYMuAbkp5A2de2i9JwUmU7GDpcav+
         svBdsiRDbMtdRkVsH7q7ETnF5rVWOwmZFn7ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:message-id:x-mailer:in-reply-to:references:date;
        b=MplONviEYtM3Bsk3eiwC6edy7HTx1FHnLfKUBjH7VbW29mBAgzUN+fwVVN4PBPMvIA
         ntz33XnkRABs6cuku8H33V7/ZLJi0iCgeqFX0skFxG/tKDVFSmmgbdyHeLU2eomuBDpN
         /lzZz3zNbxIGOwE5hqQnDChe9me6FJxfE/VnY=
Received: by 10.14.8.210 with SMTP id 58mr1777022eer.112.1301327687588;
        Mon, 28 Mar 2011 08:54:47 -0700 (PDT)
Received: from localhost.localdomain ([174.143.243.243])
        by mx.google.com with ESMTPS id v1sm2878807eeh.6.2011.03.28.08.54.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 08:54:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.18.g68fe8
In-Reply-To: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170143>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-tag.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 9ec2715..73f340b 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -215,7 +215,7 @@ One important aspect of git is its distributed nature, which
 largely means there is no inherent "upstream" or
 "downstream" in the system.  On the face of it, the above
 example might seem to indicate that the tag namespace is owned
-by upper echelon of people and tags only flow downwards, but
+by the upper echelon of people and that tags only flow downwards, but
 that is not the case.  It only shows that the usage pattern
 determines who are interested in whose tags.
 
-- 
1.7.4.18.g68fe8
