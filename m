From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 09/10] Docs: git tag: Use semicolon
Date: Mon, 28 Mar 2011 15:01:16 +0000
Message-ID: <1301327622-8595-10-git-send-email-mfwitten@gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:55:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Emc-0004Wa-QH
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab1C1PzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:55:05 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49622 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab1C1PzE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:55:04 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1202218eyx.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:message-id:x-mailer
         :in-reply-to:references:date;
        bh=S3EEPNq3Sdp2BM8NKbXR0keuzH6lrdc7tNswF8o/co0=;
        b=GY9GuVCyDWV7G9Op7Y4vYhENsh4+o9ByOvr8xYhSHepary4AArxMIKeIn07M3anZNK
         1B0vpC7C5fTp/UJrn1nwDjH6ES8fyVbRDrTuKeZtxGGpCX7NhK8U9CrQzlCEW8Jbku+x
         /OpO5MuIDYAr6Zr08MT3hA6P1pRBaxVN1z/Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:message-id:x-mailer:in-reply-to:references:date;
        b=F/OnN9hN5CbovzOgfC7C6OcrO2HhwluQTfQXe3zHvFZ91Wi3ozSnNvskkElu+G+kdZ
         w/cxmt6gENLl+L/jFI+RyqNLGcmLnaliRgVYsmL8OQQgt40edjtEeak8MNdjccnYDmDJ
         fprUEFade6W5Dx9wWIBJm+lpHx6B+J0PmDnWw=
Received: by 10.14.43.218 with SMTP id l66mr1810895eeb.188.1301327704011;
        Mon, 28 Mar 2011 08:55:04 -0700 (PDT)
Received: from localhost.localdomain ([174.143.243.243])
        by mx.google.com with ESMTPS id v1sm2878807eeh.6.2011.03.28.08.54.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 08:55:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.18.g68fe8
In-Reply-To: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170146>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-tag.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 0b24c87..3dd78a0 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -243,7 +243,7 @@ On Backdating Tags
 
 If you have imported some changes from another VCS and would like
 to add tags for major releases of your work, it is useful to be able
-to specify the date to embed inside of the tag object.  The data in
+to specify the date to embed inside of the tag object; such data in
 the tag object affects, for example, the ordering of tags in the
 gitweb interface.
 
-- 
1.7.4.18.g68fe8
