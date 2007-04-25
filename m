From: Nicolas Pitre <nico@cam.org>
Subject: Re: Making git disappear when talking about my code
Date: Wed, 25 Apr 2007 15:22:59 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704251521110.12375@xanadu.home>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
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
 <87k5w07dft.wl%cworth@cworth.org>
 <alpine.LFD.0.98.0704250751330.9964@woody.linux-foundation.org>
 <87fy6o770w.wl%cworth@cworth.org>
 <alpine.LFD.0.98.0704251341280.12375@xanadu.home>
 <878xcg6zv0.wl%cworth@cworth.org> <7vfy6oxnzp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:23:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgn52-0006cS-4c
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993002AbXDYTXE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992988AbXDYTXE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:23:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55212 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993002AbXDYTXD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:23:03 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JH200JD9J6B3KJ0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Apr 2007 15:23:00 -0400 (EDT)
In-reply-to: <7vfy6oxnzp.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45549>

On Wed, 25 Apr 2007, Junio C Hamano wrote:

> I would agree with you that if you are talking to total git
> newbie, you cannot get away with message like [3] in your
> original and you would need some instructions you added in your
> example [2].  But I suspect that is true for any new system.  If
> somebody has never seen cvs and your project is hosted at cvs,
> and if you want to be really helpful, I think you have to tell
> "cvs -d :pserver:... co cworth-project" somewhere in your
> message.

You forget about "cvs -d :pserver:... login" that needs to be performed 
as well.


Nicolas
