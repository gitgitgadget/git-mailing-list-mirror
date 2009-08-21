From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Make test number t7406- unique
Date: Fri, 21 Aug 2009 10:32:25 +0200
Message-ID: <4A8E5B99.3080705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 10:32:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MePYC-0005TY-2T
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 10:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbZHUIce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 04:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbZHUIce
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 04:32:34 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28388 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbZHUIcd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 04:32:33 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MePXt-00058v-Ug; Fri, 21 Aug 2009 10:32:31 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B1BE49F88; Fri, 21 Aug 2009 10:32:25 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126694>

From: Johannes Sixt <j6t@kdbg.org>

We skip t7407 because a patch series is cooking that uses is.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 ...e-reference.sh => t7408-submodule-reference.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t7406-submodule-reference.sh => t7408-submodule-reference.sh} (100%)

diff --git a/t/t7406-submodule-reference.sh b/t/t7408-submodule-reference.sh
similarity index 100%
rename from t/t7406-submodule-reference.sh
rename to t/t7408-submodule-reference.sh
-- 
1.6.4.204.g6aad7
