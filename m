From: Mike Taht <mike.taht@timesys.com>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 11:35:44 -0700
Message-ID: <42615B00.6090106@timesys.com>
References: <20050416131528.GB19908@elte.hu>	<Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org> <7vmzry7ev5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 20:32:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMs5W-0002u1-AU
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 20:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVDPSfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 14:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVDPSfv
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 14:35:51 -0400
Received: from mail.timesys.com ([65.117.135.102]:18958 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262722AbVDPSfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 14:35:47 -0400
Received: from [10.129.129.212] ([67.180.132.225]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 16 Apr 2005 14:31:10 -0400
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzry7ev5.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 16 Apr 2005 18:31:11.0046 (UTC) FILETIME=[768C8660:01C542B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


>  * A script git-archive-tar is used to create a "base tarball"
>    that roughly corresponds to "linux-*.tar.gz".  This works as
>    follows:
> 
>     $ git-archive-tar C [B1 B2...]
> 
>    This reads the named commit C, grabs the associated tree
>    (i.e.  its sub-tree objects and the blob they refer to), and
>    makes a tarball of ??/??????????????????????????????????????
>    files.  The tarball does not have to contain any extra
>    information to reproduce any ancestor of the named commit.

alternatively, "git-archive-torrent" to create a list of files for a 
bittorrent feed....

-- 

Mike Taht
