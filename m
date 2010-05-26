From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 075/104] tests: chmod +x t5150
Date: Wed, 26 May 2010 18:00:45 +1200
Message-ID: <1274853674-18521-75-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9m5-00051a-A6
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934026Ab0EZGGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:37 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49306 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933941Ab0EZGG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:27 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 02:06:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 15B9233802;
	Wed, 26 May 2010 18:02:07 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nx1kIH0nwn5W; Wed, 26 May 2010 18:01:54 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 8B86C3389B;
	Wed, 26 May 2010 18:01:32 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147767>

From: Jeff King <peff@peff.net>

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/t5150-request-pull.sh

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
old mode 100644
new mode 100755
-- 
1.7.1.rc2.333.gb2668
