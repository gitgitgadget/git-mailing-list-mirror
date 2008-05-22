From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Add missing "short" alternative to --date in rev-list-options.txt
Date: Thu, 22 May 2008 18:24:41 +0300
Message-ID: <20080522152441.GA20594@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 17:25:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzCfg-0002xj-7T
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 17:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbYEVPYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 11:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYEVPYm
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 11:24:42 -0400
Received: from zakalwe.fi ([80.83.5.154]:40917 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762AbYEVPYm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 11:24:42 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 2A72A2BBF1; Thu, 22 May 2008 18:24:41 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82633>

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 Documentation/rev-list-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 631e9f4..f00b7f4 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -13,7 +13,7 @@ include::pretty-options.txt[]
 
 	Synonym for `--date=relative`.
 
---date={relative,local,default,iso,rfc}::
+--date={relative,local,default,iso,rfc,short}::
 
 	Only takes effect for dates shown in human-readable format, such
 	as when using "--pretty". log.date config variable sets a default
-- 
1.5.4.1
