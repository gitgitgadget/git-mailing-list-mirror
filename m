From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix MSVC build on cygwin
Date: Thu, 8 Oct 2009 20:40:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910082040110.4985@pacific.mpi-cbg.de>
References: <4ACE0388.6070706@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, mstormo@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 08 20:46:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvy0V-0004As-AD
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 20:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933074AbZJHSiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 14:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932978AbZJHSiz
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 14:38:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:40945 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932924AbZJHSiy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 14:38:54 -0400
Received: (qmail invoked by alias); 08 Oct 2009 18:38:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 08 Oct 2009 20:38:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18F8uoH+jUFqr3/yZe1pG/LpxhXa0O5Xg4B7sYAfU
	ynshYhbXOvd+4J
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4ACE0388.6070706@ramsay1.demon.co.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129712>

Hi,

On Thu, 8 Oct 2009, Ramsay Jones wrote:

> Hi *,

I thought we only used shell patterns for filenames, and regexes for 
everything else?

Ciao,
Dscho
