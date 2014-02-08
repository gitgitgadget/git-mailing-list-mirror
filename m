From: "Albert L. Lash, IV" <albert.lash@gmail.com>
Subject: [PATCH 2/4] docs/git-remote: capitalize first word of initial blurb
Date: Sat,  8 Feb 2014 15:41:35 -0500
Message-ID: <1391892097-16169-2-git-send-email-alash3@bloomberg.net>
References: <1391892097-16169-1-git-send-email-alash3@bloomberg.net>
Cc: "Albert L. Lash, IV" <alash3@bloomberg.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 21:51:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCEs9-0005GA-9I
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 21:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbaBHUvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 15:51:18 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:62579 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbaBHUvC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 15:51:02 -0500
Received: by mail-qc0-f171.google.com with SMTP id n7so8414332qcx.30
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 12:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/5E+rbuGk4KJPKpBF6vSZFTa0u3GONbp/R0QDbxBl6U=;
        b=NcepxCWTM8uerc5lv62gkZcSL7bedrTvbf0g5WHwuEXij3a5ZVwqEVXqhH7o5NgJCE
         t7H+Sz++DaDkoQk4wWUMCimQpKgaBpjjgX4X1I+sFLLMx3227Auxn2xyc1Xy0FC1ziHU
         PkxExzfBbEeIg8aouDsnodurY9X0LeCQKNJkXPg721hLQYyfSKd2JBF38f4lhQWD0YMD
         SAfWdeSPjqghpwMxp4qWyB4VkeTDsKIyQUL45ozMzLciO7HgG8nifG7gkJs+EadEkCbU
         Kjja/BT1Q42TkZS8ojIwXRZ03GdfbWHGXHQXkrPjGMxTq3oQLcZ0gr8STie7EMhNJ2z5
         IVFQ==
X-Received: by 10.224.98.212 with SMTP id r20mr34429516qan.0.1391892661075;
        Sat, 08 Feb 2014 12:51:01 -0800 (PST)
Received: from osday-ubuntu.bloomberg.com ([65.115.226.27])
        by mx.google.com with ESMTPSA id o75sm15994005qgd.11.2014.02.08.12.50.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 12:51:00 -0800 (PST)
X-Mailer: git-send-email 1.9.0.rc3.4.g9111436
In-Reply-To: <1391892097-16169-1-git-send-email-alash3@bloomberg.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241859>

All other man files have capitalized descriptions which
immediately follow the command's name. Let's capitalize
this one too for consistency.

Signed-off-by: Albert L. Lash, IV <alash3@bloomberg.net>
---
 Documentation/git-remote.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 2507c8b..cb103c8 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -3,7 +3,7 @@ git-remote(1)
 
 NAME
 ----
-git-remote - manage set of tracked repositories
+git-remote - Manage set of tracked repositories
 
 
 SYNOPSIS
-- 
1.8.3.2
