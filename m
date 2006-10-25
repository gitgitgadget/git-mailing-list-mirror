X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-fetch not working?
Date: Wed, 25 Oct 2006 13:11:50 +0200
Message-ID: <20061025111150.GK20017@pasky.or.cz>
References: <200610242100.52671.andyparkins@gmail.com> <20061024205428.GI20017@pasky.or.cz> <453E8133.8020707@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 11:12:06 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	ftpadmin@kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <453E8133.8020707@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30050>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcgfs-00063R-KZ for gcvg-git@gmane.org; Wed, 25 Oct
 2006 13:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423274AbWJYLLx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 07:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423272AbWJYLLx
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 07:11:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65254 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1423270AbWJYLLw (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 07:11:52 -0400
Received: (qmail 21240 invoked by uid 2001); 25 Oct 2006 13:11:50 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org

Dear diary, on Tue, Oct 24, 2006 at 11:10:11PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> said that...
> Petr Baudis wrote:
> >  nope, I'm getting it as well (hey I know about broken git.kernel.org
> >in an hour at most now because of the repo.or.cz cronjobs ;) -
> >git-daemon at the kernel.org machines seems to be broken.
> >
> 
> Nope, just tripping the load limit.  git1.kernel.org has had loads over 
> 400 today.  Oddly enough, the load on git2.kernel.org is in the low teens.

Hmm, interesting. Just to make sure, is that because of git-daemon or
something else? :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
