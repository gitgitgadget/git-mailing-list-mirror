X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 15:22:51 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612141519380.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
 <200612141136.59041.andyparkins@gmail.com> <20061214114546.GI1747@spearce.org>
 <8764ce6654.wl%cworth@cworth.org> <20061214120518.GL1747@spearce.org>
 <Pine.LNX.4.64.0612141251520.18171@xanadu.home>
 <7vy7pa45m8.fsf@assigned-by-dhcp.cox.net> <20061214200245.GP1747@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 14 Dec 2006 20:22:57 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061214200245.GP1747@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34392>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gux6V-0001R5-6B for gcvg-git@gmane.org; Thu, 14 Dec
 2006 21:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932621AbWLNUWx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 15:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWLNUWw
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 15:22:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55039 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932759AbWLNUWw (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 15:22:52 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAA008P15Y3UHS0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 15:22:51 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Shawn Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
> > That changes what the command does to existing repositories,
> > which is somewhat impolite.
> 
> Yes, but users are forgetting to enable them.  They will work in
> a new repository having that feature, move to an older one and not
> have it, but expect it to be there.

I concur entirely.

> > I am not opposed too much to an updated version of the tool that
> > sets the configuration on by default for newly created
> > repositories, though.
> 
> I almost did that in my patch - but decided against it for the
> reason I just noted above.
> 
> Does anyone on the mailing list really have an objection to having
> reflogs on by default?

I certainly don't.


