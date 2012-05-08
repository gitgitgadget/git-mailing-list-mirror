From: Tuomas Suutari <tuomas.suutari@gmail.com>
Subject: [PATCH] doc/column: Fix a typo
Date: Tue,  8 May 2012 15:49:55 +0300
Message-ID: <1336481395-16195-1-git-send-email-tuomas.suutari@gmail.com>
Cc: Tuomas Suutari <tuomas.suutari@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 14:50:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRjsW-0006Aq-Bb
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 14:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952Ab2EHMuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 08:50:52 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35198 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869Ab2EHMuv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 08:50:51 -0400
Received: by lbbgm6 with SMTP id gm6so4171291lbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=tFVa7wc7CqmeGzrL0xGyzJ6kOanK9SCn74zwaakZsuQ=;
        b=x62+G/x51rlJTrpn3MZNwVPlVA2rmOk5+hfbhIM2jAdm3PCuSAIY0MicupXT2fvsJG
         gT6yolwzBj6+JjOAm45pZ3n5sZXxzrNSdiplbnFJ9TVfPzC/PWTXE0/S3gW/XyRIo+Sn
         VnZnD5rQfZnu+8k6E3AmsYFCSSGkuNz/y8CLh39J1yXmOeRKFJ+lzb3UUgsAG53DTtxC
         HEilJcWbjjZ18kvRMgS/ddQI/y4UUh38X9A7hLMryyWZT/zvnceBSGbOkskiaEkxH0te
         ecrymGymhrDzos/z3Vi7qfEB0OvHyl5bpi6zYPcYJFMFf532y/NUEgQ18emN9nZhFirM
         xtfA==
Received: by 10.152.111.33 with SMTP id if1mr17926763lab.10.1336481450227;
        Tue, 08 May 2012 05:50:50 -0700 (PDT)
Received: from mikrohiiri.laitilanpuhelin.fi (ws-29-58.laitilanpuhelin.fi. [188.123.29.58])
        by mx.google.com with ESMTPS id hg12sm22334023lab.17.2012.05.08.05.50.48
        (version=SSLv3 cipher=OTHER);
        Tue, 08 May 2012 05:50:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197358>

Change --pading to --padding in usage.

Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>
---
 Documentation/git-column.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index 9be16ee..5d6f1cc 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git column' [--command=<name>] [--[raw-]mode=<mode>] [--width=<width>]
-	     [--indent=<string>] [--nl=<string>] [--pading=<n>]
+	     [--indent=<string>] [--nl=<string>] [--padding=<n>]
 
 DESCRIPTION
 -----------
-- 
1.7.5.4
