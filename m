X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 15:26:44 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611151524000.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home>
 <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home>
 <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <20061115201227.GM7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 20:27:04 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061115201227.GM7201@pasky.or.cz>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31485>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRLO-0007nH-NT for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030974AbWKOU0q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030952AbWKOU0q
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:26:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20267 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030973AbWKOU0p
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:26:45 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8S00K43GSKGFE0@VL-MO-MR001.ip.videotron.ca> for git@vger.kernel.org; Wed,
 15 Nov 2006 15:26:44 -0500 (EST)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006, Petr Baudis wrote:

> On Wed, Nov 15, 2006 at 03:10:16AM CET, Junio C Hamano wrote:
> > You have to admit both pull and fetch have been contaminated
> > with loaded meanings from different backgrounds. I was talking
> > about killing the source of confusion in the longer term by
> > removing fetch/pull/push, so we are still on the same page.
> 
> How was/is fetch contaminated?

I think "fetch" is sane.  Its only problem is a missing symetrical 
counterpart verb, like "get" and "put".


