From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bash completion: Improve responsiveness of git-log
 completion
Date: Sun, 13 Jul 2008 15:55:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807131554040.4816@eeepc-johanness>
References: <20080713023742.GA31760@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 15:55:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI23S-0001g9-JE
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 15:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbYGMNzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 09:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753277AbYGMNzA
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 09:55:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:54811 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753271AbYGMNy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 09:54:59 -0400
Received: (qmail invoked by alias); 13 Jul 2008 13:54:57 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp065) with SMTP; 13 Jul 2008 15:54:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5zJl6hKP5gC+JwPJjYJKv4ip47zmIAqbaGrgU9x
	4m2SaIN2GIYplD
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080713023742.GA31760@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88313>

Hi,

On Sun, 13 Jul 2008, Shawn O. Pearce wrote:

>  Does this make things better?  Or worse?  I'm not seeing a huge
>  difference on my own system.  Maybe its too fast these days...

I see an incredible difference.  I do not have the means to measure at the 
moment, but it jumped from several seconds (which qualifies for a synonym 
to "eternity" in Git speak, as you know) to almost instantaneous.

Good job,
Dscho
