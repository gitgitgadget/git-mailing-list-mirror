From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: can't push to ransom ssh port ?
Date: Fri, 4 Jul 2008 14:32:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807041432060.9925@racer>
References: <912ec82a0807040628k14c8acd1ree9d82b68f69e080@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Neshama Parhoti <pneshama@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 15:35:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KElRo-0002jg-K3
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 15:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbYGDNej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 09:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbYGDNej
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 09:34:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:56308 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753581AbYGDNej (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 09:34:39 -0400
Received: (qmail invoked by alias); 04 Jul 2008 13:34:37 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp052) with SMTP; 04 Jul 2008 15:34:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180uwFxcLk0Q5RN9QSaL8kd8Hvkcv7QoOnh5ZxXxu
	6nZ6ZNctRghtWB
X-X-Sender: gene099@racer
In-Reply-To: <912ec82a0807040628k14c8acd1ree9d82b68f69e080@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87389>

Hi,

On Fri, 4 Jul 2008, Neshama Parhoti wrote:

> Doing the following:
> 
> git push myuser@myip:~/gitrepo
> 
> Connects to ssh port 22 on myip.
> 
> Is there a way to tell git to connect to a random port X ?

You could use a URL like "ssh://myuser@myip:X/home/myuser/gitrepo".

Hth,
Dscho
