From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 14:07:02 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801161405330.17650@racer.site>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <ee77f5c20801160254u53e07773qb4125ffd90cf7619@mail.gmail.com> <alpine.DEB.1.00.0801161517260.5260@bender.nucleusys.com> <alpine.LSU.1.00.0801161341430.17650@racer.site>
 <alpine.DEB.1.00.0801161549140.5260@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:08:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF8vW-0005EK-WD
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbYAPOHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 09:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYAPOHG
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 09:07:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:55305 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752765AbYAPOHF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 09:07:05 -0500
Received: (qmail invoked by alias); 16 Jan 2008 14:07:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 16 Jan 2008 15:07:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Hlh8aUkbHprZ5+iHbh8uHEHI/HuSQKKmEjQSkfW
	UXGbTDYtd51yVD
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.DEB.1.00.0801161549140.5260@bender.nucleusys.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70675>

Hi,

On Wed, 16 Jan 2008, Petko Manolov wrote:

> On Wed, 16 Jan 2008, Johannes Schindelin wrote:
> 
> > I think that you're missing the point of version control.  It's not 
> > only about having an up-to-date source tree, but also about being able 
> > to go back to a certain revision.
> 
> No contradiction here.  In my case old source code will work perfectly 
> with new binaries/firmware.  That's why i don't _need_ the history, only 
> the latest stuff in order to save space.

No, you _do_ miss the point here.  You might _think_ that they work 
perfectly, but with revision control you want to have _exactly_ the same 
setup.  You want to be able to go back to a certain _revision_ (including 
the then-current firmware).

And that's what you don't want.  So git is not for you.

Ciao,
Dscho
