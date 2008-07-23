From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did
 not change
Date: Wed, 23 Jul 2008 17:09:37 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807231708520.8986@racer>
References: <alpine.DEB.1.00.0807222235520.8986@racer>  <32541b130807221522r2a43c49cl6400f00dbe7451a0@mail.gmail.com>  <20080723120104.GQ2925@dpotapov.dyndns.org> <32541b130807230853y136f41bdmf221637e35d601c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:11:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLgvE-0005NS-9E
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbYGWQJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbYGWQJh
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:09:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:51850 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751615AbYGWQJg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:09:36 -0400
Received: (qmail invoked by alias); 23 Jul 2008 16:09:35 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp054) with SMTP; 23 Jul 2008 18:09:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19oF2wx6nVoq4pLLCfSAmp0JR4vzazBuhKhGemsnC
	1aMSvVhU5aePxT
X-X-Sender: gene099@racer
In-Reply-To: <32541b130807230853y136f41bdmf221637e35d601c3@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89697>

Hi,

On Wed, 23 Jul 2008, Avery Pennarun wrote:

> However, taking out the auto-commit wouldn't pain me too much if
> others want it that way.

IMO the -rc0 cycle is a particularly ill-chosen time to discuss behavior 
changes like this.

Hth,
Dscho
