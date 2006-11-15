X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 21:39:11 +0100
Message-ID: <20061115203911.GO7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz> <87d57pu4qa.wl%cworth@cworth.org> <7v3b8lv9c9.fsf@assigned-by-dhcp.cox.net> <20061115040852.GL7201@pasky.or.cz> <7vd57ps51c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 20:39:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vd57ps51c.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31489>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRXS-0002Ln-1F for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030760AbWKOUjP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030988AbWKOUjO
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:39:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:40903 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1030760AbWKOUjN (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:39:13 -0500
Received: (qmail 7230 invoked by uid 2001); 15 Nov 2006 21:39:11 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 05:33:03AM CET, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> >   (v) Git would be properly libified by now. If you wanted to convert
> > bits of porcelain to C, it would be at least much higher priority.
> 
> I am not sure about "libified" part and I do not know what bits
> of porcelain wants to become C right now.  But I do not think
> this point is important part of your list.

Merge strategies. Or wait, is that already plumbing?

Or git-status. git-add. Plenty more.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
