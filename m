From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: cmake, was Re: submodules' shortcomings
Date: Wed, 6 Jan 2010 00:06:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001060005010.4985@pacific.mpi-cbg.de>
References: <4B3F6742.6060402@web.de>  <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>  <4B421F90.4090402@web.de>  <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <3af572ac1001051238t63e07a25hf9dd77056b79be89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Wed Jan 06 00:01:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSIOn-0004o6-1G
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 00:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab0AEXBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 18:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754921Ab0AEXBH
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 18:01:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:56244 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755546Ab0AEXBF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 18:01:05 -0500
Received: (qmail invoked by alias); 05 Jan 2010 23:01:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp072) with SMTP; 06 Jan 2010 00:01:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PZIkeT3hPrA1lCpRmjkvb8N2xVmlOhLtcD56axy
	LUPdObhJdflOfz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3af572ac1001051238t63e07a25hf9dd77056b79be89@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136219>

Hi,

On Tue, 5 Jan 2010, Pau Garcia i Quiles wrote:

> For instance, I'd like to have a 'cmake' repository where I store all
> the FindBlah.cmake modules, so that I can share them from every
> repository, and not worry about users changing and committing in the
> main project instead of the submodule.

... which reminds me... it was you who wanted to provide a working recipe 
to compile and install CMake on msysGit, right?

What happened in the meantime?

Ciao,
Dscho
