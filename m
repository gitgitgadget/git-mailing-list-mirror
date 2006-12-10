X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Documentation/git-commit: rewrite to make it more end-user
 friendly.
Date: Sun, 10 Dec 2006 17:07:40 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612101704390.2630@xanadu.home>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612082141260.2630@xanadu.home>
 <7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net>
 <200612100130.48812.Josef.Weidendorfer@gmx.de>
 <20061210210057.GB23387@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 10 Dec 2006 22:08:01 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061210210057.GB23387@fieldses.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33937>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtWpl-0008DV-1s for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935336AbWLJWHl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935379AbWLJWHl
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:07:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20271 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S935336AbWLJWHl (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 17:07:41 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA200HDPW4SWZA0@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Sun,
 10 Dec 2006 17:07:40 -0500 (EST)
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

On Sun, 10 Dec 2006, J. Bruce Fields wrote:

> Or maybe: "by using gitlink:git-add[1] to add new content (of either new
> or newly modified files) to the next commit."
> 
> Man pages are reference documentation, so I figure it's OK to sacrifice
> a little newbie-friendliness for accuracy and concision.

I disagree.  Clarity should be the first goal.  And the fact that even 
modified files have to be specified is something worth enphasizing, 
especially since this is not something other systems do.


