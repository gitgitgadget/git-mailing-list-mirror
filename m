X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 22:31:26 +0100
Message-ID: <20061117213125.GG7201@pasky.or.cz>
References: <20061116221701.4499.qmail@science.horizon.com> <20061117153246.GA20065@thunk.org> <BAYC1-PASMTP07C8A8D8E5E78173953CA9AEE80@CEZ.ICE> <fcaeb9bf0611170819j57cda9e1ia4ecd4cd13956447@mail.gmail.com> <20061117113404.810fd4ea.seanlkml@sympatico.ca> <20061117165333.GR4842@pasky.or.cz> <20061117120154.3eaf5611.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 21:31:45 +0000 (UTC)
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061117120154.3eaf5611.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31733>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlBJ6-0002Dj-Og for gcvg-git@gmane.org; Fri, 17 Nov
 2006 22:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755941AbWKQVb3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 16:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755928AbWKQVb3
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 16:31:29 -0500
Received: from w241.dkm.cz ([62.24.88.241]:27368 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1755917AbWKQVb2 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 16:31:28 -0500
Received: (qmail 8891 invoked by uid 2001); 17 Nov 2006 22:31:26 +0100
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On Fri, Nov 17, 2006 at 06:01:54PM CET, Sean wrote:
> There is enough native Git documentation and hopefully more coming
> that third party tools should be pushed behind the scenes a bit.
> At least on the GIT website.

It's not about documentation but ease to use. I agree and sympathise
very much with the effort of making core Git more easy to use and
obsoleting Cogito, but until it gets there we should have what's nicest
to the users.

> Of course there is nothing wrong with having information there, but
> the main thrust should be about Git and how to use it directly without
> porcelains.  Especially in the light that people have recently
> expressed a desire to advocate and document the use of native Git
> more strongly.

If someone writes a crash course in pure Git covering the same grounds
as the current ones (possibly by just extending/retouching the tutorial)
(it does not necessarily need to be a "refugee" crash course, it can
build up from scratch), I can add it on the web. If it becomes as easy
to use and with as mild learning curve as Cogito, it means Cogito got
mostly obsolete and I'll happily remove the Cogito crash courses from
the web.

> Having a link to Cogito off the front page of the Git website that
> says... Cogito makes things "easier", no matter how much you
> personally believe it, isn't the way everyone feels and is at
> odds with the native-git message and improvement effort.

If you disagree about that fact, can you provide some specific
argumentation?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
