From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Patch] Documentation: enhanced "git for CVS users" doc about
 shared repositories
Date: Tue, 6 Nov 2007 10:53:24 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711061052570.4362@racer.site>
References: <472F99F8.4010904@gmail.com> <7v8x5cmern.fsf@gitster.siamese.dyndns.org>
 <47303C2E.2070103@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Francesco Pretto <ceztkoml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 11:54:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpM4p-0006dt-Ve
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 11:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbXKFKyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 05:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755980AbXKFKyS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 05:54:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:34845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755827AbXKFKyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 05:54:18 -0500
Received: (qmail invoked by alias); 06 Nov 2007 10:54:16 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp003) with SMTP; 06 Nov 2007 11:54:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hRSJol5NhhccaXitMNMKKMRCDXSPB90tiGNwBLT
	mWxPM+1mHjTdCj
X-X-Sender: gene099@racer.site
In-Reply-To: <47303C2E.2070103@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63657>

Hi,

On Tue, 6 Nov 2007, Francesco Pretto wrote:

> Junio C Hamano ha scritto:
> >>  ------------------------------------------------
> >> -$ git clone foo.com:/pub/repo.git/ my-project
> >> +$ git clone foo.com:/pub/scm/repo.git/ my-project
> >>  $ cd my-project
> >>  ------------------------------------------------
> > 
> > This part seems an unnecessary change.
> > 
> 
> Ironically, that's the same configuration of git.kernel.org. And I think 
> is better to put immediately the project in a appropriate directory than 
> to move it later.

For most people, neither path is correct.  So I really don't see your 
point.

Ciao,
Dscho
