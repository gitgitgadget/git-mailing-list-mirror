From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Mon, 23 May 2016 17:08:42 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605231700380.4449@virtualbox>
References: <nhlqd4$ekr$1@ger.gmane.org> <c07df4ac-08c9-8eaa-0233-06616945c857@web.de> <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com> <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de> <xmqqy474g3cv.fsf@gitster.mtv.corp.google.com> <xmqqfutcg0pe.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1605231310190.4122@virtualbox> <6e4862b8-b5ab-ced4-29a0-bf975848e98f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 17:08:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4rTR-0007xN-RE
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 17:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbcEWPIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 11:08:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:55739 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbcEWPIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 11:08:48 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ll0tl-1bf1Aa1vJF-00anE8; Mon, 23 May 2016 17:08:41
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <6e4862b8-b5ab-ced4-29a0-bf975848e98f@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ntpDZMJLela0dlPZmgr0I0hBYV2s/18S4diElOW95e9EIs2gg2h
 zgmSAHnIn8WaXdBv187hOeV7Tcoo8mPX27EEEQVP9P7saILau4+3Y8Xh62a2EChZ4ua8W2l
 OgrVfMdCUJVcdgCzhu0Ai94tjoJbhBmLUZtD1DyiCjf65A2WYc370dYQPPQa9asBgZ1s8/m
 j7oEdYEC89lQU4iBC0qeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8NUml0OAcXY=:HxyfOviECmWLOlSycUzz0J
 yasPfv4APzzR3AbntRO9pU1Mt+nXBQbTGw1E4OC16pf8I/TQo70GtBv/kZ5NVGXc0e4ufWo2G
 acOkU3eHXCKAMcnkW93iBMq14Pd0ljUGxTVFuSjuiBHmN+gNURuu7i7wiRb9vunfme7/dDrCe
 cSNJuPdIfIda/9H7LSCq9+4Gtj/KkliyEDR1jebkGAqxPoDiKFRlKPixSc+kIo/0l2fqZ3WJP
 OwHqekWS5DhDBW0EV71uSN+YxsOdvVGraG2OZ9ic82u6ITZdtZWgkcH9P/3eR0kdDBGkOOFYb
 hP78p89zKcDHw4fVvovgxtb9E6FYFDQUe7Apx1LsTsHO6ILJ4XecqaDZyLqkjqFjOaC6aqiqN
 ZbAOjNXOqQR5I/bA2eMu9hHfmI6++yKEmuM1jmwxqovxFBaYqKwQlQ1TY4JEzP6mDNJieqQFx
 +0BO0j/ij/pY5Jl7XE9NWDdoMqE7CeWHiAUk+QbKvMxuZqFBTUrZ3543tdmo0+hw/y60cbqBX
 1Y7gQBmaZ1dOMrjH3oauJLQCo5cN0FaZEXDhnSanmuRarzZCcJ1HBBcIAdg8NmtUF2uUAPpa4
 F0fzehBJEMCC1+RpdHiGJTFuDdn2pTY9id5kxbOQihkfWLXysWpL0BhGzcqXWA7I7ulJIzuCr
 AjGLpyVP678NuhAleG4F4qNqKo3QFKYAD4IclX9RIWk//NpDPUPRUHaMJ1CXJRPVb91JUjoDL
 RlXxEvx0sX4oh2nUrr8KBIfR0FXVxQY7fkQ1+t9oYpqdQoAyGHtLz1BTuYewx+5E6L94PKAk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295331>

Hi Jon,

On Mon, 23 May 2016, Jon Forrest wrote:

> On 5/23/2016 4:12 AM, Johannes Schindelin wrote:
> 
> > What we could do is to make the default config setting platform-dependent,
> > a la CRLF_NATIVE.
> >
> > I imagine that we would want this for core.filemode, core.ignorecase and
> > core.symlinks.
> >
> > What do you think?
> 
> Would this change have any bad effects when the same repo is shared
> by both Windows and *nix Git users over Dropbox or a shared filesystem?

Yes, if you have symbolic links in that repository. Likewise, if you have
users who find it funny to add different files whose names only differ in
their case, say, xt_DSCP.c and xt_dscp.c.

Also, if your Windows users want to add scripts, they will most likely not
mark them executable and your Linux users will call them names (forgetting
that they know just as little about the other platform as the developers
they try to ridicule).

Lots of fun things to keep in mind when sharing the same working directory
between Operating Systems.

But you said "when the same repo is shared"? Do you really mean the
*repository*? If so, there is not a problem. Only if you add a working
directory into the mix.

Ciao,
Johannes
