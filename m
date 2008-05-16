From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What am I doing wrong?
Date: Fri, 16 May 2008 13:23:42 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161323240.30431@racer>
References: <482D6F41.2060809@laser-point.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, lists@glidos.net
To: Paul Gardiner <paul@laser-point.co.uk>
X-From: git-owner@vger.kernel.org Fri May 16 14:24:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwyz7-000427-5g
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 14:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929AbYEPMXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 08:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbYEPMXi
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 08:23:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:33659 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754486AbYEPMXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 08:23:38 -0400
Received: (qmail invoked by alias); 16 May 2008 12:23:36 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp029) with SMTP; 16 May 2008 14:23:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194kDghR0F4BKq2ZAcJLKOG+J+PO7VIh9Z8/gBQc1
	Nv3ISs4RtiU4Yc
X-X-Sender: gene099@racer
In-Reply-To: <482D6F41.2060809@laser-point.co.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82279>

Hi,

On Fri, 16 May 2008, Paul Gardiner wrote:

> I create the initial repository with
> 
>     git-clone /<full-path>/<name>.git/ <folder>
> 
> That works fine, but then I can't fetch. git-fetch gives the error
> "fatal: 'origin': unable to chdir or not a git archive"
> "fatal: The remote end hung up unexpectedly"

Did you chdir into <folder> before trying to fetch?

Ciao,
Dscho
