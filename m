X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [git failure] failure pulling latest Linus tree
Date: Wed, 25 Oct 2006 18:13:23 +0200
Message-ID: <20061025161323.GF11916@pasky.or.cz>
References: <yq0d58g92u0.fsf@jaguar.mkp.net> <Pine.LNX.4.64.0610250746000.3962@g5.osdl.org> <453F8630.2000608@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 16:13:57 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Jes Sorensen <jes@sgi.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <453F8630.2000608@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30071>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GclNg-0005mO-Gn for gcvg-git@gmane.org; Wed, 25 Oct
 2006 18:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932272AbWJYQN0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 12:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWJYQN0
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 12:13:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53648 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S932272AbWJYQNZ (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 12:13:25 -0400
Received: (qmail 15430 invoked by uid 2001); 25 Oct 2006 18:13:23 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org

Dear diary, on Wed, Oct 25, 2006 at 05:43:44PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> said that...
> HOWEVER, git 1.4.3 seems to have been bad chicken.  When we ran it we 
> got a neverending stream of segfaults in the logs.

Could you provide some details, please? Ideally a backtrace or
something? Also, it might be a good idea to use 1.4.3.2 since it fixes a
problem with compatibility of git-daemon and older git clients.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
