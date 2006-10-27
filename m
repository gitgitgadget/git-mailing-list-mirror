X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH (amend)] gitweb: Slight visual improvements to commitdiff view
Date: Fri, 27 Oct 2006 03:47:40 +0200
Message-ID: <20061027014740.GV20017@pasky.or.cz>
References: <200610270150.40100.jnareb@gmail.com> <780488.44315.qm@web31803.mail.mud.yahoo.com> <7vu01qilg1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 01:50:52 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	ltuikov@yahoo.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vu01qilg1.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30271>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdGoy-0001rk-Mt for gcvg-git@gmane.org; Fri, 27 Oct
 2006 03:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946100AbWJ0Brm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 21:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946101AbWJ0Brm
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 21:47:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44423 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1946100AbWJ0Brl (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 21:47:41 -0400
Received: (qmail 7914 invoked by uid 2001); 27 Oct 2006 03:47:40 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Dear diary, on Fri, Oct 27, 2006 at 03:42:06AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > --- Jakub Narebski <jnareb@gmail.com> wrote:
> > ...
> >> Those changes might wait for proper refactoring of gitweb CSS (having 
> >> for example 8px padding in one place only).
> >
> > Excellent!  I'd like this explanation to be part of the
> > commit message if that patchset is committed to git.git.
> 
> I'd like that kind of explanation with the patch in a single
> message when it is ready to be applied, too.
> 
> I'll leave it up to you guys to decide if CSS refactoring should
> go in first (I personally feel it probably is the case, in which
> case this patch would need to be rebased I suspect).

We don't have any such patch, do we? So let anyone doing that patch take
this one into account and merge in whatever we have, I'd say.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
