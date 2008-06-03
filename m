From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] describe match pattern for soft tags too
Date: Tue, 3 Jun 2008 21:24:23 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806032124040.13507@racer.site.net>
References: <alpine.LNX.1.10.0806031957360.3605@pollux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:26:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3d5O-0000U3-1h
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560AbYFCUZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 16:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756457AbYFCUZf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:25:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:59224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756044AbYFCUZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 16:25:33 -0400
Received: (qmail invoked by alias); 03 Jun 2008 20:25:31 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 03 Jun 2008 22:25:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198E0ErFsh8y5ytVNocmzjlsq19s+S8EWweyqjoPD
	GKUREaYcCLRenz
X-X-Sender: gene099@racer.site.net
In-Reply-To: <alpine.LNX.1.10.0806031957360.3605@pollux>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83701>

Hi,

On Tue, 3 Jun 2008, Michael Dressel wrote:

> So far git describe --match <pattern> would apply the <pattern> only
> to tag objects not to soft tags.

And I thought that was what --tags was for.

Ciao,
Dscho
