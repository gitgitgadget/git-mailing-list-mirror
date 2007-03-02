From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Memory overrun in http-push.c
Date: Fri, 2 Mar 2007 16:17:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703021617040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070228151516.GC57456@codelabs.ru> <200703011040.35971.andyparkins@gmail.com>
 <200702281541.41164.andyparkins@gmail.com> <20070301051323.GG57456@codelabs.ru>
 <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com>
 <7vslcpux62.fsf@assigned-by-dhcp.cox.net> <20070301120042.GD63606@codelabs.ru>
 <es9cnt$egh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 16:17:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN9Vf-00086i-ED
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 16:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965388AbXCBPRX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 10:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965366AbXCBPRX
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 10:17:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:51018 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965388AbXCBPRX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 10:17:23 -0500
Received: (qmail invoked by alias); 02 Mar 2007 15:17:21 -0000
X-Provags-ID: V01U2FsdGVkX1+3A5USlCS3Y1cY6bXFEPeingDlTVC2n251nt56B0
	crbBOK2Io3mgKS
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <es9cnt$egh$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41214>

Hi,

On Fri, 2 Mar 2007, Jakub Narebski wrote:

> Second, there were some work on git mailing list to create git command 
> which given a blob (or sha1 of a blob object) would list all commits (in 
> date order) which have this exact version of a file (of a blob).

It was shot down, and rightly so.

Ciao,
Dscho
