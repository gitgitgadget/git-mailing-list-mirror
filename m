From: Guy Maurel <guy-kde@maurel.de>
Subject: a problem with the gitconfig file for user.email
Date: Sun, 13 Mar 2011 17:32:52 +0000 (UTC)
Message-ID: <loom.20110313T182907-610@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 13 19:00:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PypaQ-0007L6-Cm
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 19:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041Ab1CMSAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 14:00:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:48009 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063Ab1CMSAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 14:00:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PypaG-0007JR-Jc
	for git@vger.kernel.org; Sun, 13 Mar 2011 19:00:04 +0100
Received: from p5B303D80.dip.t-dialin.net ([91.48.61.128])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Mar 2011 19:00:04 +0100
Received: from guy-kde by p5B303D80.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Mar 2011 19:00:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.48.61.128 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20110207 Firefox/3.6.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168974>

why is it necessary to have a <TAB> before the email keyword in the [user]
section? Other keywords work with whitespace.
If not, one get the error message:
  fatal: bad config file line 2 in /home/guy-kde/.gitconfig
