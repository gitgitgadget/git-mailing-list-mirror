From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] don't append 'opaquelocktoken:' in PUT and MOVE
Date: Sat, 7 Feb 2009 19:57:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902071956480.10279@pacific.mpi-cbg.de>
References: <498DA4F9.20104@gmail.com>  <alpine.DEB.1.00.0902071801570.10279@pacific.mpi-cbg.de>  <be6fef0d0902070952l5818e4b7x3048c667661ce31@mail.gmail.com>  <alpine.DEB.1.00.0902071903020.10279@pacific.mpi-cbg.de>
 <be6fef0d0902071038y3e6de33es33a73ab6a068f9ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 19:58:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVsNZ-0001j9-I5
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 19:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbZBGS4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 13:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbZBGS4j
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 13:56:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:60847 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752827AbZBGS4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 13:56:39 -0500
Received: (qmail invoked by alias); 07 Feb 2009 18:56:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 07 Feb 2009 19:56:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19G7g4sSAhGesX+dvTMCM85a78C/Tg/ikEU3bCi3y
	rUa5HxLspDPlU8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <be6fef0d0902071038y3e6de33es33a73ab6a068f9ac@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108874>

Hi,

On Sun, 8 Feb 2009, Tay Ray Chuan wrote:

> On Sun, Feb 8, 2009 at 2:04 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Why does request->lock->token have the prefix at all?
> 
> While typing my reply, I realise it is unwarranted.

Huh?  What does that mean?  Does lock->token have that prefix (including 
the colon) or not?

Ciao,
Dscho
