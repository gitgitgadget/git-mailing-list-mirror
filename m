From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Patch] Using 'perl' in *.sh
Date: Mon, 10 Jul 2006 15:16:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607101514410.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200607081732.04273.michal.rokos@nextsoft.cz>
 <200607091441.16161.michal.rokos@nextsoft.cz> <7v4pxqfri7.fsf@assigned-by-dhcp.cox.net>
 <200607100741.26377.michal.rokos@nextsoft.cz> <86veq5sj22.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michal Rokos <michal.rokos@nextsoft.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 15:16:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzvcS-0002K3-CZ
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 15:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWGJNQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 09:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWGJNQJ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 09:16:09 -0400
Received: from mail.gmx.net ([213.165.64.21]:49891 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964886AbWGJNQI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 09:16:08 -0400
Received: (qmail invoked by alias); 10 Jul 2006 13:16:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 10 Jul 2006 15:16:06 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86veq5sj22.fsf@blue.stonehenge.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23620>

Hi,

On Mon, 10 Jul 2006, Randal L. Schwartz wrote:

> >>>>> "Michal" == Michal Rokos <michal.rokos@nextsoft.cz> writes:
> 
> Michal> I don't se the point. If you ask me, I'd say it should be either:
> Michal> - controlled fully via env: which means 'perl' in scripts and /usr/bin/env in 
> Michal> *.perl; or
> 
> which *pointlessly* doesn't work if *I* have installed a private Perl and a
> private git on a large shared systems, and *you* on the same system want to
> use my git installation, but not necessarily have my Perl in your path.

... so, git depends on perl. You know what that means...

Ciao,
Dscho
