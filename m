From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] t1402: Make test executable
Date: Mon,  2 Nov 2009 01:30:05 -0800
Message-ID: <1257154205-7400-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 10:31:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4tEw-0007Ex-M6
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 10:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbZKBJaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 04:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754190AbZKBJaF
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 04:30:05 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:52718 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbZKBJaE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 04:30:04 -0500
Received: by yxe17 with SMTP id 17so4347982yxe.33
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 01:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=4F+K7wXNOZ+UUlt8NQPBjnoHD/HNPHZhL6Rn+Y5tRMc=;
        b=Yy5YE4NN2iRP09mMcAMw4hGQnSXzPmfFRK0A7RfvvVKoEIYM+8BFf0LQvQ469rZRWR
         MsrjYc6HwNc4o3NZuYf1w592UsOkQbO7UeKL6nmoCXI6gggGZDRtG0QLCps4kxFvHDSe
         SJDcPiQsbjjvdLoZ48F/F1dPnBnzLnEftY11M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dn/54ZTZCqz/nNG/tLCoRo1b9D1CvnlLmmC+ULoUZSrD/em2VkGfvnojv/sIwIEZYZ
         X62WvcTVxdmJ0xQ5xjBOB2E0P3+f1Gb72GNyVsmhYYRyM683PwDAHl7pAvaEUJqBl5VO
         cFHzZFPS+8hHR1NtuGNTlIIQsq3lbdqFC3jIE=
Received: by 10.150.129.23 with SMTP id b23mr7817513ybd.175.1257154209608;
        Mon, 02 Nov 2009 01:30:09 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 15sm1346353gxk.4.2009.11.02.01.30.07
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Nov 2009 01:30:08 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Mon, 02 Nov 2009 01:30:05 -0800
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131898>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/t1402-check-ref-format.sh

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
old mode 100644
new mode 100755
-- 
1.6.5.2.181.gd6f41
