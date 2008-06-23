From: Frederik Hohlfeld <frederik.hohlfeld@gmail.com>
Subject: exit status 141 from git-svn
Date: Mon, 23 Jun 2008 15:00:41 +0000 (UTC)
Message-ID: <loom.20080623T145909-992@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 17:02:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAnYI-0004gS-3J
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 17:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbYFWPAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 11:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbYFWPAx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 11:00:53 -0400
Received: from main.gmane.org ([80.91.229.2]:60072 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728AbYFWPAw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 11:00:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KAnXE-00087M-Km
	for git@vger.kernel.org; Mon, 23 Jun 2008 15:00:48 +0000
Received: from e179243164.adsl.alicedsl.de ([85.179.243.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 15:00:48 +0000
Received: from frederik.hohlfeld by e179243164.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 15:00:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 85.179.243.164 (Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9) Gecko/2008061015 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85868>

Hi

I have init'ed a git repository with git svn init.

Now I'm using git svn fetch, but it stops after just a few files/revisions. The
exit status is 141.

What does this 141 want to tell me?

Thanks
Frederik Hohlfeld
