From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: NYU Open Source Programming Class Releases JavaGit API 0.1.0 Alpha
Date: Tue, 5 Aug 2008 03:32:06 +0200
Message-ID: <59095A70-09C1-4898-976F-18C0C157B7EF@ai.rug.nl>
References: <5dfc0b810808040948x6cd1f29fhaf2bf85a09cfd404@mail.gmail.com> <20080804175403.GG27666@spearce.org> <alpine.DEB.1.00.0808050127510.9611@pacific.mpi-cbg.de.mpi-cbg.de> <20080805011051.GC32184@machine.or.cz> <20080805012007.GB32543@spearce.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James Linder <james.h.linder@gmail.com>,
	Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 03:34:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQBRH-0000D5-Po
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 03:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758517AbYHEBdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 21:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758470AbYHEBdN
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 21:33:13 -0400
Received: from frim.nl ([87.230.85.232]:43251 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758445AbYHEBdM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 21:33:12 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KQBPP-0002Or-0Y; Tue, 05 Aug 2008 03:33:07 +0200
In-Reply-To: <20080805012007.GB32543@spearce.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91400>


On 5 aug 2008, at 03:20, Shawn O. Pearce wrote:

> Someone recently ported git-blame into JGit, and it looks like they
> did a good job, but it was a straight C->Java port.  Since JGit
> is licensed under the BSD and builtin-blame.c is under the GPL we
> couldn't accept it as-is.  That side project produced a lot more
> results than anything else of late, but the GPL virual clause kicked
> in and prevented direct inclusion.

Have you asked the author of git-blame (Junio?) if he'd be willing to
relicence it to the JGit licences?

- Pieter
