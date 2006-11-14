X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 20:47:07 +0100
Message-ID: <20061114194707.GH7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 19:47:25 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87hcx1u934.wl%cworth@cworth.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31366>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk4FW-0006em-Cu for gcvg-git@gmane.org; Tue, 14 Nov
 2006 20:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754811AbWKNTrK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 14:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754830AbWKNTrJ
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 14:47:09 -0500
Received: from w241.dkm.cz ([62.24.88.241]:64169 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1754811AbWKNTrI (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 14:47:08 -0500
Received: (qmail 13830 invoked by uid 2001); 14 Nov 2006 20:47:07 +0100
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On Tue, Nov 14, 2006 at 08:22:39PM CET, Carl Worth wrote:
> For reference, the latest potential batch of new users that I'm
> dealing with is the set of Fedora package maintainers who are looking
> at replacing CVS for their tree of package-building scripts. They are
> currently evaluating systems and liking the interface of hg. Here's
> the top of the current thread:
> 
> https://www.redhat.com/archives/fedora-maintainers/2006-November/msg00030.html
> 
> Here's the report about "git commit -a" confusion that led to my patch
> above:
> 
> https://www.redhat.com/archives/fedora-maintainers/2006-November/msg00141.html
> 
> And here's my reply where I suggest that git UI might still be
> improved in these areas:
> 
> https://www.redhat.com/archives/fedora-maintainers/2006-November/msg00149.html

Hmm, did they (not) consider Cogito? They wouldn't have those issues.
;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
