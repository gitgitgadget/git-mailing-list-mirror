From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH / RFC] cherry: cache commit to patch-id pairs to avoid
 repeating work
Date: Sun, 8 Jun 2008 17:06:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806081705410.1783@racer>
References: <7f9d599f0806071636j1df57b6eqb5808f083dafd6a2@mail.gmail.com> <7f9d599f0806072239je3a7ec0q258d7770c15fa962@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Sun Jun 08 18:08:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5NRX-0004zE-EI
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 18:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbYFHQHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 12:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756194AbYFHQHj
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 12:07:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:38480 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755075AbYFHQHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 12:07:38 -0400
Received: (qmail invoked by alias); 08 Jun 2008 16:07:36 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 08 Jun 2008 18:07:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xfEdjR7QxcDiXc6Ihsylp4km8WHlKde1wW9GZ9Y
	YfR/1+kmw9hskX
X-X-Sender: gene099@racer
In-Reply-To: <7f9d599f0806072239je3a7ec0q258d7770c15fa962@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84287>

Hi,

On Sat, 7 Jun 2008, Geoffrey Irving wrote:

> Is starting a new thread each time I update a patch the correct way to 
> do things?

I prefer a response in the existing thread, but I guess it is a matter of 
personal taste (of the poster).

Ciao,
Dscho
