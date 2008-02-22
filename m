From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Fri, 22 Feb 2008 00:11:25 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802220010260.17164@racer.site>
References: <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802100213330.11591@racer.site> <20080210101756.GB26568@coredump.intra.peff.net> <alpine.LSU.1.00.0802101219280.11591@racer.site> <20080210122321.GA31009@coredump.intra.peff.net>
 <alpine.LSU.1.00.0802101303140.11591@racer.site> <7vzltwavf9.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802201305350.17164@racer.site> <76718490802200720w4dd89dc1lf7b19d546d3bfd00@mail.gmail.com> <alpine.LSU.1.00.0802201535250.17164@racer.site>
 <20080221223549.GA26266@dervierte>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 01:12:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSLWa-0002Ol-51
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 01:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759888AbYBVALs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 19:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756476AbYBVALs
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 19:11:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:45206 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755333AbYBVALr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 19:11:47 -0500
Received: (qmail invoked by alias); 22 Feb 2008 00:11:45 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp031) with SMTP; 22 Feb 2008 01:11:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IJSYx1IBI3W4LV08AX9I9jzbQfKWPr4fq6I+cK7
	j5xsTfjSvQ2eVs
X-X-Sender: gene099@racer.site
In-Reply-To: <20080221223549.GA26266@dervierte>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74684>

Hi,

On Thu, 21 Feb 2008, Steven Walter wrote:

> On Wed, Feb 20, 2008 at 03:38:31PM +0000, Johannes Schindelin wrote:
> > That depends awfully on your definition of "safe".
> > 
> > I, for one, hate the idea already, that I am "safe" when "git push" 
> > does not do the thing I asked it to, and which it has done for a 
> > couple of years now without complaint, and which I have gotten used 
> > to.
> > 
> > And then, there will be a great confusion for me, since I work on 5 
> > different machines on an average day, with 5 different git versions, 
> > and having different config settings.
> 
> Which is worse: pushing more refs than you intended (requiring rewinding 
> refs on a repository that other people may pull from), or pushing fewer 
> refs than you intended, requiring you to run the command a second time? 

Sorry to say, but I find this argumentation lacking.

Is it worse to suffer, or is it worse to suffer?  We should try to make it 
_safe_ not "less painful, but still painful nevertheless".

Hth,
Dscho
