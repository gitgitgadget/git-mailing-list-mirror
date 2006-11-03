X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Introducing cg-xxdiff for conflict resolution
Date: Fri, 3 Nov 2006 01:11:35 +0100
Message-ID: <20061103001135.GN20017@pasky.or.cz>
References: <11546624471356-git-send-email-martin@catalyst.net.nz> <20060924165037.GS20017@pasky.or.cz> <46a038f90609241002i1db98ed6n118077089c9e417f@mail.gmail.com> <20060924171246.GY13132@pasky.or.cz> <46a038f90609241022i6ac11da1o1a1cba199595d036@mail.gmail.com> <20060924172838.GZ13132@pasky.or.cz> <46a038f90611021540s14b6098p477a68ef00c826e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 00:12:00 +0000 (UTC)
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <46a038f90611021540s14b6098p477a68ef00c826e9@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30767>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfmer-00025R-EB for gcvg-git@gmane.org; Fri, 03 Nov
 2006 01:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752851AbWKCALi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 19:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbWKCALi
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 19:11:38 -0500
Received: from w241.dkm.cz ([62.24.88.241]:16545 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1752851AbWKCALh (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 19:11:37 -0500
Received: (qmail 2127 invoked by uid 2001); 3 Nov 2006 01:11:35 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

Dear diary, on Fri, Nov 03, 2006 at 12:40:38AM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> On 9/25/06, Petr Baudis <pasky@suse.cz> wrote:
> >> >But I can adjust such details when applying your patch.
> >>
> >> Great! -- I'm travelling and at an airport "free access" computer. It
> >> should be illegal to run airports without free wifi in this day and
> >> age.
> >
> >Heartily agreed.
> 
> Paski, did this one get dropped? Change of heart? Heart attack?

Hmm, I thought we've agreed to go for the cg-resolve solution
instead...?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
