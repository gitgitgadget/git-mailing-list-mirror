From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 13:50:20 -0700
Message-ID: <428E4D8C.3020606@zytor.com>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>  <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org> <1116615600.12975.33.camel@dhcp-188> <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com> <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 20 22:51:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZERM-0004Wd-O3
	for gcvg-git@gmane.org; Fri, 20 May 2005 22:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVETUur (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 16:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVETUur
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 16:50:47 -0400
Received: from terminus.zytor.com ([209.128.68.124]:33453 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261583AbVETUum
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 16:50:42 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4KKoQhA015188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 May 2005 13:50:26 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=ham 
	version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> Oh, btw, I notice that you moved klibc over to git - care to share your
> cvs->git script (I assume you scripted it ;)? That would seem to be an 
> obvious addition to the core stuff..
> 

Actually, Kay did the conversion... the scripts are clearly very 
cantankerous, because if *I* run them -- I tried -- they don't work! 
Since it's Kay's work, I'll leave them to him, but I would definitely 
love to move more of my CVS repos over to git, especially syslinux.

	-hpa

