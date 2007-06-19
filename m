From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] make dist: include configure script in tarball
Date: Tue, 19 Jun 2007 02:03:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706190203111.4059@racer.site>
References: <20070618213036.GA7222@moooo.ath.cx> <f578a4$6mm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 03:03:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0S8F-0000z9-BY
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 03:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764210AbXFSBDm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 21:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763135AbXFSBDm
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 21:03:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:44883 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761980AbXFSBDl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 21:03:41 -0400
Received: (qmail invoked by alias); 19 Jun 2007 01:03:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 19 Jun 2007 03:03:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lzAQYOyvlMBWqwpL5W15Fzy/g5dI3QsKWh0jF6L
	bVqMNMdT/pNLhU
X-X-Sender: gene099@racer.site
In-Reply-To: <f578a4$6mm$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50433>

Hi,

On Tue, 19 Jun 2007, Jakub Narebski wrote:

> Matthias Lederhofer wrote:
> 
> > +dist: git.spec git-archive configure
> 
> Ack. This way you don't need autoconf to ./configure install.

... but you force our good maintainer to have it installed...

Ciao,
Dscho
