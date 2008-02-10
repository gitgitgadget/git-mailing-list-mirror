From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 17:36:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101735530.11591@racer.site>
References: <200802081828.43849.kendy@suse.cz>  <m3ejbngtnn.fsf@localhost.localdomain>  <200802091627.25913.kendy@suse.cz>  <alpine.LFD.1.00.0802092200350.2732@xanadu.home>  <alpine.LSU.1.00.0802101640570.11591@racer.site>
 <9e4733910802100901m729b0cdfg85ccc0ca77011249@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 18:37:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOG6j-0003cD-IQ
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 18:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbYBJRgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 12:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbYBJRgM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 12:36:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:51881 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751141AbYBJRgL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 12:36:11 -0500
Received: (qmail invoked by alias); 10 Feb 2008 17:36:09 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp020) with SMTP; 10 Feb 2008 18:36:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4s2NAPPj443OgsvDk2NN3PmI1U96MwaPRNYzemL
	R6Hixy5JH2ABAZ
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910802100901m729b0cdfg85ccc0ca77011249@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73379>

Hi,

On Sun, 10 Feb 2008, Jon Smirl wrote:

> Turning on multi-core support greatly increases the memory consumption; 
> at least double the single thread case.

That's why I did not do it.

Ciao,
Dscho
