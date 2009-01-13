From: Vladimir Pouzanov <farcaller@gmail.com>
Subject: Re: git-svn fails to fetch repository
Date: Tue, 13 Jan 2009 21:34:38 +0000 (UTC)
Message-ID: <loom.20090113T213400-985@post.gmane.org>
References: <loom.20090113T145019-951@post.gmane.org>  <loom.20090113T150220-345@post.gmane.org>  <496CD49D.1070201@drmicha.warpmail.net>  <loom.20090113T185918-397@post.gmane.org>  <20090113203922.GD30404@atjola.homenet>  <loom.20090113T204616-845@post.gmane.org>  <76718490901131312j28f8283bi94f55000e70c532e@mail.gmail.com>  <loom.20090113T211437-12@post.gmane.org> <76718490901131328x5ec30805u3cae29132defd695@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 22:36:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMqvs-0006AC-Hp
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 22:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbZAMVe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 16:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622AbZAMVe4
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 16:34:56 -0500
Received: from main.gmane.org ([80.91.229.2]:36048 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbZAMVe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 16:34:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LMquS-00005R-Ji
	for git@vger.kernel.org; Tue, 13 Jan 2009 21:34:52 +0000
Received: from 122-249-112-92.pool.ukrtel.net ([122-249-112-92.pool.ukrtel.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 21:34:52 +0000
Received: from farcaller by 122-249-112-92.pool.ukrtel.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 21:34:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.112.249.122 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105539>

Jay Soffian <jaysoffian <at> gmail.com> writes:
> Perhaps this will help in tracking down the problem.

$ git svn clone http://qsb-mac.googlecode.com/svn/trunk qsb-mac
Initialized empty Git repository in /Users/farcaller/temp/qsb-mac/.git/
r1 = 810fe584c48b884460b5403a28bc61d872452b93 (git-svn)
Temp file with moniker 'svn_delta' already in use at /opt/local/lib/perl5/
site_perl/5.8.8/Git.pm line 1011.
