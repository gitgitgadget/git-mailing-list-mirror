X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Show project's README.html if available
Date: Tue, 24 Oct 2006 21:50:35 +0200
Message-ID: <20061024195035.GH20017@pasky.or.cz>
References: <20061024191915.GV18879@pasky.or.cz> <701637.67420.qm@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 24 Oct 2006 19:50:46 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <701637.67420.qm@web31802.mail.mud.yahoo.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30006>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcSIK-0000GP-Ss for gcvg-git@gmane.org; Tue, 24 Oct
 2006 21:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161114AbWJXTuh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 15:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWJXTuh
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 15:50:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38797 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1161114AbWJXTuh (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 15:50:37 -0400
Received: (qmail 6324 invoked by uid 2001); 24 Oct 2006 21:50:35 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

Dear diary, on Tue, Oct 24, 2006 at 09:41:04PM CEST, I got a letter
where Luben Tuikov <ltuikov@yahoo.com> said that...
> I re-read that email.  And I also saw what you have at hed.git.
> 
> If anything I think we should want to _minimize_ shown material
> before the "shortlog" in the "summary" page.
> 
> Why?
> 
> Well, in a production environment, people often view the "summary" page
> to see what has been going on with a project and they are well aware
> of what that project is for and/or what it does.  It is cumbersome to have
> to scroll down each and every time past he annoying "readme", just to see
> the first few commits.

Yes, I agree that this is valid concern. I've been thinking about
showing readme in parallel with the summary box, do people think that
would fix the issue?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
