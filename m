From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git Wiki Move
Date: Thu, 14 Jan 2010 12:01:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001141157290.4985@pacific.mpi-cbg.de>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> <4B4EF1E0.3040808@eaglescrag.net> <alpine.DEB.1.00.1001141136450.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 11:56:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVNNE-00059K-84
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 11:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939Ab0ANK4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 05:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755821Ab0ANK4L
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 05:56:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:54376 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751431Ab0ANK4K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 05:56:10 -0500
Received: (qmail invoked by alias); 14 Jan 2010 10:56:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 14 Jan 2010 11:56:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Wr1h/x5JWH+3bBHWvkLWLHKRikGiD0Fvx88n9xe
	Ga0krR+61l/pUM
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.1001141136450.4985@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136985>

Hi,

On Thu, 14 Jan 2010, Johannes Schindelin wrote:

> I note that "<<<!-- ! TOC here -->(2)>>" could be converted to 
> "__TOC__", I believe.

Several more things: external links only take single brackets, the 
separator between URL and text is a space, not a pipe symbol, and you have 
to translate brackets in link texts to &#91; and &#93; respectively (see 
my test edits on your Wiki).

Likewise, <<BR>> in MoinMoin is <BR> in MediaWiki (the case actually does 
not matter).

Probably it would also be good to inform the author of the gitbot on #git 
of the change.  Was it 'pieter'?

Ciao,
Dscho
