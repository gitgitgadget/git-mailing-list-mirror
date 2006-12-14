X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Update git-diff documentation
Date: Thu, 14 Dec 2006 12:02:25 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612141157270.18171@xanadu.home>
References: <7vr6v2aofs.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612140957590.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 14 Dec 2006 17:02:40 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.63.0612140957590.3635@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34373>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GutyY-0004Zf-Qo for gcvg-git@gmane.org; Thu, 14 Dec
 2006 18:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750873AbWLNRC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 12:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWLNRC1
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 12:02:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15877 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750794AbWLNRC1 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 12:02:27 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA900KP9WO1XUE0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 12:02:26 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 14 Dec 2006, Junio C Hamano wrote:
> 
> > -Show changes between two trees, a tree and the working tree, a
> > -tree and the index file, or the index file and the working tree.
> > -The combination of what is compared with what is determined by
> > -the number of trees given to the command.
> > +This command shows changes between four combinations of states.
> 
> I think the old explanation, while longer, is clearer.

It might not if you don't know what a "tree" is in git speak.  The 
notion of what a tree refers to is slowly introduced afterwards which I 
think is better than delivering everything in a dense four lines right 
up front.


