From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug found (Re: git-fast-export SIGSEGV on solaris + backtrace)
Date: Thu, 3 Jul 2008 13:50:39 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807031350050.9925@racer>
References: <4869B91B.9000709@posdata.co.kr> <486C248E.4060205@gmail.com> <7vk5g32wve.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: namsh@posdata.co.kr, git@vger.kernel.org,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 15:07:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEOUl-0001lY-QY
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 15:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbYGCMwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbYGCMwf
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:52:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:39471 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752314AbYGCMwe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:52:34 -0400
Received: (qmail invoked by alias); 03 Jul 2008 12:52:33 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp019) with SMTP; 03 Jul 2008 14:52:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187y/p3ZJE7p8tf+xwXXYdVR2vUnb8Di1/dvWnDdF
	+9X8FoJqZOvAt4
X-X-Sender: gene099@racer
In-Reply-To: <7vk5g32wve.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87285>

Hi,

On Thu, 3 Jul 2008, Junio C Hamano wrote:

> What was I smoking when I applied df6a7ff (builtin-fast-export: Add 
> importing and exporting of revision marks, 2008-06-11), I have to 
> wonder...

FWIW I missed it in my review, too...  Well, Junio, it seems we should 
avoid smoking together for a while.

Ciao,
Dscho
