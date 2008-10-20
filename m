From: Nicolas Pitre <nico@cam.org>
Subject: Re: [BUG?] Fail to pull from kernel.org: pack has bad object
Date: Mon, 20 Oct 2008 16:51:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810201649210.26244@xanadu.home>
References: <200810201010.29173.johan@herland.net>
 <200810201610.54427.trast@student.ethz.ch>
 <alpine.LFD.2.00.0810201112360.26244@xanadu.home>
 <200810202247.33372.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 20 23:44:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks1k7-0007uP-Fi
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 22:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759AbYJTUv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 16:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755745AbYJTUv3
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 16:51:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48215 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732AbYJTUv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 16:51:28 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9200C1Z1XMORJO@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 20 Oct 2008 16:51:23 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200810202247.33372.trast@student.ethz.ch>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98715>

On Mon, 20 Oct 2008, Thomas Rast wrote:

> Nicolas Pitre wrote:
> > On Mon, 20 Oct 2008, Thomas Rast wrote:
> > >   http://n.ethz.ch/~trast/download/tmp_pack_NMj69p
> > 
> > Yes, except I can't resolve any of the deltas in there...  Is it from 
> > the Linux kernel repository?
> 
> No, that was in my own git.git.  Here's the entire repo, if that
> context helps.

Thanks but I think I already fixed it now.  See the latest patch I just 
posted to the list.


Nicolas
