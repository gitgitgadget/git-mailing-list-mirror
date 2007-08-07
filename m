From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Tue, 07 Aug 2007 14:11:33 +0200
Message-ID: <87tzrbee8a.fsf@morpheus.local>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 14:11:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IINuk-0008F8-Cd
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 14:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801AbXHGMLu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 7 Aug 2007 08:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbXHGMLu
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 08:11:50 -0400
Received: from main.gmane.org ([80.91.229.2]:40553 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754198AbXHGMLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 08:11:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IINuY-0005VS-RY
	for git@vger.kernel.org; Tue, 07 Aug 2007 14:11:42 +0200
Received: from c83-253-22-183.bredband.comhem.se ([83.253.22.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 14:11:42 +0200
Received: from davidk by c83-253-22-183.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 14:11:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-183.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:Qd3b0VWQY7PN/EgWuqmGK2pl7Jc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55248>

Junio C Hamano <gitster@pobox.com> writes:

> GIT v1.5.3 Release Notes (draft)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> Updates since v1.5.2
> --------------------
>
> * The commit walkers other than http are officially deprecated,
>   but still supported for now.

This will not make sense to a lot of people.  I've been around here
since git was invented, and I think I can guess what it means, but I'm
not completely sure.  A "commit walker" is something that probably
only a few core git developers know what it is.

Please remember to give a second of thought to who will be reading
this.  It is very hard to determine from this short message who will
be affected, and in what way.

--=20
David K=C3=A5gedal
