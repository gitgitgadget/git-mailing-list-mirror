From: Nicolas Pitre <nico@cam.org>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Mon, 02 Jul 2007 22:56:16 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707022253580.26459@xanadu.home>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
 <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
 <20070630194335.GK7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <7vtzsoami9.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0706301955560.1172@woody.linux-foundation.org>
 <7vsl8894tc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 04:56:29 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5YZ3-0004zX-DF
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 04:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbXGCC4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 22:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbXGCC4S
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 22:56:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34437 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbXGCC4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 22:56:17 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JKL00E621HS0XH0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 02 Jul 2007 22:56:16 -0400 (EDT)
In-reply-to: <7vsl8894tc.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51442>

On Sat, 30 Jun 2007, Junio C Hamano wrote:

> Your patch _closes the door_ for us to implement overriding
> aliases later if we wanted to; we would need to go back to the
> scripts and say "git --no-alias xyzzy" again.

I think such aliases would be evil.  Closing the door on them is most 
certainly a good thing IMHO.


Nicolas
