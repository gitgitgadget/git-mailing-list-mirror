X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 17:33:41 +0100
Message-ID: <20061117163341.GQ4842@pasky.or.cz>
References: <20061116221701.4499.qmail@science.horizon.com> <20061117153246.GA20065@thunk.org> <BAYC1-PASMTP07C8A8D8E5E78173953CA9AEE80@CEZ.ICE> <fcaeb9bf0611170819j57cda9e1ia4ecd4cd13956447@mail.gmail.com> <455DE275.8020000@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 16:35:14 +0000 (UTC)
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <455DE275.8020000@gmx.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31705>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl6ex-0002NS-5Q for gcvg-git@gmane.org; Fri, 17 Nov
 2006 17:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932941AbWKQQdo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 11:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933715AbWKQQdn
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 11:33:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:15014 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S932941AbWKQQdn (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 11:33:43 -0500
Received: (qmail 12923 invoked by uid 2001); 17 Nov 2006 17:33:41 +0100
To: Marko Macek <marko.macek@gmx.net>
Sender: git-owner@vger.kernel.org

On Fri, Nov 17, 2006 at 05:25:25PM CET, Marko Macek wrote:
> Nguyen Thai Ngoc Duy wrote:
> >On 11/17/06, Sean <seanlkml@sympatico.ca> wrote:
> >>It would be nice to post this information on the Git website and not
> >>have it overshadowed by Cogito examples with paragraphs explaining how
> >>Cogito makes things easier.  The current website distracts users away
> >>from learning Git or ever reading about this kind of information.
> >>Maybe we can pass a hat around for some funds for a separate Cogito
> >>website. ;o)
> >
> >Or.. find a way to merge cogito back to git :-)
> >/me runs into a nearest bush.

I think we are trying to figure that out in the last few days in those
mammoth threads. UI-wise with no big breakthroughs so far I guess,
though.

> The alternative would be to explain that git is a low level tool suitable 
> mostly for integrators like Linus (that, and that Cogito and/or StGit 
> should be used by developers/contributors).

This is in essence what many people (including Junio) are saying. I'm
not saying it's a totally great situation, hence the previous paragraph.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
