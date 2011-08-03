From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH rc/histogram-diff] Make test number unique
Date: Wed, 03 Aug 2011 09:25:31 +0200
Message-ID: <4E38F7EB.3040400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 09:25:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoVpo-0008RJ-SG
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 09:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab1HCHZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 03:25:39 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:20864 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab1HCHZi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 03:25:38 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QoVpc-0008OE-3u; Wed, 03 Aug 2011 09:25:32 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D75241660F;
	Wed,  3 Aug 2011 09:25:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178547>

From: Johannes Sixt <j6t@kdbg.org>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 ...9-diff-histogram.sh => t4050-diff-histogram.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t4049-diff-histogram.sh => t4050-diff-histogram.sh} (100%)

diff --git a/t/t4049-diff-histogram.sh b/t/t4050-diff-histogram.sh
similarity index 100%
rename from t/t4049-diff-histogram.sh
rename to t/t4050-diff-histogram.sh
-- 
1.7.6.1571.g6e29e
