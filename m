From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: glossary and user-manual updates
Date: Sun, 18 Mar 2007 23:17:55 -0400
Message-ID: <29333.9269272566$1174274340@news.gmane.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 04:18:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8OZ-0000J6-Sz
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933813AbXCSDSF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933805AbXCSDSF
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:18:05 -0400
Received: from mail.fieldses.org ([66.93.2.214]:45757 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933788AbXCSDSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:18:04 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HT8Nl-0003JT-Ds; Sun, 18 Mar 2007 23:18:01 -0400
X-Mailer: git-send-email 1.5.0.3.g6c05
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42571>


Also available from:

	git://linux-nfs.org/~bfields/git.git

The main change is just to maintain the glossary manually instead of by
the sort_glossary.pl script; includes a subsequent patch to demonstrate
the sort of cleanup that allows.

--b.
