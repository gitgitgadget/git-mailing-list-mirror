From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 2/2] .mailmap: Combine my emails
Date: Wed, 23 Jul 2014 14:32:10 +0200
Message-ID: <1406118730-13224-2-git-send-email-stefanbeller@gmail.com>
References: <1406118730-13224-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 23 14:32:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9vif-0005sD-OY
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 14:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665AbaGWMcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 08:32:23 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:65382 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbaGWMcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 08:32:21 -0400
Received: by mail-wi0-f175.google.com with SMTP id ho1so7613815wib.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A6BhuIV0uL0kTdwT2Oaq1mm8UCyb/oFIKKpcsRqecQc=;
        b=XuakhJL60tm9pzwQ69FtTp1JC4OZa/GlxJW9OmGb1lIr/Q1jo1TavhkGnM7Bq2pWur
         ByTsDNx+6GK5LfVOKhdbGK+dQwMPlnBxCuVoRt0v69p492SZ7k/rRgKGIxNQr7w6G1FI
         SAx/8GcIojkbEokiHwuA5BhfBL88hzGTncOnYr6N2rHVJwrpNsGbWjlSj+DDgh5SovB/
         0C9k2MNY8/G1cawfsR2P++AfXDnv6yDSX2A3+CBFj5hhN/0/ElXM8Umr3REh9YPQBEnI
         sbqUxmCqv3NszysWmfoRdArLJEC4Eu3MOJWQnSFGgK0lX3p+1eeHn0q0y5i+Gaxcyb3c
         MeHw==
X-Received: by 10.180.187.197 with SMTP id fu5mr9687365wic.64.1406118739452;
        Wed, 23 Jul 2014 05:32:19 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id mv3sm8951548wic.21.2014.07.23.05.32.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 05:32:18 -0700 (PDT)
X-Mailer: git-send-email 2.0.2.608.g398dd4b
In-Reply-To: <1406118730-13224-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254072>

Google mail has had the extension @googlemail.com for a long time
in Germany as @gmail.de was already taken by a competitor.
Nowadays the original gmail company isn't there anymore(?), hence
Googlemail also introduced @gmail.com in Germany, which I switched to.

This changed mail address of mine first appeared in 398dd4bd039680b
(2014-07-10, .mailmap: map different names with the same email
address together) ironically.

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 2edbeb5..8aefb5a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -204,6 +204,7 @@ Seth Falcon <seth@userprimary.net> <sfalcon@fhcrc.org>
 Shawn O. Pearce <spearce@spearce.org>
 Simon Hausmann <hausmann@kde.org> <simon@lst.de>
 Simon Hausmann <hausmann@kde.org> <shausman@trolltech.com>
+Stefan Beller <stefanbeller@gmail.com> <stefanbeller@googlemail.com>
 Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@atlas-elektronik.com>
 Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@googlemail.com>
 Stefan Sperling <stsp@elego.de> <stsp@stsp.name>
-- 
2.0.2.608.g398dd4b
