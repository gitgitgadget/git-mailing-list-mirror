From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Tue, 18 Dec 2007 15:12:56 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712181511030.8467@xanadu.home>
References: <7v3au16myj.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999999.0712171641460.8467@xanadu.home>
 <7vbq8o4yxc.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999999.0712172212110.8467@xanadu.home>
 <46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com>
 <7vlk7s38aq.fsf@gitster.siamese.dyndns.org>
 <20071218111136.GA6266@coredump.intra.peff.net>
 <Pine.LNX.4.64.0712181204500.23902@racer.site>
 <20071218124808.GA3728@sigill.intra.peff.net>
 <Pine.LNX.4.64.0712181329340.23902@racer.site>
 <20071218193035.GA4583@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:13:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4iow-0004o1-7f
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbXLRUNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 15:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbXLRUNT
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:13:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:14567 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbXLRUNS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 15:13:18 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT9005OPHHIYIC0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Dec 2007 15:12:54 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071218193035.GA4583@sigill.intra.peff.net>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68802>

On Tue, 18 Dec 2007, Jeff King wrote:

> So there will be user-visible changes (though I don't expect them to be
> huge...there simply aren't that many variables with optional arguments).

OTOH, there are quite a bunch of changes affecting the user experience.  
Many of the feedback messages printed by Git were completely revamped, 
starting with the progress display to the fetch summary.


Nicolas
