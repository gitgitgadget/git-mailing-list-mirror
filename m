From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: merge hook
Date: Fri, 10 Oct 2008 14:30:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810101429280.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081010072148.GB303@Mac2.local> <alpine.DEB.1.00.0810101204540.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081010102603.GC303@Mac2.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Erik Colson <eco@ecocode.net>
X-From: git-owner@vger.kernel.org Fri Oct 10 14:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoH2x-0000CG-MC
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 14:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbYJJMXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 08:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754598AbYJJMXc
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 08:23:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:39400 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754584AbYJJMXb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 08:23:31 -0400
Received: (qmail invoked by alias); 10 Oct 2008 12:23:28 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 10 Oct 2008 14:23:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189RjpbH/I9tlLbnf/FhvEOBLEXWGQlzOFXM7qV2U
	LLqgMOgcPycELR
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081010102603.GC303@Mac2.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97931>

Hi,

On Fri, 10 Oct 2008, Erik Colson wrote:

> On Fri, Oct 10, 2008 at 12:07:16PM +0200, Johannes Schindelin wrote:
> 
> > I guess that you want to disallow merging in changes from people who 
> > changed files that are none of their business?  If so, it would be 
> > nice to contribute the hook as a patch to contrib/.
> 
> wrong guess ;) The purpose is to check if source code still has debug 
> code in it. Our policy is to have it removed before reaching master, but 
> checking by hand is way too buggy ;)

Heh.  Still, if it is not too specific, would be nice to have it in 
contrib/.  So I can point other people to it ;-)

Ciao,
Dscho
