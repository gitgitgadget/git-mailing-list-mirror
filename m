From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Wed, 19 Aug 2009 00:38:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908190038110.8306@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <1250600335-8642-1-git-send-email-mstormo@gmail.com>  <7vtz05dq0p.fsf@alter.siamese.dyndns.org> <4A8AE7C5.7050600@gmail.com>  <4A8AED8B.9080604@gmail.com>  <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de>
 <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@storm-olsen.com>,
	Johan 't Hart <johanthart@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 00:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdXJM-0005gq-FK
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 00:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbZHRWhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 18:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbZHRWhk
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 18:37:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:51220 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750872AbZHRWhj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 18:37:39 -0400
Received: (qmail invoked by alias); 18 Aug 2009 22:37:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 19 Aug 2009 00:37:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DopFX7pCDIhwraP7J6ZKrlzs4Z1K53qpwFw+jmn
	j0PfR+Cof2vrHt
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126476>

Hi,

On Wed, 19 Aug 2009, Erik Faye-Lund wrote:

> On Tue, Aug 18, 2009 at 11:53 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> > debuggin, and Visual Studio's feature to move to the next/previous 
> > compile error.
> 
> Nope, you're still able to skip through the erros (with F4) as ususal. 
> I've been using a sed-script to translate gcc-style errors to msvc-style 
> errors for makefile projects before with great success. In this case, 
> the errors are already in msvc-style, so that part should really not be 
> any issue.

At this point you are just piling work-around on work-around.

Ciao,
Dscho
