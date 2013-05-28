From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: fix french translation
Date: Tue, 28 May 2013 09:35:47 +0200
Message-ID: <vpq38t7v9nw.fsf@anie.imag.fr>
References: <CAHtLG6ToiRT-EQMFhrR976=gat+8p0GFFyz+9qpqaq36=gVyGQ@mail.gmail.com>
	<CALWbr2w+ooM04nc79XKyVy48c_eH1AES5XgVDwwk+tFpmitLTw@mail.gmail.com>
	<CAHtLG6SfTi9XiqGDFhjR0DzLwSK0qVm0GL9-7boHEo=d2uCmvA@mail.gmail.com>
	<CALWbr2xU58Ymq3xzAdomi_ND==ByHFfCNuZvEPDcsEcozRgoTg@mail.gmail.com>
	<vpqmwrg23sx.fsf@anie.imag.fr>
	<CAHtLG6Q-OWKJZVcFateFjgJ4TfovEWrfph9dyuiGi+ophBVh0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 09:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhERr-0004jP-H4
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 09:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933189Ab3E1Hfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 May 2013 03:35:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56563 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932984Ab3E1Hfz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 03:35:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4S7Zleq009500
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 28 May 2013 09:35:47 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UhERg-0008FK-BP; Tue, 28 May 2013 09:35:48 +0200
In-Reply-To: <CAHtLG6Q-OWKJZVcFateFjgJ4TfovEWrfph9dyuiGi+ophBVh0Q@mail.gmail.com>
	(=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Tue, 28 May 2013 07:57:48
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 28 May 2013 09:35:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4S7Zleq009500
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1370331351.83354@P9og/g3O8Zp5GSEBq2uh1Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225619>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> Sorry, I reversed the revisions. This one should be correct.

Yes, it is. But your patch is still not in the form expected by
Documentation/SubmittingPatches (missing sign-off-by, and incorrect
commit message).

The good news is: this is already fixed in git-gui's repo, it will land
in git.git next time Junio pulls from it:

http://repo.or.cz/w/git-gui.git/commitdiff/ab571ef02f5fc0d08bf2dce4e455=
d324e40fb220

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
