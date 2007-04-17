From: Christian Couder <chriscool@tuxfamily.org>
Subject: Bisect: rename "t/t6030-bisect-run.sh" to
 "t/t6030-bisect-porcelain.sh".
Date: Tue, 17 Apr 2007 06:51:48 +0200
Message-ID: <20070417065148.69d06420.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 06:43:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdfXX-0006LT-E7
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 06:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031087AbXDQEng (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 00:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031084AbXDQEng
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 00:43:36 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:55018 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031087AbXDQEnf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 00:43:35 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id A2918B92E2;
	Tue, 17 Apr 2007 06:43:34 +0200 (CEST)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44723>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 ...030-bisect-run.sh => t6030-bisect-porcelain.sh} |    0 
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t6030-bisect-run.sh => t6030-bisect-porcelain.sh} (100%)

diff --git a/t/t6030-bisect-run.sh b/t/t6030-bisect-porcelain.sh
similarity index 100%
rename from t/t6030-bisect-run.sh
rename to t/t6030-bisect-porcelain.sh
-- 
1.5.1.1.821.g88bdb-dirty
