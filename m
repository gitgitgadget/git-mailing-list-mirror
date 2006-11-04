X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Initial push to git+ssh://repo.or.cz/srv/git/git/jnareb-git.git fails
Date: Sat, 4 Nov 2006 12:57:29 +0100
Message-ID: <20061104115729.GT20017@pasky.or.cz>
References: <200610291308.44653.jnareb@gmail.com> <20061104111340.GZ18879@pasky.or.cz> <200611041251.07790.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 11:58:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611041251.07790.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30921>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgK9v-0008Pp-3Z for gcvg-git@gmane.org; Sat, 04 Nov
 2006 12:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965330AbWKDL5d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 06:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965329AbWKDL5d
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 06:57:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:13796 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S965331AbWKDL5c (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 06:57:32 -0500
Received: (qmail 15284 invoked by uid 2001); 4 Nov 2006 12:57:29 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Dear diary, on Sat, Nov 04, 2006 at 12:51:07PM CET, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis "<pasky@ucw.cz>" wrote
> 
> > On Sun, Oct 29, 2006 at 01:08:44PM CET, Jakub Narebski wrote:
> 
> >> And here it hangs...
> > 
> > This is because the unpacking takes really looooooooong time. :-(
> 
> That was because git-push didn't have progress report on uploading and 
> unpacking.

No, that makes it more bearable but not shorter and less totally
pointless (since the next time we hit the repository we are going to
pack it back).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
