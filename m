From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svnimport
Date: Thu, 25 Oct 2007 11:56:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710251132580.25221@racer.site>
References: <31e679430710250225w39a876d0w738d819245e514e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:57:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il0P4-0000uW-46
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823AbXJYK5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755023AbXJYK5Q
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:57:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:36375 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754525AbXJYK5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:57:15 -0400
Received: (qmail invoked by alias); 25 Oct 2007 10:57:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp016) with SMTP; 25 Oct 2007 12:57:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ptGA+vJLpKAY6K68cIgyy9AWIaOLkH0WSK3OWDg
	cSSn9p7B9Vk8b8
X-X-Sender: gene099@racer.site
In-Reply-To: <31e679430710250225w39a876d0w738d819245e514e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62308>

Hi,

On Thu, 25 Oct 2007, Felipe Balbi wrote:

> I was importing busybox svn repository to git but I got a connection 
> timeout after more than 19k commits... is there a way to continue where 
> the error happened or should I do it all over again ??

AFAICT git-svn is better suited, even to one-shot importing svn.

As it happens, I got interested in this project, too, and did an import 
some time ago.  For your pleasure, I uploaded it to

	http://repo.or.cz/w/busybox.git/

Hth,
Dscho
