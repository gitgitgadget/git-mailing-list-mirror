From: David Greaves <david@dgreaves.com>
Subject: Re: gitweb wishlist
Date: Wed, 25 May 2005 11:54:25 +0100
Message-ID: <42945961.8060708@dgreaves.com>
References: <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org> <20050524202846.GC25606@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org> <20050524213102.GB19180@vrfy.org> <7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net> <20050525094841.GA24172@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 12:53:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DatVR-0000bo-2z
	for gcvg-git@gmane.org; Wed, 25 May 2005 12:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVEYKyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 06:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVEYKyf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 06:54:35 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:18365 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262144AbVEYKy2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 06:54:28 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 86895E6DA5; Wed, 25 May 2005 11:53:24 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 06637-12; Wed, 25 May 2005 11:53:24 +0100 (BST)
Received: from oak.dgreaves.com (modem-4032.leopard.dialup.pol.co.uk [217.135.159.192])
	by mail.ukfsn.org (Postfix) with ESMTP
	id D02DCE6DB0; Wed, 25 May 2005 11:53:23 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DatWx-0006CK-41; Wed, 25 May 2005 11:54:31 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050525094841.GA24172@vrfy.org>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


>>On probably a bit different topic (but I do not know who is
>>updating the copy on www.kernel.org, sorry).  Could somebody
>>update http://www.kernel.org/pub/software/scm/git/docs/ to
>>rename git-diff-tree-helper to git-diff-helper please?
>>git.git/Documentation/git.txt has been corrected quite some
>>time ago [*1*] and I do not know how the updates are propagated
>>to the web version of the documentation; is it a manual process?
>>    
>>
>
>David Greaves can write to that directory. David?
>  
>
Yep.
It is a manual rsync process.

I last ran it on the 22nd as soon as Linus committed my latest doc patches.

It's my bad though - I didn't update index.html which should be a copy
of git.html

 http://www.kernel.org/pub/software/scm/git/docs/git.html
is correct.

Anyway, done now, give it time to replicate.

David


