X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Put back shortlog instead of graphiclog in the project list.
Date: Wed, 15 Nov 2006 22:34:33 +0100
Message-ID: <20061115213433.GV18879@pasky.or.cz>
References: <87irhgla3l.fsf@wine.dyndns.org> <7vac2sl9jj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 21:35:12 +0000 (UTC)
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vac2sl9jj.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31504>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkSP2-0005hT-8s for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161734AbWKOVeg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161735AbWKOVeg
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:34:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9702 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1161734AbWKOVef (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 16:34:35 -0500
Received: (qmail 12693 invoked by uid 2001); 15 Nov 2006 22:34:33 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 09:49:52PM CET, Junio C Hamano wrote:
> Alexandre Julliard <julliard@winehq.org> writes:
> 
> > Looks like a repo.or.cz-specific change slipped in.
> >
> > Signed-off-by: Alexandre Julliard <julliard@winehq.org>
> 
> Sorry and thanks.

Sorry from me too. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
