From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 36/45] rebase: cherry-pick: add copyright
Date: Sun,  9 Jun 2013 11:40:48 -0500
Message-ID: <1370796057-25312-37-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlijU-0007SX-Qo
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523Ab3FIQoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:39 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:53045 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab3FIQod (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:33 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so1113466oah.7
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Y/RJUXcFALG271RUcOwjYDZr3dEjZtWe8vzg5GAo9Sg=;
        b=yBs4xlrofR2KL94ITOkIlw/DrPZ7ObpCWavBISQ+bf1Fp8TfvFKdqsarv5I7l84yAD
         ayULDWNV3NNpzzgSrCl3orp7Y0NwQg9tJsy4lQESnqaTnhWKDx8zvLR+2NQAq0Ts4KH5
         3Ouvae9kMUzCMVUSel0M5QMluvfB82NNOM7r5OxzvvTtdVyooGKXDdTFsgZ9zqftzVR4
         xAmD7AWuh7tS9XLY9WHmrLYzXrcjAOj+m8nz85SmVoLTOgaUySPJ1Ab4E3OfZJw4XGue
         F2S+6hpP5g0LNY2BpBFiixznv1uFlVmordZSaLMPpcnPshg3bg726txYonFc785ThlRu
         F1mg==
X-Received: by 10.182.219.166 with SMTP id pp6mr4910203obc.66.1370796272676;
        Sun, 09 Jun 2013 09:44:32 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c10sm15208646oej.1.2013.06.09.09.44.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227005>

Probably enough changes to warrant that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index 644d45e..e36e104 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# Copyright (c) 2010 Junio C Hamano.
+# Copyright (c) 2013 Felipe Contreras
 #
 
 GIT_CHERRY_PICK_HELP="$resolvemsg"
-- 
1.8.3.698.g079b096
