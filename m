X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Marko Macek <marko.macek@gmx.net>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 17:25:25 +0100
Message-ID: <455DE275.8020000@gmx.net>
References: <20061116221701.4499.qmail@science.horizon.com>	 <20061117153246.GA20065@thunk.org>	 <BAYC1-PASMTP07C8A8D8E5E78173953CA9AEE80@CEZ.ICE> <fcaeb9bf0611170819j57cda9e1ia4ecd4cd13956447@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 16:29:50 +0000 (UTC)
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #420190
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <fcaeb9bf0611170819j57cda9e1ia4ecd4cd13956447@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31704>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl6aO-0001Bf-7z for gcvg-git@gmane.org; Fri, 17 Nov
 2006 17:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933710AbWKQQ2s (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 11:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933709AbWKQQ2r
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 11:28:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:25257 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S933708AbWKQQ2q (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 11:28:46 -0500
Received: (qmail invoked by alias); 17 Nov 2006 16:28:45 -0000
Received: from BSN-77-114-200.dial-up.dsl.siol.net (EHLO [192.168.2.7])
 [193.77.114.200] by mail.gmx.net (mp037) with SMTP; 17 Nov 2006 17:28:45
 +0100
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

Nguyen Thai Ngoc Duy wrote:
> On 11/17/06, Sean <seanlkml@sympatico.ca> wrote:
>> It would be nice to post this information on the Git website and not
>> have it overshadowed by Cogito examples with paragraphs explaining how
>> Cogito makes things easier.  The current website distracts users away
>> from learning Git or ever reading about this kind of information.
>> Maybe we can pass a hat around for some funds for a separate Cogito
>> website. ;o)
> 
> Or.. find a way to merge cogito back to git :-)
> /me runs into a nearest bush.

I agree, this would certainly be the best solution. But it would imply
hiding the 'index' by default which would probably an incompatible change.

The alternative would be to explain that git is a low level tool suitable 
mostly for integrators like Linus (that, and that Cogito and/or StGit should 
be used by developers/contributors).

