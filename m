From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] git-tar-tree: small doc update
Date: Fri, 27 May 2005 22:32:51 +0100
Message-ID: <42979203.7030703@dgreaves.com>
References: <20050527212032.GB17478@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 23:31:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbmPm-0001qb-U8
	for gcvg-git@gmane.org; Fri, 27 May 2005 23:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVE0Vcw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 17:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVE0Vcw
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 17:32:52 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:58531 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262603AbVE0Vcu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 17:32:50 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 5014EE6E1B; Fri, 27 May 2005 22:31:32 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 02313-06; Fri, 27 May 2005 22:31:32 +0100 (BST)
Received: from oak.dgreaves.com (modem-4010.lemur.dialup.pol.co.uk [217.135.143.170])
	by mail.ukfsn.org (Postfix) with ESMTP
	id B55CFE6E19; Fri, 27 May 2005 22:31:31 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DbmRr-0002FB-4A; Fri, 27 May 2005 22:32:55 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20050527212032.GB17478@lsrfire.ath.cx>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Rene Scharfe wrote:

>I'll take the blame for
>that contraption, if you don't mind.  ;) 
>
<snip>

>Author
> ------
>-Written by Linus Torvalds <torvalds@osdl.org>
>+Written by Rene Scharfe.
>  
>
Good - this was what I intended to have happen all along :)

Also Junio suggested a more general attribution - which I have now put
into eg git-mkdelta.txt

Git is written by Linus Torvalds <torvalds@osdl.org> and the git-list
<git@vger.kernel.org>.

I'll generalise the rest of the files at some point and respect any more
specific atributions.

David

-- 

