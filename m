From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 10:56:23 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710191055120.19446@xanadu.home>
References: <20071019062219.GA28499@coredump.intra.peff.net>
 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
 <20071019073938.GN14735@spearce.org>
 <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
 <20071019113822.GB16726@thunk.org> <4718A3AB.7090301@viscovery.net>
 <alpine.LFD.0.9999.0710191009330.19446@xanadu.home>
 <8aa486160710190731v67626fd8wa94ba069a17f73ce@mail.gmail.com>
 <Pine.LNX.4.64.0710191640250.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Theodore Tso <tytso@thunk.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:56:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IitHA-0005LA-MT
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933397AbXJSO4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 10:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933332AbXJSO4Z
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:56:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48291 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933260AbXJSO4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 10:56:24 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ5003DYYTZR5F0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Oct 2007 10:56:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.64.0710191640250.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61725>

On Fri, 19 Oct 2007, Johannes Schindelin wrote:

> Better to say (forced) if need be.  But I do not think so.  I like Hannes' 
> proposal as-is.

I'm of that opinion too.  Except maybe using a space instead of * for 
fast forward, so the other types stand out more.


Nicolas
