From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH 0/2] Section renaming can lose content
Date: Fri, 24 Jul 2009 17:21:42 -0400
Message-ID: <1248470504-16326-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 23:22:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUSDf-0004l0-ND
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 23:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbZGXVWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 17:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbZGXVWI
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 17:22:08 -0400
Received: from chmrr.net ([209.67.253.66]:39052 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754193AbZGXVWG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 17:22:06 -0400
Received: from c-67-186-135-139.hsd1.ma.comcast.net ([67.186.135.139] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1MUSDM-0001dq-Qx
	for git@vger.kernel.org; Fri, 24 Jul 2009 17:22:05 -0400
X-Mailer: git-send-email 1.6.3.3.473.gb74fc4.dirty
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Spam-Score: -4.4
X-Spam-Score-Int: -43
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-07-24 17:22:05
X-Connected-IP: 67.186.135.139:41933
X-Message-Linecount: 10
X-Body-Linecount: 3
X-Message-Size: 387
X-Body-Size: 118
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123947>

I submitted a patch to the testfile on the 8th; what follows is a pass
at solving the underlying bug as well.
 - Alex
