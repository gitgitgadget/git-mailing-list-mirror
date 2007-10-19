From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 10:54:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710191053390.19446@xanadu.home>
References: <20071019062219.GA28499@coredump.intra.peff.net>
 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
 <20071019073938.GN14735@spearce.org>
 <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
 <20071019113822.GB16726@thunk.org> <4718A3AB.7090301@viscovery.net>
 <alpine.LFD.0.9999.0710191009330.19446@xanadu.home>
 <8aa486160710190731v67626fd8wa94ba069a17f73ce@mail.gmail.com>
 <4718C1DE.5030708@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	Theodore Tso <tytso@thunk.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:55:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IitG1-00051Y-VX
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268AbXJSOzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 10:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933260AbXJSOzO
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:55:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48128 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230AbXJSOzM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 10:55:12 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ50035RYR5R5F0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Oct 2007 10:54:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4718C1DE.5030708@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61724>

On Fri, 19 Oct 2007, Johannes Sixt wrote:

> The '*' could go away, then the '+' is more visible.

Agreed.  ' ' = fast forward, '+' = forced update, and '!' = refused.


Nicolas
