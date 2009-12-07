From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv10 02/11] Rename t9301 to t9350,
 to make room for more fast-import tests
Date: Mon, 07 Dec 2009 12:27:25 +0100
Message-ID: <1260185254-1523-3-git-send-email-johan@herland.net>
References: <1260185254-1523-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 12:29:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHbmC-0007m5-Nc
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 12:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933864AbZLGL1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 06:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933799AbZLGL1m
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 06:27:42 -0500
Received: from smtp.getmail.no ([84.208.15.66]:34269 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933770AbZLGL1l (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 06:27:41 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUA00L0Q56A4350@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Dec 2009 12:27:46 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUA002OO5616830@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Dec 2009 12:27:46 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.7.111518
X-Mailer: git-send-email 1.6.5.3.433.g11067
In-reply-to: <1260185254-1523-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134741>

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
