From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] hg-to-git: add --verbose option
Date: Mon, 26 May 2008 22:47:47 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805262247020.30431@racer>
References: <alpine.DEB.1.00.0805261344420.30431@racer>  <200805261509.49841.johan@herland.net>  <alpine.DEB.1.00.0805261414140.30431@racer>  <bd6139dc0805260628l1b073f52i1f33bd0c707a4329@mail.gmail.com>  <7vlk1xc7aa.fsf@gitster.siamese.dyndns.org>
 <ee77f5c20805261429h14b1ce66tf9585132279c4f8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, sverre@rabbelier.nl,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Stelian Pop <stelian@popies.net>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 23:48:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0kYU-0004MD-W0
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 23:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbYEZVrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 17:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754591AbYEZVrm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 17:47:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:45068 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753169AbYEZVrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 17:47:41 -0400
Received: (qmail invoked by alias); 26 May 2008 21:47:40 -0000
Received: from R105f.r.pppool.de (EHLO racer.local) [89.54.16.95]
  by mail.gmx.net (mp052) with SMTP; 26 May 2008 23:47:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18m4qErCyUmnpHkM6Dizx1bjwhEj4V1hp+XN2I0LY
	+wlK9zCQES/aAl
X-X-Sender: gene099@racer
In-Reply-To: <ee77f5c20805261429h14b1ce66tf9585132279c4f8e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82963>

Hi,

On Tue, 27 May 2008, David Symonds wrote:

> On Tue, May 27, 2008 at 3:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> > I think I spotted a bug in Python documentation, by the way ;-)
> >
> > http://docs.python.org/ref/ref.html does not even list "True" and 
> > "False" in its section 2.4 (Literals) yet, and that document is for 
> > version 2.5.2.
> 
> That's because they aren't literals. They are, in fact, objects, and 
> redefinable objects at that.
> 
> Try:
> 
> True=False
> print True

Hey, I said that I had to code in Python until I do not hate it anymore!

You just made that task harder.

Thanks,
Dscho
