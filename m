From: Vladimir Pouzanov <farcaller@gmail.com>
Subject: Re: git-svn fails to fetch repository
Date: Tue, 13 Jan 2009 15:03:59 +0000 (UTC)
Message-ID: <loom.20090113T150220-345@post.gmane.org>
References: <loom.20090113T145019-951@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 16:06:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMkq7-0003fB-7z
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 16:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbZAMPEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 10:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbZAMPEJ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 10:04:09 -0500
Received: from main.gmane.org ([80.91.229.2]:37889 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbZAMPEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 10:04:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LMkoJ-00082n-3s
	for git@vger.kernel.org; Tue, 13 Jan 2009 15:04:07 +0000
Received: from 4-243-112-92.pool.ukrtel.net ([4-243-112-92.pool.ukrtel.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 15:04:07 +0000
Received: from farcaller by 4-243-112-92.pool.ukrtel.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 15:04:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.112.243.4 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105499>

Also just tried on linux box (git 1.6.0.4, perl 5.8.8). Got all the revisions
but git segfaulted at the end:
...
r21 = e839272549fd746cf45542a7aa6cb151ae3813da (trunk)
Checked out HEAD:
  http://qsb-mac.googlecode.com/svn/trunk r21
Segmentation fault
