X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 21:27:07 +0200
Message-ID: <20061024192707.GG20017@pasky.or.cz>
References: <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net> <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net> <Pine.LNX.4.64.0610231534010.3962@g5.osdl.org> <20061024002622.GC17019@over-yonder.net> <Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz> <20061024163458.GH17019@over-yonder.net> <Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz> <ehllqj$bee$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 24 Oct 2006 19:27:34 +0000 (UTC)
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ehllqj$bee$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30004>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcRvd-0003Tx-6P for gcvg-git@gmane.org; Tue, 24 Oct
 2006 21:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752006AbWJXT1J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 15:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWJXT1J
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 15:27:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23959 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1752006AbWJXT1I (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 15:27:08 -0400
Received: (qmail 29927 invoked by uid 2001); 24 Oct 2006 21:27:07 +0200
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Dear diary, on Tue, Oct 24, 2006 at 08:25:53PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> David Lang wrote:
> 
> > 1. Centralized: all commits must go to one repository, connectivity
> > required to check-in 
> 
> Bazaar-NG "light checkouts" implements this. Git doesn't support this
> topology, and probably wouldn't.
> 
> 1.5. Disconnected centralized. Like centralized, but you can work (perhaps
> limited to what you can do) even without connection to central server.
> Minimally you have to be able to commit changes locally, if central server
> is not available. Bzr "normal/heavyweight checkouts" are [roughly] abot
> this. Git "lazy clone" proposal is about similar thing; you can get git to
> support this model (although without space savings) with full 
> clone + hooks.

Cogito can do it now out of the box, having support for cg-commit --push
and cg-update preserving uncommitted local changes.

Not that you probably should use it. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
