From: Nicolas Pitre <nico@cam.org>
Subject: Re: Listing of branch creation time?
Date: Tue, 27 Mar 2007 21:29:11 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703272126290.3041@xanadu.home>
References: <17929.37382.984339.742025@lisa.zopyra.com>
 <20070327233552.GA7186@coredump.intra.peff.net>
 <17929.45060.6228.797279@lisa.zopyra.com>
 <20070328000149.GA12808@coredump.intra.peff.net>
 <17929.45543.421196.935796@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 03:29:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWMyS-0005eH-5R
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 03:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934262AbXC1B3N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 21:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934263AbXC1B3N
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 21:29:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47072 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934262AbXC1B3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 21:29:12 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFL002PXASN2FC0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Mar 2007 21:29:11 -0400 (EDT)
In-reply-to: <17929.45543.421196.935796@lisa.zopyra.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43340>

On Tue, 27 Mar 2007, Bill Lear wrote:

> Queries that help me answer the question of "did I merge this
> branch?", "when did I merge it?" (i.e., "Can I delete this branch?"),
> along with creation times and last modified times, I think would be
> helpful.

The reflog is your friend for such questions.


Nicolas
