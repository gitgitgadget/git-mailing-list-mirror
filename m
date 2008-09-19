From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GitTogether topics status
Date: Fri, 19 Sep 2008 12:11:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809191209550.13830@pacific.mpi-cbg.de.mpi-cbg.de>
References: <200809182207.21448.chriscool@tuxfamily.org>  <m363otmb8p.fsf@localhost.localdomain>  <200809190703.11969.chriscool@tuxfamily.org> <d411cc4a0809182303x365e2280r3fc8a9a3534d8890@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 12:07:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgctM-0002BA-Tm
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 12:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbYISKGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 06:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbYISKGE
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 06:06:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:49208 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750836AbYISKGC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 06:06:02 -0400
Received: (qmail invoked by alias); 19 Sep 2008 10:06:00 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 19 Sep 2008 12:06:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wEScEB/Uwyay4/QEfIyO+9LACuAuNA4qV/bWHWF
	a8m7Nsf0vaBsU0
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <d411cc4a0809182303x365e2280r3fc8a9a3534d8890@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96272>

Hi,

On Thu, 18 Sep 2008, Scott Chacon wrote:

> I very much want to see a library that provides basic Git object access 
> that we can use to write proper bindings in Ruby/Python/Perl.  If the 
> current Git code is too difficult to libify properly, then perhaps an 
> alternate C implementation that is built only for that purpose is 
> preferable to having a re-implementation in _every_ language.  Looking 
> forward to the discussion.

libgit-thin.  What is missing is somebody taking this forward (and this 
includes making it more public on the Git mailing list).

Hth,
Dscho
