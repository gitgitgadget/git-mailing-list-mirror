From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Document levenshtein.c
Date: Thu, 20 Nov 2008 19:31:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811201930250.30769@pacific.mpi-cbg.de>
References: <20081118185326.12721.71576.stgit@arrakis.enst.fr>  <alpine.DEB.1.00.0811190151000.30769@pacific.mpi-cbg.de>  <2008-11-19-09-42-45+trackit+sam@rfc1149.net>  <alpine.DEB.1.00.0811191053250.30769@pacific.mpi-cbg.de>  <7vhc63svsl.fsf@gitster.siamese.dyndns.org>
  <alpine.DEB.1.00.0811201255120.30769@pacific.mpi-cbg.de>  <2008-11-20-13-00-31+trackit+sam@rfc1149.net>  <alpine.DEB.1.00.0811201426100.30769@pacific.mpi-cbg.de> <1227201710.22668.2.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Samuel Tardieu <sam@rfc1149.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:24:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3ED1-0002g2-Hf
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 19:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbYKTSXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 13:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbYKTSXk
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 13:23:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:60152 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753642AbYKTSXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 13:23:39 -0500
Received: (qmail invoked by alias); 20 Nov 2008 18:23:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 20 Nov 2008 19:23:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19d32we3EddG0vX/FFsJAqxcIWPZEZCMDhVlxruUi
	jrA0JOuK7bDNk9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1227201710.22668.2.camel@ld0161-tx32>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101465>

Hi,

On Thu, 20 Nov 2008, Jon Loeliger wrote:

> On Thu, 2008-11-20 at 14:27 +0100, Johannes Schindelin wrote:
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> > + * This implementation allows the costs to be weighted:
> > + *
> > + * - w (as in "sWap")
> > + * - s (as in "Substition")
> > + * - a (for insertion, AKA "Add")
> > + * - d (as in "Deletion")
> > + *
> 
> I'm not sure what "Substition" is besides a misspelling.

It is a msipeling.

Thanks,
Dscho
