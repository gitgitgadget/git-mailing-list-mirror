From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 19:58:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141957530.30505@racer.site>
References: <200802081828.43849.kendy@suse.cz> <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz> <alpine.LFD.1.00.0802092200350.2732@xanadu.home> <alpine.LSU.1.00.0802101640570.11591@racer.site> <alpine.LFD.1.00.0802101445430.2732@xanadu.home>
 <47B4996B.4000900@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Feb 14 20:59:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPkEb-0000aG-9I
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 20:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580AbYBNT6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 14:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756560AbYBNT6a
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 14:58:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:35346 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756155AbYBNT63 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 14:58:29 -0500
Received: (qmail invoked by alias); 14 Feb 2008 19:58:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 14 Feb 2008 20:58:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jEtlW3iKjVrKJz/0HkT0QtAfNRMmbVhtLcHmPp/
	gpHQYyZMCv6pV7
X-X-Sender: gene099@racer.site
In-Reply-To: <47B4996B.4000900@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73909>

Hi,

On Thu, 14 Feb 2008, Brandon Casey wrote:

> 	I just received Dscho's email, this is interesting to compare
> 	with his single threaded result of 1638490531. I wonder if he
> 	used deltabaseoffset?

Nope.  Wanted it to be as compatible as possible.

Ciao,
Dscho
