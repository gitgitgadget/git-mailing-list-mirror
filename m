From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 11:34:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811201132220.30769@pacific.mpi-cbg.de>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <1227098252.11370.8.camel@therock.nsw.bigpond.net.au> <vpqhc63zrz2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Arafangion <thestar@fussycoder.id.au>,
	Roger Leigh <rleigh@codelibre.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Nov 20 11:27:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L36kz-0002pU-I6
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 11:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbYKTK0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 05:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbYKTK0O
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 05:26:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:45838 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753746AbYKTK0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 05:26:13 -0500
Received: (qmail invoked by alias); 20 Nov 2008 10:26:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 20 Nov 2008 11:26:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18VLUY/iYUVpStna1k6VR5NShvVY24PDtr1U5c5MZ
	SNzW0Fk787IlSE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <vpqhc63zrz2.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101401>

Hi,

On Wed, 19 Nov 2008, Matthieu Moy wrote:

> Arafangion <thestar@fussycoder.id.au> writes:
> 
> > You should probably fix your build script,
> 
> ccache should help:

Only if you _allow_ the problem that makes ccache necessary.  Which we 
don't.

Ciao,
Dscho

P.S.: reminds me -- once again -- of the complicator's glove.
