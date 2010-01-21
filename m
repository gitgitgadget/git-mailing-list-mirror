From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Make test case numbers unique
Date: Thu, 21 Jan 2010 08:57:03 +0100
Message-ID: <4B5808CF.20006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 08:57:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXrun-0006KD-1r
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 08:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab0AUH5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 02:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754818Ab0AUH5M
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 02:57:12 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13651 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754809Ab0AUH5M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 02:57:12 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NXrua-0006rn-15; Thu, 21 Jan 2010 08:57:04 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BE0CD1660F;
	Thu, 21 Jan 2010 08:57:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137637>

From: Johannes Sixt <j6t@kdbg.org>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 ...ex-gitfile.sh => t2105-update-index-gitfile.sh} |    0
 ...threedots.sh => t3416-rebase-onto-threedots.sh} |    0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t2104-update-index-gitfile.sh => t2105-update-index-gitfile.sh} (100%)
 rename t/{t3415-rebase-onto-threedots.sh => t3416-rebase-onto-threedots.sh} (100%)

diff --git a/t/t2104-update-index-gitfile.sh b/t/t2105-update-index-gitfile.sh
similarity index 100%
rename from t/t2104-update-index-gitfile.sh
rename to t/t2105-update-index-gitfile.sh
diff --git a/t/t3415-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
similarity index 100%
rename from t/t3415-rebase-onto-threedots.sh
rename to t/t3416-rebase-onto-threedots.sh
-- 
1.6.6.1.1385.ge9ce6.dirty
