From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: hg2git error
Date: Wed, 22 Jul 2009 19:47:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907221946590.7343@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0905241932301.26154@pacific.mpi-cbg.de>  <fabb9a1e0905241038x7ea22622k930f50b9c7598c6e@mail.gmail.com>  <alpine.DEB.1.00.0905242013080.26154@pacific.mpi-cbg.de> <fabb9a1e0905241120v65adf9f9u7b8d212e99d7f6cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1714512354-1248284845=:7343"
Cc: Rocco Rutte <pdmef@gmx.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 19:47:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTfuq-0006Yv-MX
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 19:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbZGVRr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 13:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbZGVRr2
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 13:47:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:32831 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753111AbZGVRr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 13:47:27 -0400
Received: (qmail invoked by alias); 22 Jul 2009 17:47:26 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 22 Jul 2009 19:47:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FgmNS5fpFhiPOFa03EEhXWPJNVog9D3n1jMfmh6
	eLmr6IWiGVeqQU
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fabb9a1e0905241120v65adf9f9u7b8d212e99d7f6cd@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123759>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1714512354-1248284845=:7343
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 24 May 2009, Sverre Rabbelier wrote:

> On Sun, May 24, 2009 at 20:16, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
> > It says "Achtung! Alpha!".  How alpha is it?
> 
> I'm using it to work on Melange, the problems I've had with it so far 
> have all been fixed :).
> 
> > Also, there is the issue that it is a Hg extension.  My experience 
> > with such extensions and their dependency on certain Hg versions make 
> > me ask: what version of Hg must I install before I can use Hg-git?
> 
> Right, you will need to have hg installed to bridge between git and hg, 
> I think the current requirements are 'python 2.5' and 'hg 1.2' but 
> that's mostly because that's what we're testing, not because we depend 
> on specific features.

Could you give me a quick run-through how to install it and use it to 
mirror, say, the netbeans repository?

Thanks,
Dscho

--8323329-1714512354-1248284845=:7343--
