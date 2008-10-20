From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH] workflows documentation: fix link to git-request-pull[1]
Date: Mon, 20 Oct 2008 11:35:31 -0600
Message-ID: <1224524131-11299-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 20 23:47:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrygS-0007QH-CX
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 19:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbYJTRff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 13:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbYJTRff
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 13:35:35 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:59647 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbYJTRfe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 13:35:34 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2087043wfd.4
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=8umAFIHeTgqr846uW0b1pWO0GzVjVBgY+XbsYyWTpJ0=;
        b=LDgB51urm6uod34MLpDDgx1Niv0JhLEQ42hH75TMiutJF2fWF72YaMG9DWK7pt00A+
         UfEoPLc5kE3DNpTphCi/qUhBh5c0COcG1l73Y6jNZa6luk1cfp5OL/KLpLrabb7RGKqn
         A0Itmd0nsYZrpEkkfVOwIdSWxcLPfMoYgiGcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RnWBJWK92bF1zuCAa1mZrtYD3xQuCuLHOJJozS/BbR2BtpDpaoV/tStDbTtC8OCh4g
         pAFmMPPKeaBWyC/7iF1XDKiZbwMqqf4E65yyCfsTvqKKFczwk9ZtKGVcJnqxfV9IsO8T
         Jv64N9/GnFz6kjz1Pa3PO3yYmhT1N4dOlmUMY=
Received: by 10.140.127.13 with SMTP id z13mr5006725rvc.194.1224524133612;
        Mon, 20 Oct 2008 10:35:33 -0700 (PDT)
Received: from localhost.localdomain (c-75-71-41-234.hsd1.co.comcast.net [75.71.41.234])
        by mx.google.com with ESMTPS id l31sm687345rvb.2.2008.10.20.10.35.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Oct 2008 10:35:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.588.g3102
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98716>

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 Documentation/gitworkflows.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 7fe9f72..2b021e3 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -258,7 +258,7 @@ from.
 =====================================
 
 You will still have to tell people by other means, such as mail.  (Git
-provides the linkgit:request-pull[1] to send preformatted pull
+provides the linkgit:git-request-pull[1] to send preformatted pull
 requests to upstream maintainers to simplify this task.)
 
 If you just want to get the newest copies of the integration branches,
-- 
1.6.0.2.588.g3102
