From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Avoid duplicate test number t7609
Date: Mon, 13 Dec 2010 11:14:02 +0100
Message-ID: <4D05F1EA.9000403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 11:14:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS5Q5-0006CB-Ue
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 11:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862Ab0LMKOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 05:14:08 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29857 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754781Ab0LMKOH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 05:14:07 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PS5Pv-0001Xj-Dq; Mon, 13 Dec 2010 11:14:03 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 31D481660F;
	Mon, 13 Dec 2010 11:14:03 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163552>

From: Johannes Sixt <j6t@kdbg.org>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/{t7609-merge-abort.sh => t7611-merge-abort.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t7609-merge-abort.sh => t7611-merge-abort.sh} (100%)

diff --git a/t/t7609-merge-abort.sh b/t/t7611-merge-abort.sh
similarity index 100%
rename from t/t7609-merge-abort.sh
rename to t/t7611-merge-abort.sh
-- 
1.7.3.3.1800.g26f22
