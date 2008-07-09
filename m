From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Wed, 9 Jul 2008 14:54:05 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807091453010.18205@racer>
References: <20080701150119.GE5852@joyeux> <20080709101330.GA3525@joyeux> <alpine.DEB.1.00.0807091427270.5277@eeepc-johanness> <20080709134629.GA3848@joyeux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sylvain Joyeux <sylvain.joyeux@dfki.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 15:55:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGa8T-0001XW-9j
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 15:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbYGINyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 09:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbYGINyK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 09:54:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:56993 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752555AbYGINyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 09:54:09 -0400
Received: (qmail invoked by alias); 09 Jul 2008 13:54:07 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp023) with SMTP; 09 Jul 2008 15:54:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Ir6FVKkpIV4Pkexj+wyML++dIIx1waXSqNuJ//f
	038gEP2heKvlmI
X-X-Sender: gene099@racer
In-Reply-To: <20080709134629.GA3848@joyeux>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87884>

Hi,

On Wed, 9 Jul 2008, Sylvain Joyeux wrote:

> [Sylvain quoted somebody, but found it funny to let the reader guess]
>
> > On a related note, the long commit name has been a constant nuisance 
> > for me.  A short commit name is perfectly enough, methinks.
>
> I also think so. The commit ID is completely useless for humans. 
> Nonetheless, that would change the git-submodules output which 
> (according to someone-that-I-dont-remember) would be a Bad Thing(tm).

Is git-submodule supposed to be plumbing?  I don't think so.

Ciao,
Dscho
