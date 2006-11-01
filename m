X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] make git-push a bit more verbose
Date: Wed, 1 Nov 2006 01:08:40 +0100
Message-ID: <20061101000840.GE20017@pasky.or.cz>
References: <Pine.LNX.4.64.0610311648220.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 00:08:55 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610311648220.11384@xanadu.home>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30609>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf3ew-0006yp-J6 for gcvg-git@gmane.org; Wed, 01 Nov
 2006 01:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946203AbWKAAIn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 19:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946205AbWKAAIn
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 19:08:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:42680 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1946203AbWKAAIm (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 19:08:42 -0500
Received: (qmail 19942 invoked by uid 2001); 1 Nov 2006 01:08:40 +0100
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Dear diary, on Tue, Oct 31, 2006 at 10:58:32PM CET, I got a letter
where Nicolas Pitre <nico@cam.org> said that...
> Currently git-push displays progress status for the local packing of 
> objects to send, but nothing once it starts to push it over the 
> connection.  Having progress status in that later case is especially 
> nice when pushing lots of objects over a slow network link.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>

Yet Another Undocumented Feature? :-(

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
