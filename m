From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [DRAFT] Branching and merging with git
Date: Mon, 08 Jan 2007 14:04:44 +0100
Message-ID: <87d55pr7o3.fsf@morpheus.local>
References: <20061116221701.4499.qmail@science.horizon.com> <20070103170411.GB5491@thunk.org> <20070107234411.GD18009@fieldses.org> <7vzm8uz7pz.fsf@assigned-by-dhcp.cox.net> <20070108023511.GI18009@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Jan 08 14:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3uBs-0006Cy-Bv
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 14:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbXAHNFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 8 Jan 2007 08:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbXAHNFZ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 08:05:25 -0500
Received: from main.gmane.org ([80.91.229.2]:53691 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbXAHNFY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 08:05:24 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H3uBS-0006jG-Ow
	for git@vger.kernel.org; Mon, 08 Jan 2007 14:05:02 +0100
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 14:05:02 +0100
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 14:05:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:i8R7cBcmtVxmDfqF9HjxI4V8e8M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36251>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> OK, thanks for the vote of confidence....  My tentative organization
> (which I'm totally open to argument about) is:
>
> chapters 1 and 2: "Read-only" operations:

> Chapter 3: "Read-write" operations:

> Chapter 4 (unwritten): interactions with other VCS's

I think this should be considered more peripheral, since it is really
an independent piece, and nobody needs to read it to learn how git
works.  So I would probably move it to the end.

> Chapter 5 (unwritten): rewriting history

> Chapter 6 (unwritten): git internals


--=20
David K=C3=A5gedal
