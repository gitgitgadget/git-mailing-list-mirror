From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: NYU Open Source Programming Class Releases JavaGit API 0.1.0
	Alpha
Date: Mon, 4 Aug 2008 18:46:47 -0700
Message-ID: <20080805014647.GA383@spearce.org>
References: <5dfc0b810808040948x6cd1f29fhaf2bf85a09cfd404@mail.gmail.com> <20080804175403.GG27666@spearce.org> <alpine.DEB.1.00.0808050127510.9611@pacific.mpi-cbg.de.mpi-cbg.de> <20080805011051.GC32184@machine.or.cz> <20080805012007.GB32543@spearce.org> <59095A70-09C1-4898-976F-18C0C157B7EF@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James Linder <james.h.linder@gmail.com>,
	Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Aug 05 03:47:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQBeQ-0002nO-Br
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 03:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757815AbYHEBqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 21:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756246AbYHEBqt
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 21:46:49 -0400
Received: from george.spearce.org ([209.20.77.23]:42015 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415AbYHEBqs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 21:46:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id ECA5838419; Tue,  5 Aug 2008 01:46:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <59095A70-09C1-4898-976F-18C0C157B7EF@ai.rug.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91403>

Pieter de Bie <pdebie@ai.rug.nl> wrote:
> On 5 aug 2008, at 03:20, Shawn O. Pearce wrote:
>
>> Someone recently ported git-blame into JGit, and it looks like they
>> did a good job, but it was a straight C->Java port.  Since JGit
>> is licensed under the BSD and builtin-blame.c is under the GPL we
>> couldn't accept it as-is.  That side project produced a lot more
>> results than anything else of late, but the GPL virual clause kicked
>> in and prevented direct inclusion.
>
> Have you asked the author of git-blame (Junio?) if he'd be willing to
> relicence it to the JGit licences?

We started talking about it off-list actually.  I haven't heard
back from Junio yet but I think he was hinting that he is open to
the idea.

-- 
Shawn.
