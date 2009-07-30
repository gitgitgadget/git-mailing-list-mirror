From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Git for Windows 1.6.4
Date: Thu, 30 Jul 2009 02:21:39 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907300159250.8306@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de>  <46d6db660907291503o6979ef9fvbef5d25fa4318e37@mail.gmail.com>  <alpine.DEB.1.00.0907300018451.8306@pacific.mpi-cbg.de> <46d6db660907291550q62d4383au7e847d535058558d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 02:21:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJOq-0006b3-8Y
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 02:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbZG3AV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 20:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755360AbZG3AV2
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 20:21:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:33428 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754171AbZG3AV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 20:21:28 -0400
Received: (qmail invoked by alias); 30 Jul 2009 00:21:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 30 Jul 2009 02:21:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Jg3MgUv7JvxF+H7AraAau8YTn/noYpIbVnv5b+P
	H3ZhVWnCSk5sb9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <46d6db660907291550q62d4383au7e847d535058558d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124420>

Hi,

On Thu, 30 Jul 2009, Christian MICHON wrote:

> On Thu, Jul 30, 2009 at 12:20 AM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>
> > I will not guess, especially since I am dead tired after that hour it 
> > always takes to make a new release.
> 
> I believe we're both on CET :)

I guess I am really too tired, as I thought that I had tested, but 
obviously only tested the https-and-send-email installer.

But in the meantime, I found the issue, fixed and re-uploaded it.  FWIW 
the portable application was not affected, and funnily enough, the net 
installer works (although I wonder why).

Thanks for your report and help in diagnosing the problem.

Ciao,
Dscho
