From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [mingw port] git plumbing piping with CR/NL
Date: Sat, 2 Jun 2007 02:31:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706020229520.4046@racer.site>
References: <fcaeb9bf0706011123ue4ceaf2i12569c63d1d92584@mail.gmail.com> 
 <20070601231816.GC6360@steel.home> <fcaeb9bf0706011656p2145afe0k8be9797d250566df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 03:33:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuIUO-0006Gb-IX
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 03:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738AbXFBBdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 21:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757996AbXFBBdE
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 21:33:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:51555 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757738AbXFBBdC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 21:33:02 -0400
Received: (qmail invoked by alias); 02 Jun 2007 01:33:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 02 Jun 2007 03:33:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DxL1iG/CDiAvIN9M6fgXpdQAlnQHatJH/LUmBjB
	Rq4opkBvwE3grG
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0706011656p2145afe0k8be9797d250566df@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48905>

Hi,

On Fri, 1 Jun 2007, Nguyen Thai Ngoc Duy wrote:

> On 6/1/07, Alex Riesen <raa.lkml@gmail.com> wrote:
>
> > Why does your grep _alters_ the input, instead of filtering it, btw?
> 
> I have no idea. It's grep from MKS Toolkit FYI.

Your subject says "[mingw port]". You should have mentioned that you use a 
mixed setup, as the mingw port still depends on msys for the scripts.

Ciao,
Dscho
