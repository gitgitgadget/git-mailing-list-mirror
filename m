From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv8 09/10] Rename t9301 to t9350,
 to make room for more fast-import tests
Date: Fri, 20 Nov 2009 02:39:13 +0100
Message-ID: <1258681154-2167-10-git-send-email-johan@herland.net>
References: <1258681154-2167-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 02:40:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBIU3-0004ED-VO
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473AbZKTBjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757439AbZKTBjr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:39:47 -0500
Received: from smtp.getmail.no ([84.208.15.66]:58324 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757384AbZKTBjp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 20:39:45 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTD00MOFWMESE10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Nov 2009 02:39:50 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTD00D7NWLXUY10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Nov 2009 02:39:50 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.11.20.12721
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1258681154-2167-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133288>

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
1.6.4.304.g1365c.dirty
