From: Vladimir Pouzanov <farcaller@gmail.com>
Subject: git-svn fails to fetch repository
Date: Tue, 13 Jan 2009 14:53:08 +0000 (UTC)
Message-ID: <loom.20090113T145019-951@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 15:56:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMkgr-0000RQ-Jd
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 15:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756465AbZAMOzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 09:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755378AbZAMOzE
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 09:55:04 -0500
Received: from main.gmane.org ([80.91.229.2]:53596 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836AbZAMOzD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 09:55:03 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LMkfW-0007gL-DX
	for git@vger.kernel.org; Tue, 13 Jan 2009 14:55:02 +0000
Received: from 4-243-112-92.pool.ukrtel.net ([4-243-112-92.pool.ukrtel.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 14:55:02 +0000
Received: from farcaller by 4-243-112-92.pool.ukrtel.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 14:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.112.243.4 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105498>

Hi all,

I'm trying to fetch svn repository:
git svn clone http://qsb-mac.googlecode.com/svn/trunk qsb-mac

This one fails at random time at:
Temp file with moniker ' at /opt/local/lib/perl5/site_perl/5.8.8/Git.pm
line 1011.

I know nothing about perl, so can't make anything out of that. Any hints?

Running Git 1.6.1, perl 5.8.8, OSX 10.5.6

PS: Please CC me on answer.
