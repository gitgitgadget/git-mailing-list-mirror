From: David Greaves <david@dgreaves.com>
Subject: Re: [patch] add simple git documentation
Date: Sun, 08 May 2005 08:35:56 +0100
Message-ID: <427DC15C.3080208@dgreaves.com>
References: <20050505102600.GA16387@elf.ucw.cz> <20050506175835.65b9c9c1.akpm@osdl.org> <427C7E38.3010301@dgreaves.com> <20050507113618.GA9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 09:30:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUgDz-0006uA-Dc
	for gcvg-git@gmane.org; Sun, 08 May 2005 09:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVEHHgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 03:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVEHHgO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 03:36:14 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:2728 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262822AbVEHHgI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 03:36:08 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id C2A94E6A96; Sun,  8 May 2005 08:35:13 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14236-11; Sun,  8 May 2005 08:35:13 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.156.200])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 070C9E6A93; Sun,  8 May 2005 08:35:13 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DUgKS-0004zj-H9; Sun, 08 May 2005 08:35:56 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050507113618.GA9495@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>Dear diary, on Sat, May 07, 2005 at 10:37:12AM CEST, I got a letter
>where David Greaves <david@dgreaves.com> told me that...
>  
>
>>Andrew Morton wrote:
>>    
>>
>>>Pavel Machek <pavel@ucw.cz> wrote:
>>>      
>>>
>>>>This adds short intro to git aimed at kernel hackers.
>>>>        
>>>>
>>>OK, but I'm hoping that shortly we'll have something more complete than
>>>this, and your patch might not be a suitable starting point for that. 
>>>(Large hint-dropping sounds).
>>>      
>>>
>>What are you looking for.
>>
>>For man-page-a-like, have you seen Documentation/core-git.txt in Linus'
>>repository?
>>
>>I'll be working more on that this weekend.
>>    
>>
>Are you planning to split it to individual files at some point?
>  
>
Yes. I'll see how using asciidoc affects that.
And with Linus vacationing it looks like there'll be time this week.

>(That's what I'd like to do with Documentation/cogito/, speaking of
>manpageness...)
>  
>
OK
BTW, whatever happened to perlification - the initial stab I sent you
used the perl/pod approach.
The reason I ask is that that means the docs should/could be initially
written as here-documents within the scripts rather than external manpages.

David
