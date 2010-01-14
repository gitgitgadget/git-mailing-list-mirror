From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 01:33:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001140132110.4985@pacific.mpi-cbg.de>
References: <op.u6g8jnixg402ra@nb-04> <871vht7cs2.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 01:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVDZO-0001Ho-HZ
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 01:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756719Ab0ANA2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 19:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756164Ab0ANA2J
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 19:28:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:47894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756676Ab0ANA2I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 19:28:08 -0500
Received: (qmail invoked by alias); 14 Jan 2010 00:28:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 14 Jan 2010 01:28:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19r+x4Dbchr0zOpO4JTlPUypb0zWSXKXMOoJmm4yM
	08jDj/hizJiMR5
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <871vht7cs2.fsf@catnip.gol.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136903>

Hi,

On Thu, 14 Jan 2010, Miles Bader wrote:

> "Rudolf Polzer" <divVerent@alientrap.org> writes:
> > I'd like a feature to automatically "transform" a non-tracking local 
> > branch into a tracking branch on push. A patch to do that is attached.
> 
> Yay!!
> 
> I've wanted this for a long time, but discussions about it always seem 
> to end up petering out...

That is not fair.  I came up with a patch already years ago.  You could 
always have applied it to your own source, maybe after tweaking.  And then 
maybe lobbying for it.

Ciao,
Dscho
