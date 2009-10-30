From: Klaus Ethgen <Klaus@Ethgen.de>
Subject: Re: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 21:05:08 +0100
Message-ID: <20091030200508.GE10671@ikki.ethgen.de>
References: <20091029233458.GA32764@ikki.ethgen.de> <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org> <20091030165903.GA10671@ikki.ethgen.de> <20091030173838.GB18583@coredump.intra.peff.net> <20091030182331.GC10671@ikki.ethgen.de> <20091030184155.GC19901@coredump.intra.peff.net> <20091030190552.GA3528@coredump.intra.peff.net> <7vvdhwk6dq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
Cc: Jeff King <peff@peff.net>, 553296@bugs.debian.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 21:05:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xiq-0006b9-7U
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 21:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbZJ3UFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 16:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbZJ3UFI
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 16:05:08 -0400
Received: from toomai.ethgen.de ([85.10.201.50]:56593 "EHLO toomai.ethgen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932313AbZJ3UFG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 16:05:06 -0400
Received: from home.ethgen.de ([94.247.217.2] helo=ikki.ket)
	by toomai.ethgen.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <klaus@ethgen.de>)
	id 1N3xif-00079r-8H; Fri, 30 Oct 2009 21:05:09 +0100
Received: from klaus by ikki.ket with local (Exim 4.69)
	(envelope-from <klaus@ikki.ethgen.de>)
	id 1N3xie-0004W8-Mz; Fri, 30 Oct 2009 21:05:08 +0100
Content-Disposition: inline
In-Reply-To: <7vvdhwk6dq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131744>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Junio,

Am Fr den 30. Okt 2009 um 20:51 schrieb Junio C Hamano:
> I am not sure; my head spins when I see "tracked but ignored" (you have
> a new one in the test) which is quite a bogus concept.
> 
> Does it mean "tracked but would be ignored if it weren't---perhaps it was
> added by mistake?"?

Right. Exact. Sorry if my arguing was a bit misunderstandable. (My
spellchecker do not know "misunderstandable", so I hope it is ok; I am
from Germany, we like long words. ;-)

Regards
   Klaus
- -- 
Klaus Ethgen                            http://www.ethgen.de/
pub  2048R/D1A4EDE5 2000-02-26 Klaus Ethgen <Klaus@Ethgen.de>
Fingerprint: D7 67 71 C4 99 A6 D4 FE  EA 40 30 57 3C 88 26 2B
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQEVAwUBSutG9J+OKpjRpO3lAQqBCQf+MWXaVdCeD7bT/dTCEQ8WfVKwISR6qNCP
wttV5oHnMp/f1mDWqhwYc4OUeOcLtkcV6pNf4oCMLY5v6zuvnLDgGB/8XW3l6JgZ
Y7m0UoSRu0s5Hux+VX/+CLwJ1cylstkwx3yOxcZ5VSXAgDlRIrt7LpwCsh/7lMSO
n5KUHw3/RodTwomxXUSRTQqU+SQMOUJrUvYR1EE9zR0YQkDKYqhulhUH+uirLaBQ
0rfJB7sTRqFfv2kHMLzO8t+jfco39cOZWTxlE1QBN1+k7aTZIJD2d79atfY7NLo0
2kCfcJXRurQ2rSpjUAbDVBo8JvkclnEnVLZP+s5kuwzej0hy4D2ocg==
=sN6Y
-----END PGP SIGNATURE-----
