From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] remove ARM and Mozilla SHA1 implementations
Date: Mon, 24 Aug 2009 00:12:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908240011010.6044@xanadu.home>
References: <alpine.LFD.2.00.0908171940540.6044@xanadu.home>
 <alpine.DEB.1.00.0908180208160.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 24 06:12:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfQv5-0001tU-6j
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 06:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbZHXEM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 00:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbZHXEM0
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 00:12:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18927 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZHXEM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 00:12:26 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOV006J250MK5G0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 24 Aug 2009 00:12:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0908180208160.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126902>

On Tue, 18 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 17 Aug 2009, Nicolas Pitre wrote:
> 
> > They are both slower than the new BLK_SHA1 implementation, so it is
> > pointless to keep them around.
> > 
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> > ---
> > 
> > Someone else would need to make the call for the PPC version.
> 
> If I don't forget, I can test tomorrow on 2 different 32-bit PPCs and 
> possibly one 64-bit PPC.

Did you forget?   ;-)


Nicolas
