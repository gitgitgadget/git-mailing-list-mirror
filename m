From: Bartolomeo Nicolotti <bnicolotti@siapcn.it>
Subject: 500Mb file erroneously commited
Date: Mon, 6 Jun 2011 07:43:20 +0000 (UTC)
Message-ID: <loom.20110606T093627-918@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 09:45:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTUUr-00010J-FH
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 09:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797Ab1FFHpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 03:45:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:56676 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050Ab1FFHpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 03:45:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QTUUk-0000y7-4B
	for git@vger.kernel.org; Mon, 06 Jun 2011 09:45:06 +0200
Received: from 93.51.119.33 ([93.51.119.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 09:45:06 +0200
Received: from bnicolotti by 93.51.119.33 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 09:45:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 93.51.119.33 (Mozilla/5.0 (X11; U; Linux i686; it; rv:1.9.2.17) Gecko/20110422 Ubuntu/8.04 (hardy) Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175101>

Hello,

we're using CVS to store some sources, but for some big projects I'm considering
to use git. Last week it has happened that one collegue erroneously commited one
big file, 500Mb the file only. To avoid to have this file in the repository
we've deleted the history file in the CVS repository, the one with ,v, this has
been easy as each file has its own history. Would it be possible to do the same
with git, or there's no possibility to delete a 500Mb file erroneously commited? 

Many thanks

Best regards

Bartolomeo
