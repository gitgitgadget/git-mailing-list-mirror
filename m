X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Some tips for doing a CVS importer
Date: Tue, 21 Nov 2006 21:03:41 +0100
Message-ID: <20061121200341.GH7201@pasky.or.cz>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com> <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com> <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com> <87vel9y5x6.wl%cworth@cworth.org> <9e4733910611201740i348302e6r84c3c27dc27e5954@mail.gmail.com> <20061121063934.GA3332@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 20:04:10 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>, Carl Worth <cworth@cworth.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061121063934.GA3332@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32032>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmbqP-0005ss-7n for gcvg-git@gmane.org; Tue, 21 Nov
 2006 21:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031351AbWKUUDo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 15:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031373AbWKUUDo
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 15:03:44 -0500
Received: from w241.dkm.cz ([62.24.88.241]:58830 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1031351AbWKUUDn (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 15:03:43 -0500
Received: (qmail 10853 invoked by uid 2001); 21 Nov 2006 21:03:41 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Tue, Nov 21, 2006 at 07:39:35AM CET, Shawn Pearce wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > brendan said SVN is likely for the main Mozilla repo and monotone for
> > the new Mozilla 2 work. No native win32 caused git to be immediately
> > discarded.
> 
> Yea, that lack of native win32 seems to be one of a number of
> blockers for people switching their projects onto Git.

Yep. :-(

> I think there's a number of issues that are keeping people from
> switching to Git and are instead causing them to choose SVN, hg
> or Monotone:
> 
>   - No GUI.

It has been my impression that Git's situation is far better than in
case of the other systems (except SVN: TortoiseSVN and RapidSVN). Is
that not so?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
