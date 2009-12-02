From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv9 02/11] Rename t9301 to t9350,
 to make room for more fast-import tests
Date: Wed, 02 Dec 2009 03:09:34 +0100
Message-ID: <1259719783-4674-3-git-send-email-johan@herland.net>
References: <1259719783-4674-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 03:10:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFefd-0005XN-Eo
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 03:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbZLBCKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 21:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754466AbZLBCKH
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 21:10:07 -0500
Received: from smtp.getmail.no ([84.208.15.66]:44154 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754457AbZLBCKF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 21:10:05 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU000GVN60ZEG10@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 03:10:11 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU000JVB60NVI30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 03:10:11 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.2.15716
X-Mailer: git-send-email 1.6.5.3.433.g11067
In-reply-to: <1259719783-4674-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134283>

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/{t9301-fast-export.sh => t9350-fast-export.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t9301-fast-export.sh => t9350-fast-export.sh} (100%)

diff --git a/t/t9301-fast-export.sh b/t/t9350-fast-export.sh
similarity index 100%
rename from t/t9301-fast-export.sh
rename to t/t9350-fast-export.sh
-- 
1.6.5.3.433.g11067
