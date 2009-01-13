From: Vladimir Pouzanov <farcaller@gmail.com>
Subject: Re: git-svn fails to fetch repository
Date: Tue, 13 Jan 2009 19:01:28 +0000 (UTC)
Message-ID: <loom.20090113T185918-397@post.gmane.org>
References: <loom.20090113T145019-951@post.gmane.org> <loom.20090113T150220-345@post.gmane.org> <496CD49D.1070201@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 20:03:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMoXg-0000ru-HO
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 20:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbZAMTBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 14:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbZAMTBs
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 14:01:48 -0500
Received: from main.gmane.org ([80.91.229.2]:33187 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbZAMTBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 14:01:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LMoWE-0001Cf-GV
	for git@vger.kernel.org; Tue, 13 Jan 2009 19:01:42 +0000
Received: from 4-243-112-92.pool.ukrtel.net ([4-243-112-92.pool.ukrtel.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 19:01:42 +0000
Received: from farcaller by 4-243-112-92.pool.ukrtel.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 19:01:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.112.243.4 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105519>

Michael J Gruber <git <at> drmicha.warpmail.net> writes:
> This is with git 1.6.1rc4 (yeah I should have updated), perl 5.8.8 and
> svn 1.4.6 on Linux. Same with git 1.6.0.6, perl 5.10.0 and svn 1.5.4 on
> another box. The one git-svn change between 1.6.0.4 and 1.6.0.6 should
> not matter because you don't have branches. What's your svn version?

svn, version 1.5.5 (r34862) on OSX (where perl fails with error) and
svn, version 1.5.0 (Release Candidate 
5) on Linux
(where perl segfaults somewhere in apr).
