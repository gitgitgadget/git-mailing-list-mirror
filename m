From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] Improve http proxy support
Date: Wed, 22 Feb 2012 17:43:25 +0100
Message-ID: <87fwe2x1hu.fsf@thomas.inf.ethz.ch>
References: <CAAUd640GaLz4TGs_Lz6KbSFK0VcEVxGfO6PpSCdhch+fYwVovw@mail.gmail.com>
	<vpqd397x8fc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, <git@vger.kernel.org>
To: Nelson =?utf-8?B?QmVuw610ZXogTGXDs24=?= <nbenitezl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 17:43:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0FHy-0004Mj-1d
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 17:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab2BVQna convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 11:43:30 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:41005 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029Ab2BVQn2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 11:43:28 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 22 Feb
 2012 17:43:23 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 22 Feb
 2012 17:43:25 +0100
In-Reply-To: <vpqd397x8fc.fsf@bauges.imag.fr> (Matthieu Moy's message of "Wed,
	22 Feb 2012 15:13:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191264>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Nelson Ben=C3=ADtez Le=C3=B3n <nbenitezl@gmail.com> writes:
>
>> Hi, my initial motivation for this patch was to add NTLM proxy
>> authentication [...]
>
> That sounds interesting, but please read Documentation/SubmittingPatc=
hes
> in Git's tree. The formatting of your email is wrong (giving more wor=
k
> for your maintainer) and you need to sign-off your patch to allow you=
r
> code to be legally included.

Judging from the message, it also conflates three changes into one
patch.  Don't do that.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
