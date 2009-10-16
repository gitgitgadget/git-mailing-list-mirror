From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when appropriate to do so
Date: Fri, 16 Oct 2009 14:07:13 +0200
Message-ID: <200910161407.14832.trast@student.ethz.ch>
References: <0016e68fd0123a175304754694b4@google.com> <200910141133.11386.trast@student.ethz.ch> <alpine.DEB.1.00.0910161346560.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Sixt <j.sixt@viscovery.net>, <Euguess@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>, <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 14:10:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyldH-0006RQ-TH
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 14:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbZJPMI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 08:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbZJPMI5
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 08:08:57 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:44033 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbZJPMI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 08:08:56 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 14:08:09 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 14:07:47 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0910161346560.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130482>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 14 Oct 2009, Thomas Rast wrote:
> 
> > [On the other hand, some users appear unwilling to learn something new 
> > because they "just want to version control this" or "just need to make a 
> > commit to this project".]
> 
> Frankly, if the choice is between "I just want to make a commit to this 
> project" and "Then I'll not use version control at all", I'd rather choose 
> the former.

Using your automatic gearbox analogy, I should point out that people
still spend significant amounts of time and money on learning how to
drive, despite the fact that learning the internals of the engine is
no longer required.

Yet for some reason, the same people want computers to read their
minds instead of learning how to operate (the more involved parts of)
it.

(Yeah, call me arrogant...)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
