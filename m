From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Displaying Current Git Aliases
Date: Thu, 25 Jun 2009 18:57:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906251857010.8908@intel-tinevez-2-302>
References: <c115fd3c0906250859q661d2319i463d6eea7e9dbe54@mail.gmail.com> <m33a9oxogk.fsf@localhost.localdomain> <86ljngxngu.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:57:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJsGH-0008II-EA
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 18:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbZFYQ5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 12:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbZFYQ5L
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 12:57:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:44798 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751926AbZFYQ5L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 12:57:11 -0400
Received: (qmail invoked by alias); 25 Jun 2009 16:57:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp004) with SMTP; 25 Jun 2009 18:57:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BkoRcZ21BCuryvyuSwO1uNdfIHhMgpnZampbCS9
	BYrU7FmYSalHpK
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <86ljngxngu.fsf@blue.stonehenge.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122222>

Hi,

On Thu, 25 Jun 2009, Randal L. Schwartz wrote:

> >>>>> "Jakub" == Jakub Narebski <jnareb@gmail.com> writes:
> 
> Jakub> Tim Visher <tim.visher@gmail.com> writes:
> >> Can git display a list of all of your current aliases like bash's
> >> `alias` command?
> 
> Jakub> In ~/.gitconfig:
> 
> Jakub>   [alias]
> Jakub>         alias = config --get-regexp ^alias\\.
> 
> But then it shows itself. :)

Which is correct.

Ciao,
Dscho
