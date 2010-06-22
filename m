From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: unpacker error on push
Date: Mon, 21 Jun 2010 20:58:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006212054110.24097@xanadu.home>
References: <0B32FF97-4B20-4B9A-BA45-08EF9485F3A1@nvidia.com>
 <alpine.LFD.2.00.1006161520480.13427@xanadu.home>
 <64131565-2407-4EBF-A6CB-7C286E1B20D4@nvidia.com>
 <alpine.LFD.2.00.1006181332230.13427@xanadu.home>
 <26F05D1B-E6A7-4039-B337-DA5C027A4EE5@nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gavin Kistner <gkistner@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 02:58:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQrp1-0004qj-As
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 02:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758708Ab0FVA6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 20:58:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39658 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab0FVA6e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 20:58:34 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L4E00ETX5DKBB10@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 21 Jun 2010 20:58:33 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <26F05D1B-E6A7-4039-B337-DA5C027A4EE5@nvidia.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149461>

On Fri, 18 Jun 2010, Gavin Kistner wrote:

> On Jun 18, 2010, at 11:35 AM, Nicolas Pitre wrote:
> > On Fri, 18 Jun 2010, Gavin Kistner wrote:
> >> I deleted my local copy and cloned using ssh instead if git://, copied 
> >> over the same changes and was able to push again. This looks to be my 
> >> workaround.
> >> 
> >> If anyone wants to dive deeper into this problem, please let me know 
> >> and we can fight it using the snapshots I have. 
> > 
> > I would be interested in them.
> 
> OK, I'll coordinate with you off-list.

Well... I just can't reproduce the issue with those repositories you 
provided me with.  Neither over git:// nor file:// nor ssh://.  But all 
I have here are Linux machines, no OSX.

Could you try pushing from a Linux machine by chance?  Maybe this is an 
OSX related issue.


Nicolas
