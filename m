From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 2/2 jc/1.7.0-diff-whitespace-only-status] Make test case number
 unique
Date: Thu, 27 Aug 2009 09:38:27 +0200
Message-ID: <4A9637F3.3030700@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 09:38:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgZZC-0005TO-RH
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 09:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbZH0Hid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 03:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbZH0Hid
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 03:38:33 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:20870 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbZH0Hid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 03:38:33 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MgZYx-0007bT-RV; Thu, 27 Aug 2009 09:38:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A1C349F88; Thu, 27 Aug 2009 09:38:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127145>

From: Johannes Sixt <j6t@kdbg.org>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 ...espace-status.sh => t4040-whitespace-status.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t4037-whitespace-status.sh => t4040-whitespace-status.sh} (100%)

diff --git a/t/t4037-whitespace-status.sh b/t/t4040-whitespace-status.sh
similarity index 100%
rename from t/t4037-whitespace-status.sh
rename to t/t4040-whitespace-status.sh
-- 
1.6.4.1.1371.g221f
