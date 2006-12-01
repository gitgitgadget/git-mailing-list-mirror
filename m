X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 20:20:10 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611302017120.9647@xanadu.home>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home>
 <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <87ejrlvn7r.wl%cworth@cworth.org>
 <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>
 <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>
 <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org>
 <Pine.LNX.4.64.0611301521320.9647@xanadu.home>
 <7vhcwgiqer.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611301624430.9647@xanadu.home>
 <7vlklsfsgz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 1 Dec 2006 01:20:49 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Carl Worth <cworth@cworth.org>,
	Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vlklsfsgz.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32842>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpx50-0001DB-Gd for gcvg-git@gmane.org; Fri, 01 Dec
 2006 02:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031705AbWLABUN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 20:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031702AbWLABUN
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 20:20:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10845 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1031699AbWLABUL
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 20:20:11 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9K007H9MDMEF60@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 30 Nov 2006 20:20:10 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, 30 Nov 2006, Junio C Hamano wrote:

> I sense that you are inviting me to argue for reverting the
> other "git commit" braindead which is spelled "--only" (and
> worse yet, it is the default).  I am very tempted.

No no no !

I argued for that at the time and I still stands behind that change !


