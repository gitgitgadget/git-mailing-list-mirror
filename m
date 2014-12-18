From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/1] Documentation: config: typo fixed
Date: Thu, 18 Dec 2014 17:27:59 +0600
Message-ID: <1418902079-27794-1-git-send-email-kuleshovmail@gmail.com>
Cc: <git@vger.kernel.org>, 0xAX <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 12:28:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1ZGH-0003Hm-MK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 12:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbaLRL2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 06:28:43 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:36371 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaLRL2m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 06:28:42 -0500
Received: by mail-la0-f51.google.com with SMTP id ms9so799653lab.24
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 03:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KtTcTr9zF+OwXjBFrCzGxOtYAphXMXDi59hyu57ikiU=;
        b=q8kwOZrklcqnRxZX4WcCZx1Aq2yBx8Foc1kQ1QS4HXPO02kGrDqtIfABwfbC3Y+Hyv
         a9VZhDdy3zqVpR+/K8P0u1sdOoDrDjvz6w+XvrEmFBlH275tJ3XAQAG39l5kHry/k/RH
         JlhlGKnGIwTmszadKO/q6OB5f5Rg2BsclNh93L6B4WYt/fbZLj8EkncEnvucFG9pvLHh
         KZn93y7gCX5MZaKHwyC6vA63y+WtUknkrWa6cGiISGFRfwAHvXRi2UZk0tZTMRBcNIIz
         IRF/frvQMuB+60Jm6NN2T7/1SL4w0neXT8K05exK3zhSeOybU5PrGa1qRpsNbpGpFW8T
         U0Ww==
X-Received: by 10.152.36.165 with SMTP id r5mr1622780laj.93.1418902121140;
        Thu, 18 Dec 2014 03:28:41 -0800 (PST)
Received: from localhost.localdomain ([2.133.0.167])
        by mx.google.com with ESMTPSA id zp3sm1692799lbb.45.2014.12.18.03.28.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Dec 2014 03:28:40 -0800 (PST)
X-Mailer: git-send-email 2.2.0.64.g3889e7a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261521>

From: 0xAX <kuleshovmail@gmail.com>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f615a5c..a995b68 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -203,7 +203,7 @@ advice.*::
 		show directions on how to proceed from the current state.
 --
 
-core.fileMode::
+core.filemode::
 	Tells Git if the executable bit of files in the working tree
 	is to be honored.
 +
-- 
2.2.0.64.g3889e7a.dirty
