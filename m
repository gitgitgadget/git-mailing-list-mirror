From: David Greaves <david@dgreaves.com>
Subject: Re: [FILES] core-git documentation update
Date: Sun, 08 May 2005 18:42:04 +0100
Message-ID: <427E4F6C.6090302@dgreaves.com>
References: <427E4AED.9050702@dgreaves.com> <20050508173109.GZ9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 08 19:35:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUpgM-0008QL-SK
	for gcvg-git@gmane.org; Sun, 08 May 2005 19:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbVEHRmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 13:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbVEHRmO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 13:42:14 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:2955 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262911AbVEHRmL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 13:42:11 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 9B557E6D4F; Sun,  8 May 2005 18:41:13 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14332-06; Sun,  8 May 2005 18:41:13 +0100 (BST)
Received: from oak.dgreaves.com (modem-2142.leopard.dialup.pol.co.uk [217.135.152.94])
	by mail.ukfsn.org (Postfix) with ESMTP
	id EB764E6A8B; Sun,  8 May 2005 18:41:12 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DUpn3-0005kd-7f; Sun, 08 May 2005 18:42:05 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508173109.GZ9495@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>Dear diary, on Sun, May 08, 2005 at 07:22:53PM CEST, I got a letter
>where David Greaves <david@dgreaves.com> told me that...
>  
>
>>I've converted the core-git.txt to asciidoc format and created a trivial
>>splitter to create individual txt, html and man pages.
>>    
>>
>
>Is there any reason to keep the source in a single huge monolithic file?
>  
>
it just makes across the board changes easier and at the minute the
stuff I've been doing is systemic.

I have no problems with breaking it up - hence the script...

David

-- 

