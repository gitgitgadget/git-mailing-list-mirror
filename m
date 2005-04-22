From: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Subject: Re: Pulling linux-2.6.git with gitinit.sh and gitpull.sh fails
Date: Sat, 23 Apr 2005 00:24:32 +0100
Message-ID: <426987B0.8020707@rhyshardwick.co.uk>
References: <200504221442.29488.rhys@rhyshardwick.co.uk> <200504221554.04749.rhys@rhyshardwick.co.uk> <1114183357.29271.31.camel@nosferatu.lan> <200504221624.27769.rhys@rhyshardwick.co.uk> <20050422224358.GF21204@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 23 01:21:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP7Sf-0005eL-Gn
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 01:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVDVXZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 19:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVDVXZ7
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 19:25:59 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:54104 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261304AbVDVXZy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 19:25:54 -0400
Received: from unknown (HELO mail.rhyshardwick.co.uk) (rhys?hardwick@81.103.65.153 with plain)
  by smtp004.mail.ukl.yahoo.com with SMTP; 22 Apr 2005 23:25:50 -0000
Received: from [192.168.1.55] (helo=[192.168.1.55])
	by mail.rhyshardwick.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1DP7Wv-000558-Mh
	for git@vger.kernel.org; Sat, 23 Apr 2005 00:25:49 +0100
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20050422224358.GF21204@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Fri, Apr 22, 2005 at 05:24:27PM CEST, I got a letter
> where Rhys Hardwick <rhys@rhyshardwick.co.uk> told me that...
> 
>>>Seems your /bin/sh do not support 'echo -e' ... Know what provides
>>>your /bin/sh (I think ash at least do support it)?
>>>
>>>Petr, I think you should really start to consider going full bash?
>>
>>I use dash...
> 
> 
> FYI, I've succumbed to the real world out there and switched the whole
> thing to use bash.
> 

Thanks for that Petr.  I am wondering, what do you and the other 
developers use?  When I apt-get install ash (debian unstable), which I 
tried to do to fix this problem, all it did was add a symlink to dash!!


