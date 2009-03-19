From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/10] test suite: Use 'say' to say something instead of
   'test_expect_success'
Date: Thu, 19 Mar 2009 11:29:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903191128120.10279@pacific.mpi-cbg.de>
References: <cover.1237410682.git.j6t@kdbg.org> <199f6a5e20f857a53af50872927a8086ce221345.1237410682.git.j6t@kdbg.org> <alpine.DEB.1.00.0903182306020.10279@pacific.mpi-cbg.de> <49C1F8D6.1060309@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 11:29:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkFVS-0000WL-Pm
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 11:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbZCSK1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 06:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbZCSK1P
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 06:27:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:46415 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751512AbZCSK1N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 06:27:13 -0400
Received: (qmail invoked by alias); 19 Mar 2009 10:27:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 19 Mar 2009 11:27:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NjE9wKqHNgCKWF6yeFLTjsvXuacKdLfbm+UF3P9
	hUWpKfViZlgvhR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49C1F8D6.1060309@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113748>

Hi,

On Thu, 19 Mar 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> 
> > I see that you exchanged one "say_color" by "say".  What is the 
> > difference?
> 
> The color. It's a change towards consistency. I figured that the command 
> to use by the tests is "say", while "say_color" is an implementation 
> detail of test-lib.sh.

Fair enough.  Could you say that in the commit message, too, so that 
morons like me do not have to ask? ;-)

Thanks,
Dscho
