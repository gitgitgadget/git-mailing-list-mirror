X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [Fwd: Re: What's in git.git]
Date: Sun, 19 Nov 2006 18:49:02 +0100
Message-ID: <20061119174902.GW7201@pasky.or.cz>
References: <20061119171135.GA13054@spearce.org> <9e4733910611190940y147992b8mbdfac5a51f42e0fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 17:49:33 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <9e4733910611190940y147992b8mbdfac5a51f42e0fe@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31843>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glqn0-0000z9-KS for gcvg-git@gmane.org; Sun, 19 Nov
 2006 18:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932164AbWKSRtH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 12:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWKSRtH
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 12:49:07 -0500
Received: from w241.dkm.cz ([62.24.88.241]:4752 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S932164AbWKSRtE (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 12:49:04 -0500
Received: (qmail 7988 invoked by uid 2001); 19 Nov 2006 18:49:02 +0100
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

On Sun, Nov 19, 2006 at 06:40:06PM CET, Jon Smirl wrote:
> Brendan told me that he would not consider Mozilla moving to git until
> a native Windows version is released so I just dropped the whole
> thing. It is too much effort and they don't even really want it. They
> are probably going to switch to SVN.  I told him that SVN would end up
> being a disaster and he got mad at me. That's when I stopped working
> on cvs2svn/git.

I see. :-(

Could you please publish cvs2git in whatever state you have it so that
someone else possibly interested could pick it up and finish the missing
bits? It would be shame if the already done work would end up wasted.

> #2) git needs native Windows support, this probably includes MSVC
> integration. There are a lot of non-technical people working on
> Mozilla like accessibility, doc, artwork, translations, they are all
> on Windows. Brendan explicitly ruled out cygwIn.

This is sort of catch-22, we have probably no developers interested
enough in porting Git to native Windows and it's not clear we are going
to get any until Git runs on native Windows.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
