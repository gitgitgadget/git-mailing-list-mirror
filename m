From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] revision caching documentation: man page and technical
   discussion
Date: Fri, 7 Aug 2009 14:20:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908071419590.8306@pacific.mpi-cbg.de>
References: <op.ux8i6lq9tdk399@sirnot.private> <4A7B9ACA.1060601@vilain.net> <4A7C18F2.2000905@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Nick Edelen <sirnot@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rogan Dawes <discard@dawes.za.net>
X-From: git-owner@vger.kernel.org Fri Aug 07 14:20:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZOQr-0008VY-8z
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 14:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757631AbZHGMUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 08:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757366AbZHGMUP
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 08:20:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:45515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757258AbZHGMUO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 08:20:14 -0400
Received: (qmail invoked by alias); 07 Aug 2009 12:20:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 07 Aug 2009 14:20:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/az9YgwL3an1ek3YTP4wBW/MYQp7eO6/dj6zd9eg
	qpKSDMgeS7RUhX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A7C18F2.2000905@dawes.za.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125193>

Hi,

On Fri, 7 Aug 2009, Rogan Dawes wrote:

> Sam Vilain wrote:
> 
> >> +`fuse`::
> >> +	Coagulate several cache slices into a single large slice.
> >>   
> > 
> > Coagulate?  You mean, the revision caches will stop being liquid and go
> > gluggy, like a pool of blood clotting?
> > 
> > How about "combine" :-) - and the option might be better called
> > something simple like that, too.
> 
> I think the word he had in mind was "coalesce".

As Git users typically have a quite good idea what a "merge" is, I'd 
prefer that word anyway.

Ciao,
Dscho
