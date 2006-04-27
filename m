From: David Woodhouse <dwmw2@infradead.org>
Subject: Two gitweb feature requests
Date: Thu, 27 Apr 2006 14:27:05 +0100
Message-ID: <1146144425.11909.450.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 15:27:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZ6WZ-0000Jq-Dw
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 15:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWD0N1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 09:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWD0N1M
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 09:27:12 -0400
Received: from canuck.infradead.org ([205.233.218.70]:28624 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S965040AbWD0N1L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 09:27:11 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1FZ6WS-0003K4-DO; Thu, 27 Apr 2006 09:27:09 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19231>

First... When publishing trees, I currently give both the git:// URL for
people who want to pull the tree, and the http:// URL to gitweb for
those who just want to browse.

It would be useful if I could get away with giving just one URL --
probably the http:// one to gitweb. If gitweb were to have a mode in
which it gave a referral to the git:// URL, and if the git tools would
use that, then that would work well.

Secondly, it would be useful if gitweb would list the branches in a
repository and allow each of them to be viewed in the same way as it
does the master branch.

-- 
dwmw2
