From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or
  configured
Date: Fri, 6 Mar 2009 11:24:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de>
References: <20090305221529.GA25871@pvv.org>  <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com>  <200903052322.02098.markus.heidelberg@web.de>  <200903052325.44648.markus.heidelberg@web.de>
 <fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: markus.heidelberg@web.de, Finn Arne Gangstad <finnag@pvv.org>,
	git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Andreas Ericsson <ae@op5.se>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 11:24:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfXEJ-0007Lx-Ai
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 11:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbZCFKXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 05:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbZCFKXF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 05:23:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:37624 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752033AbZCFKXD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 05:23:03 -0500
Received: (qmail invoked by alias); 06 Mar 2009 10:23:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 06 Mar 2009 11:23:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VTYRHM4LVjXkqCDi8lsaYt2BvIEDGkiSluEtS50
	bhQ/2frt/6sNp/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112415>

Hi,

On Thu, 5 Mar 2009, Sverre Rabbelier wrote:

> On Thu, Mar 5, 2009 at 23:25, Markus Heidelberg
> <markus.heidelberg@web.de> wrote:
> > Oh, I confused "config option" with "command line argument"...
> 
> Right, I'd like to be able to do:
> $ git config push.iamnotretarded true
> $ git push

LOL!  Sverre, you have a way to crack me up...

Snickering,
Dscho
