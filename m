From: Alangi Derick <alangiderick@gmail.com>
Subject: [PATCH] Fixed a typographical error
Date: Mon, 25 May 2015 16:07:05 +0100
Message-ID: <55633a99.xZnVU1n2HFdRqJGY%alangiderick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: alangiderick@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 17:08:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ywtz9-0004eG-IO
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 17:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbbEYPIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 11:08:06 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35097 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbbEYPIF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 11:08:05 -0400
Received: by wgme6 with SMTP id e6so6692756wgm.2
        for <git@vger.kernel.org>; Mon, 25 May 2015 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=1m6iTlquQO/9dJD19HGw1qfOJ6goHu/ijspFyLm0NLA=;
        b=jXMi1CBfT9qOVWRMX/xWm2nmHp1Ri41J+lRCVm5FvQISMmBlYTRbZ/UdzJkypnyQ1P
         0BhyPyDIMFqb0hZXJtcLw/m86MKptPE7fi7gzXcsIoe05uBYbQyURAI+BbVdg2sV+PCX
         e1fnBgLCGD/a5oa5D/PogDJ7nuMPeMM+ADlW0zZlPqkEPRZ0W5SrgQC6iUV8AuVC1YyL
         9+I6CNQBtzo5Yy2Z4qu191dwiim9dFwzNpCMMUeDI+gyJ9WFvKcCbJurcc5Hi1cwCP7o
         jA30T2MT8Ko3koZ+dPLghZEyuPxl0xfbNxh9280x35FpIoUhAg3nrITUGwqw5KJOZk0m
         G5Ig==
X-Received: by 10.180.73.176 with SMTP id m16mr33063619wiv.68.1432566483965;
        Mon, 25 May 2015 08:08:03 -0700 (PDT)
Received: from localhost ([41.205.24.229])
        by mx.google.com with ESMTPSA id ng5sm12293420wic.24.2015.05.25.08.07.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2015 08:08:03 -0700 (PDT)
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269840>

>From e8c2ea38865cf5dcc135e34ec2e80def8736b582 Mon Sep 17 00:00:00 2001
From: Alangi Derick <alangiderick@gmail.com>
Date: Sun, 24 May 2015 14:58:30 +0100
Subject: [PATCH] Fixed a typographical error

This is a patch to fix a typographical error in the 2.5.0.txt file in
the Documentation/RelNotes directory. The error was in the word "thoughout"
which was to be spelled "throughout" based on the context of the sentence.

Signed-off-by: Alangi Derick <alangiderick@gmail.com>
---
 Documentation/RelNotes/2.5.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.5.0.txt b/Documentation/RelNotes/2.5.0.txt
index a11e53c..02fdc66 100644
--- a/Documentation/RelNotes/2.5.0.txt
+++ b/Documentation/RelNotes/2.5.0.txt
@@ -32,7 +32,7 @@ UI, Workflows & Features
 
 Performance, Internal Implementation, Development Support etc.
 
- * "unsigned char [20]" used thoughout the code to represent object
+ * "unsigned char [20]" used throughout the code to represent object
    names are being converted into a semi-opaque "struct object_id".
    This effort is expected to interfere with other topics in flight,
    but hopefully will give us one extra level of abstraction in the
-- 
2.4.0.53.g8440f74.dirty
