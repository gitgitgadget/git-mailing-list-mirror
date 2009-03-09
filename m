From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or
 configured
Date: Mon, 9 Mar 2009 21:48:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903092148040.6358@intel-tinevez-2-302>
References: <20090305221529.GA25871@pvv.org> <alpine.DEB.1.00.0903061126550.10279@pacific.mpi-cbg.de> <200903092139.35788.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 09 21:50:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgmQo-00060L-UZ
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 21:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbZCIUsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 16:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbZCIUsp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 16:48:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:54937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752569AbZCIUso (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 16:48:44 -0400
Received: (qmail invoked by alias); 09 Mar 2009 20:48:34 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp066) with SMTP; 09 Mar 2009 21:48:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pzVRsaRLp3TPd8hByNzyGY22xDee8prHii70Hfm
	hnfz9AvIzpoI7A
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200903092139.35788.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112739>

Hi,

On Mon, 9 Mar 2009, Markus Heidelberg wrote:

> Johannes Schindelin, 06.03.2009:
> > > -already exists on the remote side.  This is the default operation mode
> > > +already exists on the remote side. Nothing will be pushed
> > 
> > The two spaces after the full stop were not actually a typo.
> 
> What's its purpose? Just recently I added "set nojoinspaces" to my
> .vimrc to not insert two spaces when joining sentences.

It was explained to me as "English grammar".  Two spaces after a full 
stop.

Ciao,
Dscho
