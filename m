X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 17:53:33 +0100
Message-ID: <20061117165333.GR4842@pasky.or.cz>
References: <20061116221701.4499.qmail@science.horizon.com> <20061117153246.GA20065@thunk.org> <BAYC1-PASMTP07C8A8D8E5E78173953CA9AEE80@CEZ.ICE> <fcaeb9bf0611170819j57cda9e1ia4ecd4cd13956447@mail.gmail.com> <20061117113404.810fd4ea.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 16:54:15 +0000 (UTC)
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061117113404.810fd4ea.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31711>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl6yC-00070A-35 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 17:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755737AbWKQQxg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 11:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755740AbWKQQxg
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 11:53:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:64187 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1755736AbWKQQxg (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 11:53:36 -0500
Received: (qmail 15766 invoked by uid 2001); 17 Nov 2006 17:53:33 +0100
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On Fri, Nov 17, 2006 at 05:34:04PM CET, Sean wrote:
> It's just that the separate Cogito tool shouldn't have a place on the
> Git website any more prominent than say StGit does.

It doesn't - look at the "Maintaining external patches" crash course.

Porcelains are integral part of the Git environment. I think several
people have already tried to explain it before.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
