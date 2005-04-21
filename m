From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] Add help details to git help command. (This time with
 Perl)
Date: Thu, 21 Apr 2005 10:29:40 +0100
Message-ID: <42677284.1010005@dgreaves.com>
References: <200504172242.26326.elenstev@mesatop.com> <20050418102412.GJ1461@pasky.ji.cz> <42654153.8080307@mesatop.com> <20050419175051.GK12757@pasky.ji.cz> <42655630.80207@dgreaves.com> <20050420233453.GC12962@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Cole <elenstev@mesatop.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 11:26:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOXwB-0006tQ-8T
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 11:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVDUJ3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 05:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVDUJ3u
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 05:29:50 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:29574 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261221AbVDUJ3n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 05:29:43 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 12E51E6D6D; Thu, 21 Apr 2005 10:27:53 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 28083-20; Thu, 21 Apr 2005 10:27:52 +0100 (BST)
Received: from oak.dgreaves.com (modem-992.lion.dialup.pol.co.uk [217.135.163.224])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 5AC5AE6D53; Thu, 21 Apr 2005 10:27:52 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DOY0C-0001rI-NO; Thu, 21 Apr 2005 10:29:40 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050420233453.GC12962@pasky.ji.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> We've decided to go for the individual scripts directly. :-)
Just to clarify - individual scripts or $0 name handling?

I kinda like one big script - also means we don't need to 'install' it 
to get access to Cogito.pm...

> 
> Unfortunately, you didn't send the attachments inline, so I can't
> comment on them sensibly.

I'm not sure what you want here; last time you said:
> Thanks. Could you please send the patches signed off and either with
> content-disposition: inline or in the mail body?

So I dug around Thunderbird's config and, this time, from my email on 
the git list:
--------------050206040606040908050407
Content-Type: application/x-perl;
  name="gitadd.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
  filename="gitadd.pl"


> Perhaps my main problem is now style. I'd prefer you do format it alike
> the C sources of git, with 8-chars indentation and such. Also make sure
> you use spaces around (or after) operators. Also, for just few short
> functions I prefer putting the functions before the code itself.
will do


David
