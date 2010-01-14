From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git Wiki Move
Date: Thu, 14 Jan 2010 11:43:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001141136450.4985@pacific.mpi-cbg.de>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> <4B4EF1E0.3040808@eaglescrag.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 11:38:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVN5h-0007Dc-6N
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 11:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab0ANKiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 05:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754938Ab0ANKiH
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 05:38:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:43322 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754559Ab0ANKiF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 05:38:05 -0500
Received: (qmail invoked by alias); 14 Jan 2010 10:38:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 14 Jan 2010 11:38:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tCrwnpsdtiuF74RmPF5TahLLeMSeSyl+Bb/IxbL
	criM6iKQnpL3Tg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B4EF1E0.3040808@eaglescrag.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136982>

Hi,

On Thu, 14 Jan 2010, J.H. wrote:

> On 01/13/2010 05:24 PM, Petr Baudis wrote:
> 
> > On Thu, Jan 14, 2010 at 12:29:08AM +0100, Petr Baudis wrote:
> >> I would like to notify you that unfortunately, Czech UPC terminated 
> >> the sponsorship of the hardware and connectivity hosting the Git Wiki 
> >> and repo.or.cz (after generously donating it for several years).
> > 
> >   ...please scratch the Git Wiki part, you would be supporting just 
> > repo.or.cz - we are considering to move the Git wiki to 
> > wiki.kernel.org MediaWiki installation and I would like to ask if 
> > anyone disagrees with this. The motivation is that:
> > 
> > 	(i) wiki.kernel.org is actually maintained! Thus, there should be 
> > 	less spam or upgrade issues and better support in case of problems.
> > 
> > 	(ii) Also, I personally think MediaWiki is so much nicer than 
> > 	ikiwiki...

... not to mention than MoinMoin...

> > 	(iii) ...and OBTW, no CamelCase!
> > 
> >   Of course, there will be compatibility redirects.
> 
> Just a heads up I've got an initial import of the current wiki up at
> http://git.wiki.kernel.org - some of it was quite a clean conversion,
> some of it not so much.

Did you use a script?  And did you leech the sources, or did you get a 
dump?

I note that "<<<!-- ! TOC here -->(2)>>" could be converted to "__TOC__", 
I believe.

> Please note that user accounts were not carried over but edit histories 
> were.

IIUC there are no email addresses stored in the Git Wiki, so I think that 
we'll have to live with that.  You might get the occasional complaint of a 
stolen account.

> I'll work on cleaning up the rest of if tomorrow, assuming that there 
> isn't any objections to Petr's e-mail above.

I like it.  Especially since there is a fun project waiting for me to 
get some time to do it, to convert the full history of a MediaWiki 
instance into a Git repository.  Maybe via the git-remote* mechanism, once 
Sverre and Ilari manage to flush out the last remnants of clumsy design.

Ciao,
Dscho
