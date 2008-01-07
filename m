From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 19:16:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801071915470.10101@racer.site>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de> <20080107101256.GA25047@coredump.intra.peff.net> <200801071947.28586.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-2036438225-1199733400=:10101"
Cc: Jeff King <peff@peff.net>, Steffen Prohaska <prohaska@zib.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 20:17:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBxTM-0003kq-E2
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 20:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024AbYAGTQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 14:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758009AbYAGTQw
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 14:16:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:34861 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757899AbYAGTQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 14:16:51 -0500
Received: (qmail invoked by alias); 07 Jan 2008 19:16:48 -0000
Received: from host86-149-202-249.range86-149.btcentralplus.com (EHLO [192.168.1.3]) [86.149.202.249]
  by mail.gmx.net (mp047) with SMTP; 07 Jan 2008 20:16:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ykL06/1py6MFjYFEw98XgrThUMI22l0UPZWJPfT
	+OWTAb2Kuej93h
X-X-Sender: gene099@racer.site
In-Reply-To: <200801071947.28586.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69800>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-2036438225-1199733400=:10101
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 7 Jan 2008, Robin Rosenberg wrote:

> måndagen den 7 januari 2008 skrev Jeff King:
> > On Mon, Jan 07, 2008 at 10:57:52AM +0100, Steffen Prohaska wrote:
> > 
> > I don't know if there are other options that might impact how clone 
> > works, but something like the patch below might make sense. It would 
> > allow:
> > 
> >   git clone -c core.autocrlf=true ...
> 
> You can also set the option globally. Maybe something for the installer 
> or a first time wizard.

We thought about that, too.

> But I do think git should have this option set right from the beginning.

Problem.  There is not a single "right".  It really depends on the 
project.

Ciao,
Dscho

---1463811741-2036438225-1199733400=:10101--
