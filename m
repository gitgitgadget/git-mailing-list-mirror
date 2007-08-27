From: Petr Baudis <pasky@suse.cz>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?,
	.gitacls? etc.
Date: Mon, 27 Aug 2007 18:54:16 +0200
Message-ID: <20070827165416.GR1219@pasky.or.cz>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com> <7v1wdqud0z.fsf@gitster.siamese.dyndns.org> <loom.20070827T172150-191@post.gmane.org> <86odgtou5p.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 18:57:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPhr6-0000yQ-OV
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 18:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbXH0QyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 12:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbXH0QyT
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 12:54:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43553 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbXH0QyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 12:54:18 -0400
Received: (qmail 6308 invoked by uid 2001); 27 Aug 2007 18:54:16 +0200
Content-Disposition: inline
In-Reply-To: <86odgtou5p.fsf@lola.quinscape.zz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56858>

On Mon, Aug 27, 2007 at 05:48:34PM CEST, David Kastrup wrote:
> Sergio Callegari <scallegari@arces.unibo.it> writes:
> 
> > Couldn't all this directory/ownership/permission tracing be easily
> > done by using hooks?  E.g. Having a pre-status and pre-commit hook
> > one could fire up a program/script to collect all the extra info he
> > wants to trace and store it somewhere (typically in some traced
> > file).  The other way round one could have a post-checkout hook and
> > he could arrange it to fire up some program to look into the
> > extra-info file to set up all the meta-data he wants.
> >
> > This would be very flexible and would permit to manage absolutely
> > /any/ kind of the metadata leaving absolute freedom about how to do
> > so.
> >
> > Am I missing something here?
> 
> Merging.

Fetching.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
