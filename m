From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 11:17:02 +0300
Message-ID: <87vdmuhs75.fsf@iki.fi>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
	<20090618001111.GB12954@vidovic>
	<7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:17:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCoe-00017L-4U
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbZFRIRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752429AbZFRIRd
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:17:33 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:48321 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbZFRIRc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:17:32 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 49F5976601EF58B4; Thu, 18 Jun 2009 11:17:27 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1MHCnu-0006Cd-4H; Thu, 18 Jun 2009 11:17:02 +0300
In-Reply-To: <alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
	(Johannes Schindelin's message of "Thu, 18 Jun 2009 10:06:07 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121809>

On 2009-06-18 10:06 (+0200), Johannes Schindelin wrote:

> I'd really rather stay with "fixup". And as I use single-letter
> commands quite often, I'd also rather stay away from that magic "!".
> And by "magic" I really mean that: people will not find that magic
> intuitive at all.

I don't know about people but I do find "!" intuitive. It is squash
after all so I like the idea of using small modifier character.

> My vote is for "fixup".

Mine is for "squash!".
