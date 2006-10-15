From: "Anand Kumria" <wildfire@progsoc.org>
Subject: svn revision id in git commit?
Date: Sun, 15 Oct 2006 16:59:48 +0000 (UTC)
Message-ID: <egtpe4$i8v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Oct 15 19:00:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ9LO-0008EW-V7
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 19:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWJORAD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 13:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWJORAD
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 13:00:03 -0400
Received: from main.gmane.org ([80.91.229.2]:40656 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161045AbWJOQ77 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 12:59:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZ9L7-0008BO-Ng
	for git@vger.kernel.org; Sun, 15 Oct 2006 18:59:54 +0200
Received: from 88-110-175-230.dynamic.dsl.as9105.com ([88.110.175.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 18:59:53 +0200
Received: from wildfire by 88-110-175-230.dynamic.dsl.as9105.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 18:59:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 88-110-175-230.dynamic.dsl.as9105.com
User-Agent: pan 0.113 (0.113 is one of Nakata's favorites)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28920>

Hi,

I'm using git-svnimport with great success; generally when I do a merge
from the subversion (via git-svnimport) I tag the revision number I merge
up to.

It'd be very helpful if git-svnimport stored the revision number that
caused a particular commit to be generated -- is this possible? Would this
be a 'note' field in a git commit? Has anyone else done work on
git-svnimport to store this?

If not, I'll probably give it a go shortly.

Thanks,
Anand
