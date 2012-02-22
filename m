From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Improve http proxy support
Date: Wed, 22 Feb 2012 15:13:43 +0100
Message-ID: <vpqd397x8fc.fsf@bauges.imag.fr>
References: <CAAUd640GaLz4TGs_Lz6KbSFK0VcEVxGfO6PpSCdhch+fYwVovw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nelson =?iso-8859-1?Q?Ben=EDtez_Le=F3n?= <nbenitezl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 15:14:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0CxF-0002OM-Il
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 15:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab2BVONs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 09:13:48 -0500
Received: from mx2.imag.fr ([129.88.30.17]:46663 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746Ab2BVONr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 09:13:47 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q1ME9xE8012405
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 22 Feb 2012 15:09:59 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S0Cwy-0001Xn-A0; Wed, 22 Feb 2012 15:13:44 +0100
In-Reply-To: <CAAUd640GaLz4TGs_Lz6KbSFK0VcEVxGfO6PpSCdhch+fYwVovw@mail.gmail.com>
	("Nelson \=\?iso-8859-1\?Q\?Ben\=EDtez_Le\=F3n\=22's\?\= message of "Wed, 22 Feb
 2012 15:04:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 22 Feb 2012 15:09:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1ME9xE8012405
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1330524599.97109@J4O2kD4jtO2qBcFMMnTWLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191257>

Nelson Ben=EDtez Le=F3n <nbenitezl@gmail.com> writes:

> Hi, my initial motivation for this patch was to add NTLM proxy
> authentication [...]

That sounds interesting, but please read Documentation/SubmittingPatche=
s
in Git's tree. The formatting of your email is wrong (giving more work
for your maintainer) and you need to sign-off your patch to allow your
code to be legally included.

Thanks,

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
