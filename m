From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] Docs update
Date: Thu, 21 Apr 2005 22:16:11 +0100
Message-ID: <4268181B.6050906@dgreaves.com>
References: <42680FCC.6030901@dgreaves.com> <20050421204348.GJ7443@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 23:13:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOixf-0005Xg-6I
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 23:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVDUVQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 17:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVDUVQP
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 17:16:15 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:20119 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261883AbVDUVQN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 17:16:13 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 198C2E6D99; Thu, 21 Apr 2005 22:14:21 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07132-03; Thu, 21 Apr 2005 22:14:21 +0100 (BST)
Received: from oak.dgreaves.com (modem-2040.lynx.dialup.pol.co.uk [217.135.199.248])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 6E842E6D94; Thu, 21 Apr 2005 22:14:20 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DOj1v-0002h1-MS; Thu, 21 Apr 2005 22:16:11 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050421204348.GJ7443@pasky.ji.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> 
> Make a choice - either you are describing git or Cogito. The frmer has
> no RSYNC_FLAGS and does not care about any heads or anything at all (you
> might mention it as a recommended convention, though).

I was going to do both - surely that's OK?

The only reason it's core so far is that I started working my way 
through the code alphabetically (having no other clue where to start!)

As it turns out it will probably make sense to do all the core first - 
but I don't want to miss things so as I read through all the mails and 
extract content, I make a note of things like environment variables 
which I'll bulk up and cross reference later.

I may even change my mind and make notes on Cogito if that takes my 
fancy too ;)

I know it's not polished yet - but I'd rather publish it and have people 
catch mistakes.

David



