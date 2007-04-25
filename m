From: Nicolas Pitre <nico@cam.org>
Subject: Re: Making git disappear when talking about my code
Date: Wed, 25 Apr 2007 16:32:36 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704251631520.12375@xanadu.home>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home>
 <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl>
 <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
 <4627ABBB.8060709@softax.com.pl>
 <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
 <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
 <87vefm7l6g.wl%cworth@cworth.org>
 <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
 <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net> <87mz0w7g3j.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0704251345220.28708@iabervon.org>
 <7vzm4ww7lj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 22:32:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgoAO-0004xD-IU
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 22:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993105AbXDYUck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 16:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993107AbXDYUck
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 16:32:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37740 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993105AbXDYUcj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 16:32:39 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JH2008OTMECVY80@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Apr 2007 16:32:37 -0400 (EDT)
In-reply-to: <7vzm4ww7lj.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45568>

On Wed, 25 Apr 2007, Junio C Hamano wrote:

> I think I already suggested this to Carl once, but if you 
> forget about 'git clone' in this case (or any other cases), your
> example would just work.
> 
> 	$ git init
>         $ git pull git://server/path branch

Ah, goodie!


Nicolas
