From: Nicolas Pitre <nico@cam.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 06 Feb 2007 10:33:31 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702061027570.19212@xanadu.home>
References: <87odognuhl.wl%cworth@cworth.org> <87y7nbdeaw.wl%cworth@cworth.org>
 <20070206072820.GC23866@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 06 16:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HESKH-0007ZQ-Dr
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 16:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbXBFPdd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 10:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbXBFPdd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 10:33:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21663 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606AbXBFPdc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 10:33:32 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD10020TSJV1VB0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Feb 2007 10:33:31 -0500 (EST)
In-reply-to: <20070206072820.GC23866@coredump.intra.peff.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38851>

On Tue, 6 Feb 2007, Jeff King wrote:

> I'm not convinced that the complication is a good idea.  However, if you
> would like to play with it, a patch is below (it depends on my 'add
> utility functions for enumerating remotes' patch, which I just posted).


Your patch forgot to add the equivalent handling to dwim_log().


Nicolas
