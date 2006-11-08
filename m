X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's in git.git
Date: Wed, 8 Nov 2006 15:51:57 +0100
Message-ID: <20061108145157.GU20017@pasky.or.cz>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 14:52:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31140>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghomc-0005uY-HC for gcvg-git@gmane.org; Wed, 08 Nov
 2006 15:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965899AbWKHOwA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 09:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965900AbWKHOwA
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 09:52:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:43171 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S965899AbWKHOv7 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 09:51:59 -0500
Received: (qmail 7193 invoked by uid 2001); 8 Nov 2006 15:51:57 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

>   By the way, do people mind if I start to rewind and rebase
>   'next' after every feature release (i.e. tagged release is
>   made after 'master')?  I do not feel a strong need for it, and
>   'git log --no-merges master..next' will show emptiness
>   eventually, but being able to restart from clean slate after a
>   release would be somewhat nice.

  It would be annoying for me since I can't mantain a long-term private
branch tracking next then (and I prefer next to master). I don't do that
right now but I've done that shortly in the past and it would be nice to
have that possibility in the future as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
