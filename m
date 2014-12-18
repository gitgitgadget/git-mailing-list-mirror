From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/1] Documentation: config: typo fixed
Date: Thu, 18 Dec 2014 17:30:27 +0600
Message-ID: <1418902227-27865-1-git-send-email-kuleshovmail@gmail.com>
References: <1418902079-27794-1-git-send-email-kuleshovmail@gmail.com>
Cc: <git@vger.kernel.org>, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 12:30:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1ZI7-0003u8-9J
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 12:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbaLRLan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 06:30:43 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36869 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbaLRLam (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 06:30:42 -0500
Received: by mail-lb0-f170.google.com with SMTP id 10so799381lbg.15
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 03:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NopFbJ0QEK/kWjXetHVVsD9kEG0NAMgUhzlxj7hYiKU=;
        b=zSlGnU9GltX5Y3h+r+nnfrWz9XKNUfJ1woa4rPiRRLzu4YInAYq5Q0Qkv3Q6lLNUuH
         R6gNG8Ug0fdo2I/PzA1TIKIeladxMqM+W4B5ZHok0J2GekdM4suX02MM34qhomVY+8+9
         BG1lOVqwXE1TOWxuDWsV7vYff3G9sI/djzAvgb5Lo9lijYXaSvu7VkmZo8GwW9u74M1y
         PXx/sjR6e2sX88UeCZOtMGUSFfZ1y64m84K+yjW5Z/b80eER9snt87EUppiVcVK0RdQZ
         sLqf0aG866/IQkWH6yUEd+Y36CiXmhmFXuNplzRyHcPfErjkp7tgro2kyNlkE+2p0Keq
         7asw==
X-Received: by 10.152.21.9 with SMTP id r9mr1735650lae.76.1418902241250;
        Thu, 18 Dec 2014 03:30:41 -0800 (PST)
Received: from localhost.localdomain ([2.133.0.167])
        by mx.google.com with ESMTPSA id ze5sm1697998lbb.28.2014.12.18.03.30.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Dec 2014 03:30:40 -0800 (PST)
X-Mailer: git-send-email 2.2.0.64.g3889e7a.dirty
In-Reply-To: <1418902079-27794-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261522>

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
