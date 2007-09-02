From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Mon, 03 Sep 2007 00:52:22 +0200
Message-ID: <87hcmcfzo9.fsf@morpheus.local>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 00:53:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRyJY-0008Ow-0u
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 00:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbXIBWwk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 18:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754792AbXIBWwk
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 18:52:40 -0400
Received: from main.gmane.org ([80.91.229.2]:39619 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754265AbXIBWwj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 18:52:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IRyIx-0004W9-FJ
	for git@vger.kernel.org; Mon, 03 Sep 2007 00:52:31 +0200
Received: from c83-253-22-183.bredband.comhem.se ([83.253.22.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 00:52:31 +0200
Received: from davidk by c83-253-22-183.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 00:52:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-183.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:AgjMpFdwoPPekHkTrat0I5+T1Lw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57398>

Junio C Hamano <gitster@pobox.com> writes:

> GIT v1.5.3 Release Notes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> Updates since v1.5.2
> --------------------
>
> * The commit walkers other than http are officially deprecated,
>   but still supported for now.

As I think I said before, this first bullet point makes no sense to
git users.  Only hardcore git developers know what a "commit walker
is", and what commit walkers exist (other than html, obviously).  How
will they know if they are using one of the things you just
deprecated?

--=20
David K=C3=A5gedal
