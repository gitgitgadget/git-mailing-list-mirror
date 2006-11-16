X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 04:07:28 +0100
Message-ID: <20061116030728.GQ7201@pasky.or.cz>
References: <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <Pine.LNX.4.64.0611151315291.2591@xanadu.home> <20061115184914.GA24122@spearce.org> <455B64F7.9040506@gmx.net> <20061115172834.0a328154.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 03:07:41 +0000 (UTC)
Cc: Marko Macek <marko.macek@gmx.net>,
	Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	cworth@cworth.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061115172834.0a328154.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31548>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkXbB-0008IP-CL for gcvg-git@gmane.org; Thu, 16 Nov
 2006 04:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030942AbWKPDHb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 22:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031039AbWKPDHb
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 22:07:31 -0500
Received: from w241.dkm.cz ([62.24.88.241]:48588 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1030942AbWKPDHa (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 22:07:30 -0500
Received: (qmail 8355 invoked by uid 2001); 16 Nov 2006 04:07:28 +0100
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 11:28:34PM CET, Sean wrote:
> Git is confusing enough for new users without "Git" and "Cogito"
> being mixed without comment on the Git webpage.  At the very
> least, the links should be changed to "Cogito for CVS/SVN users".

It's not being mixed without comment, in the very first paragraph I'm
trying to explain what the difference is and why is Cogito used for
introduction to Git. I've tried to clear it up even more now.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
