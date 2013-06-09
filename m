From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 36/36] rebase: cherry-pick: add copyright
Date: Sun,  9 Jun 2013 14:24:50 -0500
Message-ID: <1370805890-3453-37-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllI4-00048m-Bj
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab3FIT2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:28:30 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:52572 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab3FIT21 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:28:27 -0400
Received: by mail-oa0-f49.google.com with SMTP id k14so5009128oag.22
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Y/RJUXcFALG271RUcOwjYDZr3dEjZtWe8vzg5GAo9Sg=;
        b=hsuTuI0W7u5dP8RU8yjgw8v0gqfJZ3Ueq6WRMndDABfb8SD/KBGO7kXWOMSbB8supS
         fRF52NbuelK4iKovqLO9LO4jvj5XE76AhzAk3kRTQNcD+k4tPE/aBLF4otSCAvhgCz/L
         XE96q05Mj9GALa3dexsvrLLmdKKqJrojC6rrivAgQ3lqnOK2zRvS6IPfLMx0Us2BzQJM
         komQ9RFuPRXUcL6tjbDtK9W76nZF310L62HBejVxlreO1eobkIspuZT+CWFr3cYuimCX
         CjDULl3R6oMkSFlk89/8j/tMciI3KrGZQMYeNdTbe72v9Bvt0h+KvrZ6j9DUbXyLtRSt
         3+HA==
X-Received: by 10.60.102.145 with SMTP id fo17mr5476413oeb.76.1370806107255;
        Sun, 09 Jun 2013 12:28:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c10sm16304387oej.1.2013.06.09.12.28.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:28:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227142>

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
