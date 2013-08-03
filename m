From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] .mailmap: Multiple addresses of Michael S. Tsirkin
Date: Sat,  3 Aug 2013 13:54:03 +0200
Message-ID: <1375530843-2460-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, mst@kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 13:53:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aP1-0002B7-VE
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 13:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249Ab3HCLxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 07:53:40 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:43197 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab3HCLxj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 07:53:39 -0400
Received: by mail-ee0-f52.google.com with SMTP id c41so767272eek.25
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 04:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=puxlH904WzxkrIHwl1hlVMk4sPNljtLFssacHRSZs9Q=;
        b=gPqKpye/HEKojBegFBCaqVZD8iObchdqI7gg+8Pcqqs2AW0McnP7isIDAfnueqPDc0
         F5BUvZmlV5Hjg0aHAWJN9NGXAqR1cwss73UleqvMxLV97qTaDkb58dgtH0aIaPmfdIsK
         WocyW+ettVuth6s81nLd/oQS4UctahKhdfeU8sy7zYYcYeMGkLUGJqLGRYEBYrM+5UM1
         SqOrfDnxDy+2lsceDd/eB2PbonwGxqnL58aSRWOZ7OiiSTsOiLMfi2ISE6H9ejMLy8CM
         youBNz3uXTiyxPeI2Pme0W1PfpmafKtIFI7Um/sucHqT/iywZQubX9YsQMm0ZypXPo0a
         BlnQ==
X-Received: by 10.15.49.72 with SMTP id i48mr9231882eew.37.1375530817699;
        Sat, 03 Aug 2013 04:53:37 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id v41sm18892226eep.10.2013.08.03.04.53.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 04:53:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231592>

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 57551b0..dfa2e65 100644
--- a/.mailmap
+++ b/.mailmap
@@ -130,6 +130,9 @@ Matthias Urlichs <matthias@urlichs.de> <smurf@kiste.(none)>
 Matthias Urlichs <matthias@urlichs.de> <smurf@smurf.noris.de>
 Michael Coleman <tutufan@gmail.com>
 Michael J Gruber <git@drmicha.warpmail.net> <michaeljgruber+gmane@fastmail.fm>
+Michael S. Tsirkin <mst@kernel.org> <mst@redhat.com>
+Michael S. Tsirkin <mst@kernel.org> <mst@mellanox.co.il>
+Michael S. Tsirkin <mst@kernel.org> <mst@dev.mellanox.co.il>
 Michael W. Olson <mwolson@gnu.org>
 Michael Witten <mfwitten@gmail.com> <mfwitten@MIT.EDU>
 Michael Witten <mfwitten@gmail.com> <mfwitten@mit.edu>
-- 
1.8.4.rc0.16.g7fca822.dirty
