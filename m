From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when appropriate to do so
Date: Wed, 14 Oct 2009 11:33:09 +0200
Message-ID: <200910141133.11386.trast@student.ethz.ch>
References: <0016e68fd0123a175304754694b4@google.com> <7vhbu2syi6.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910140108110.4985@pacific.mpi-cbg.de>
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
X-From: git-owner@vger.kernel.org Wed Oct 14 11:37:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My0IU-0003s4-07
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 11:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758064AbZJNJeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 05:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756847AbZJNJef
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 05:34:35 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54747 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756073AbZJNJee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 05:34:34 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 14 Oct
 2009 11:33:47 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 14 Oct
 2009 11:34:04 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0910140108110.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130275>

Johannes Schindelin wrote:
> 
> Let me tell you this from my experience: the least likely answer is "the 
> messages are too scary".  Invariably, the answer I get is "it is totally 
> unintuitive".  Often followed by "I tell Git to do something 
> straight-forward, and it refuses to do it."

<aside>

Actually I had a rather insightful discussion yesterday (spawned by
this exact thread) with someone here at the institute.  He said
something to the effect that git's problem is mostly that it is unlike
everything else.  You cannot explain git in simple metaphors like
files, copies and such.  Any attempt to do so will just fall short
really soon.

[On the other hand, some users appear unwilling to learn something new
because they "just want to version control this" or "just need to make
a commit to this project".]

</aside>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
