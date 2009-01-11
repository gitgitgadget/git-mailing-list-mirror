From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and 
 --prune-empty.
Date: Sun, 11 Jan 2009 21:55:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901112154410.3586@pacific.mpi-cbg.de>
References: <20081030132623.GC24098@artemis.corp> <1225445204-28000-1-git-send-email-madcoder@debian.org> <7viqr5wgl7.fsf@gitster.siamese.dyndns.org> <20081103092729.GE13930@artemis.corp> <20081103151826.GJ13930@artemis.corp> <76718490901091129q534ca981iac54e0653d76170d@mail.gmail.com>
 <20090111111800.GA8032@artemis.corp> <alpine.DEB.1.00.0901111433580.3586@pacific.mpi-cbg.de> <20090111142732.GA18484@artemis.corp> <7vab9xsgzf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	pasky@suse.cz, srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:56:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM7Lo-0003IE-4B
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbZAKUyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbZAKUyl
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:54:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:52759 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751602AbZAKUyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:54:40 -0500
Received: (qmail invoked by alias); 11 Jan 2009 20:54:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 11 Jan 2009 21:54:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+KA0Ms22aK20ZsuUIPSg0QX4HbWiwf/pnF7duTAC
	V6HehLwtu+FrGf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vab9xsgzf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105227>

Hi,

On Sun, 11 Jan 2009, Junio C Hamano wrote:

> Pierre Habouzit <madcoder@debian.org> writes:
> 
> > On Sun, Jan 11, 2009 at 01:35:15PM +0000, Johannes Schindelin wrote:
> > ...
> >> And I suggested to merge the tests with Sverre's patch.  That 
> >> suggestion also went unaddressed.
> >
> > I can't find any mails from Sverre in the same thread, but maybe I'm 
> > not searching in the proper place...
> 
> This is in 'master' already; if there was anything missing in your 
> patch, please fill in with updates.

I _think_ that I asked for test cases to use that workflow, so that we can 
be sure that what's in the man page actually works.

Ciao,
Dscho
