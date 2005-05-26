From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Summary of core GIT while you are away.
Date: Thu, 26 May 2005 15:11:05 -0700
Message-ID: <42964979.2030806@zytor.com>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org> <20050526004411.GA12360@vrfy.org> <Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org> <20050526202712.GA6024@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 00:12:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbQZb-0007ES-6x
	for gcvg-git@gmane.org; Fri, 27 May 2005 00:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVEZWNO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 18:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVEZWNO
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 18:13:14 -0400
Received: from terminus.zytor.com ([209.128.68.124]:29649 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261828AbVEZWNG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 18:13:06 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4QMBBqw002280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 May 2005 15:11:11 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050526202712.GA6024@vrfy.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Kay Sievers wrote:
> 
> Nice, thanks. Here is a very first try. It searches the commit messages
> and uses pickaxe to search in the file content:
>   http://ehlo.org/~kay/gitweb.cgi?p=git/git.git;a=search;s=symlink
> 
> Before someone asks: kernel.org needs to wait until cogito has catched up and
> released a new version and it is installed on the machines.
> 

Petr, it seems we need a new Cogito release soon.  0.10 really has 
fallen behind a lot.  Also, separating out Cogito from git-core would be 
nice.

	-hpa
