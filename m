From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 17:24:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606291723060.1213@localhost.localdomain>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
 <20060629180011.GA4392@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
 <20060629185335.GA6704@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
 <20060629195201.GA10786@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
 <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 23:24:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw400-0006SD-74
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 23:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbWF2VY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 17:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWF2VY0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:24:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23448 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932708AbWF2VYY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 17:24:24 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1N00E0Q4SN7VH0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Jun 2006 17:24:23 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22906>

On Thu, 29 Jun 2006, Linus Torvalds wrote:

> Instead of having a separate cache, wouldn't it be much better to just 
> take the hint from the previous pack-file?

DOH!  ;-)


Nicolas
