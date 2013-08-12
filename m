From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] .mailmap: Combine more (name, email) to individual persons
Date: Mon, 12 Aug 2013 10:12:09 +0200
Message-ID: <1376295129-2352-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 12 10:12:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8nER-0004Vw-9o
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 10:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272Ab3HLIL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 04:11:59 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:64848 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237Ab3HLIL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 04:11:58 -0400
Received: by mail-ea0-f172.google.com with SMTP id r16so3248715ead.17
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nKvtZaa54BGX5lW9rVqm5H0/weHSQwhg4BNS4dt5qqE=;
        b=lMmu57SChY/lMuqjXjlGbO8jUMP/U12tLlRkgZaiRS7Haf320eMO6IFaorLtWjVi3h
         DR6jY1Pal8kHx4q3YlSSLAXUxX8FfseiMKDgF6PMqHQO3tvBBsjKNICxLent+BxhC5K0
         B2vjNLxwr35ttonSe0zhzRi4u8pK/TcyEV1IYHBl9YQ0Jiv+lUgTBaqExo6v/pphFpZd
         MDzAdRiGrjDVwo5mtkWar7vh6WGaEREgNBSNZlrWC74Bn0mb3mAgB6D98qT81hz0xvpv
         p/nEBifHfgliOdNTBnU+VYShR1bozM1Gkj9M2IibU5Qtpvv0LNZ4DnDSM8w4/v+TXfza
         W4uw==
X-Received: by 10.14.203.196 with SMTP id f44mr24545436eeo.141.1376295117155;
        Mon, 12 Aug 2013 01:11:57 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k3sm55320693een.16.2013.08.12.01.11.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 01:11:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232175>

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index f7cc21e..1236b3a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -19,9 +19,11 @@ Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
 Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
+Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
-Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
+brian m. carlson <sandals@crustytoothpaste.ath.cx> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
+brian m. carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothpaste.net>
 Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
 Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
 Cheng Renquan <crquan@gmail.com>
-- 
1.8.4.rc2
