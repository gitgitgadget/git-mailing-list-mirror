From: Florian Forster <octo@verplant.org>
Subject: [PATCH 0/7] Improve ANSI C99 compliance
Date: Sun, 18 Jun 2006 17:18:02 +0200
Message-ID: <11506438892865-git-send-email-octo@verplant.org>
References: <20060618083502.GB1331@verplant.org>
Reply-To: Florian Forster <octo@verplant.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 17:18:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frz2X-0005I9-EM
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 17:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWFRPSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 11:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWFRPSO
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 11:18:14 -0400
Received: from verplant.org ([213.95.21.52]:35209 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S1751163AbWFRPSN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 11:18:13 -0400
Received: from leeloo.lan.home.verplant.org ([2001:780:104:1:2e0:18ff:fead:37e4] ident=Debian-exim)
	by huhu.verplant.org with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Frz2S-0004ZW-5M
	for git@vger.kernel.org; Sun, 18 Jun 2006 17:18:12 +0200
Received: from localhost
	([127.0.0.1] helo=localhost.localdomain ident=octo)
	by leeloo.lan.home.verplant.org with esmtp (Exim 4.62)
	(envelope-from <octo@verplant.org>)
	id 1Frz2P-00028O-3G
	for git@vger.kernel.org; Sun, 18 Jun 2006 17:18:09 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3
In-Reply-To: <20060618083502.GB1331@verplant.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22085>

Hi,

as promised I've split up the changes into several smaller patches. The changes
are grouped by type of problem they fix, as requested. The patches should not
depend on each other, but I didn't actually test that.

Regards,
-octo
