From: ayiehere@gmail.com
Subject: [PATCH] Update $GIT_DIR/remotes to $GIT_DIR/refs/remotes in docs
Date: Mon, 30 Nov 2009 11:38:35 +0800
Message-ID: <1259552316-20088-1-git-send-email-ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 04:57:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NExO9-00017G-3a
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 04:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbZK3D5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 22:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbZK3D5M
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 22:57:12 -0500
Received: from raven4.regentmarkets.com ([213.137.29.27]:34992 "EHLO
	raven4.regentmarkets.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbZK3D5M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 22:57:12 -0500
X-Greylist: delayed 1117 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Nov 2009 22:57:12 EST
Received: from mailvz.regentmarkets.com (mindx.regentmarkets.com [202.168.70.162])
	by raven4.regentmarkets.com (Postfix) with SMTP id DDE902248293
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 03:38:39 +0000 (UTC)
Received: from mailvz.regentmarkets.com (localhost.localdomain [127.0.0.1])
	by mailvz.regentmarkets.com (Postfix) with ESMTP id 2ACF04E84A56
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 11:38:38 +0800 (MYT)
Received: from nazri (harimau [192.168.12.202])
	by mailvz.regentmarkets.com (Postfix) with ESMTP id 13CCF4E84732
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 11:38:37 +0800 (MYT)
Received: by nazri (sSMTP sendmail emulation); Mon, 30 Nov 2009 11:38:44 +0800
X-Mailer: git-send-email 1.6.6.rc0.63.g66abc
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134045>

I think this patch is is order now that $GIT_DIR/remotes is no longer used.
