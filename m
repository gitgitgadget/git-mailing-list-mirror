From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 11/10] allow forcing index v2 and 64-bit offset treshold
Date: Mon, 09 Apr 2007 21:03:35 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704092046080.28181@xanadu.home>
References: <alpine.LFD.0.98.0704091727300.28181@xanadu.home>
 <7vps6dxjvb.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704091901290.28181@xanadu.home>
 <7vejmtxekj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:09:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb4lu-0007s7-00
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 03:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbXDJBDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 21:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbXDJBDh
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 21:03:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15718 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030200AbXDJBDg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 21:03:36 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG900LX7C9ZGWF0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 21:03:35 -0400 (EDT)
In-reply-to: <7vejmtxekj.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44103>

On Mon, 9 Apr 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Mon, 9 Apr 2007, Junio C Hamano wrote:
> >
> >> It appears everybody is short of time.  I am having two
> >> troubles.  Nobody seems to have positive nor negative reports or
> >> comments on what are cooking in 'next' so nothing can graduate,
> >> and I am behind list discussions on certain areas myself.
> >
> > At least my latest patch series received two positive reviews.  ;-)
> 
> They are _not_ even in 'pu'.  I am talking about things that
> have been cooking.

Remember that positive comments are by default much less verbose than 
negative ones. In other words, no news is probably good news.

> >> > ddiff --git a/t/Makefile b/t/Makefile
> >> 
> >> ???

$ touch t/Makefile
$ git diff


Nicolas
