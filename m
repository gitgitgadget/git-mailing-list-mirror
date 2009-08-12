From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign
 vcs
Date: Wed, 12 Aug 2009 02:14:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908120212500.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org> <7v1vnk79lt.fsf@alter.siamese.dyndns.org> <36ca99e90908110831g2ad52a5ar4a755723a6682f77@mail.gmail.com> <alpine.DEB.1.00.0908111817490.4638@intel-tinevez-2-302> <20090811214849.GA3868@sigill.intra.peff.net>
 <20090812075914.6117@nanako3.lavabit.com> <20090811230233.GA25642@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 02:13:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb1TQ-0006y7-Hx
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 02:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbZHLANg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 20:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbZHLANg
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 20:13:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:53382 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751227AbZHLANg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 20:13:36 -0400
Received: (qmail invoked by alias); 12 Aug 2009 00:13:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 12 Aug 2009 02:13:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+m20kYGiqmz16NrQgQ76QZEXCAvuyAk4oHMn5sXE
	1cS9ATeXoRfmTP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090811230233.GA25642@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125625>

Hi,

On Tue, 11 Aug 2009, Jeff King wrote:

> On Wed, Aug 12, 2009 at 07:59:14AM +0900, Nanako Shiraishi wrote:
> 
> > Then how about using a prefix that has been invalid, "vcs::$string",
> > for example?
> 
> I have no problem with that, and I think it makes it even more visually
> obvious what is going. For example:
> 
>   svn::http://server/path/to/repo
> 
> makes the "svn" prefix jump out a bit more.

... and http:://repo.or.cz/r/git.git ?  Thanks.  But no, thanks.

Ciao,
Dscho
