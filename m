X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 21:12:27 +0100
Message-ID: <20061115201227.GM7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 20:12:51 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31480>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkR7Z-0004nu-Qt for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030951AbWKOUMa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030953AbWKOUMa
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:12:30 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60817 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1030951AbWKOUM3 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:12:29 -0500
Received: (qmail 5167 invoked by uid 2001); 15 Nov 2006 21:12:27 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 03:10:16AM CET, Junio C Hamano wrote:
> You have to admit both pull and fetch have been contaminated
> with loaded meanings from different backgrounds. I was talking
> about killing the source of confusion in the longer term by
> removing fetch/pull/push, so we are still on the same page.

How was/is fetch contaminated?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
