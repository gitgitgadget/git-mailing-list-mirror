From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: tests for git-p4
Date: Sat, 12 Jul 2008 15:36:30 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807121536110.8950@racer>
References: <e48c5e540807120524rabdcfa6vd91c16ef1b0f80a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matt McClure <mlm@aya.yale.edu>
X-From: git-owner@vger.kernel.org Sat Jul 12 16:37:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHgE5-0002Dy-GB
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 16:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbYGLOgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 10:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbYGLOgb
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 10:36:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:42140 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753115AbYGLOga (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 10:36:30 -0400
Received: (qmail invoked by alias); 12 Jul 2008 14:36:28 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp029) with SMTP; 12 Jul 2008 16:36:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18sWBA+OzksBGNM5LpgkrzhlhLYtcDosUSh3KKlKL
	xq/MGMg3e8rbnB
X-X-Sender: gene099@racer
In-Reply-To: <e48c5e540807120524rabdcfa6vd91c16ef1b0f80a0@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88242>

Hi,

On Sat, 12 Jul 2008, Matt McClure wrote:

> Would my tests be of interest to git-p4's authors?  Is there any 
> existing test framework for git-p4 that I missed?

git$ git shortlog -e -s -n -- contrib/fast-import/git-p4* | head -n 5
   102  Simon Hausmann <simon@lst.de>
    50  Simon Hausmann <shausman@trolltech.com>
    31  Han-Wen Nienhuys <hanwen@google.com>
    13  Simon Hausmann <hausmann@kde.org>
     7  Marius Storm-Olsen <marius@trolltech.com>

Hth,
Dscho
