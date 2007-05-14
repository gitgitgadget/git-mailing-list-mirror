From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: user-manual patches
Date: Mon, 14 May 2007 11:20:23 -0400
Message-ID: <453.646170399402$1179156034@news.gmane.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 17:20:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HncLe-0005wV-Jz
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117AbXENPUZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755110AbXENPUZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:20:25 -0400
Received: from mail.fieldses.org ([66.93.2.214]:48236 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760AbXENPUY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:20:24 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HncLX-0004xS-Js; Mon, 14 May 2007 11:20:23 -0400
X-Mailer: git-send-email 1.5.1.4.19.g69e2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47249>


Since Johannes Schindelin said he'd be offline I thought I'd go ahead
and pick up his source code overview for the user manual.  I tried to
address your comments in a subsequent patch.

Also rework some of the glossary definitions, start moving some of
Documentation/howto into the manual, revise the preface a little, and
move the quick-start to an appendix.

Also available in the maint branch of my git repo:

	git://linux-nfs.org/~bfields/git.git maint

--b.
