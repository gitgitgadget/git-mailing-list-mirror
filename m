From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/10] test suite: Use 'say' to say something instead of
 'test_expect_success'
Date: Wed, 18 Mar 2009 23:07:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903182306020.10279@pacific.mpi-cbg.de>
References: <cover.1237410682.git.j6t@kdbg.org> <199f6a5e20f857a53af50872927a8086ce221345.1237410682.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:07:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3uj-0002Hh-2S
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbZCRWFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 18:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754892AbZCRWFM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 18:05:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:50527 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753966AbZCRWFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 18:05:10 -0400
Received: (qmail invoked by alias); 18 Mar 2009 22:05:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 18 Mar 2009 23:05:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dkE4TTlldFEFdna10asIExNt2t2ea0aXjMxVrXH
	Z6vgkIIXav+rmh
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <199f6a5e20f857a53af50872927a8086ce221345.1237410682.git.j6t@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113688>

Hi,

On Wed, 18 Mar 2009, Johannes Sixt wrote:

> Some tests report that some tests will be skipped.  They used
> 'test_exect_success' with a trivially successful test.  Nowadays we have

s/exect/expect/.

> the helper function 'say' for this purpose.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

I see that you exchanged one "say_color" by "say".  What is the 
difference?

Ciao,
Dscho
