From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mtimes of working files
Date: Wed, 11 Jul 2007 19:42:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707111940080.4516@racer.site>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com> 
 <Pine.LNX.4.64.0707111902040.4516@racer.site>
 <f36b08ee0707111136t198cf559vc85c561decf9707f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 20:42:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8h8i-0006Bp-Ae
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 20:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbXGKSmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755023AbXGKSmN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 14:42:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:39222 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754977AbXGKSmM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 14:42:12 -0400
Received: (qmail invoked by alias); 11 Jul 2007 18:42:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 11 Jul 2007 20:42:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+kS9vfiw+aVNlN7Amr0v6DzLVohK+7RclZTcKOY
	4jjiopKiRz82ke
X-X-Sender: gene099@racer.site
In-Reply-To: <f36b08ee0707111136t198cf559vc85c561decf9707f@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52186>

Hi list,

> > > How difficult is it to have script (or maybe existing git option) 
> > > that would make mtimes of all working files equal to time of last 
> > > commit ?

Now I slowly get really curious.  Does _anybody_ know a scenario where 
this makes sense?

(No, Eric, there are enough corner cases where your example of a clustered 
webserver breaks down, so I am not fully convinced that this is a useful 
case.)

Anybody enlighten me?

Ciao,
Dscho
