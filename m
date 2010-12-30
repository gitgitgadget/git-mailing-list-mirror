From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 4/4] gitweb: add vim modeline header which describes gitweb coding rule
Date: Thu, 30 Dec 2010 22:20:31 +0100
Message-ID: <1293744031-17790-5-git-send-email-sylvain@abstraction.fr>
References: <1293744031-17790-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 30 22:21:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYPvk-00089D-0M
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 22:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372Ab0L3VUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 16:20:46 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:44214 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab0L3VUq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 16:20:46 -0500
Received: by wwi17 with SMTP id 17so11674794wwi.1
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 13:20:44 -0800 (PST)
Received: by 10.227.72.198 with SMTP id n6mr5095441wbj.91.1293744044695;
        Thu, 30 Dec 2010 13:20:44 -0800 (PST)
Received: from localhost.localdomain (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id m10sm11283348wbc.16.2010.12.30.13.20.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Dec 2010 13:20:43 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4.523.g72f0d.dirty
In-Reply-To: <1293744031-17790-1-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164367>

It is useful for people who have their modeline compliant editor(s)
configured to replace tabs by spaces by default.

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 350f8b8..cfe86b4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1,4 +1,5 @@
 #!/usr/bin/perl
+# vim: syntax=perl tabstop=4 noexpandtab:
 
 # gitweb - simple web interface to track changes in git repositories
 #
-- 
1.7.3.4.523.g72f0d.dirty
