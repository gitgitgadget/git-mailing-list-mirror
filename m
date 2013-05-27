From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: fix french translation
Date: Mon, 27 May 2013 11:02:54 +0200
Message-ID: <vpqmwrg23sx.fsf@anie.imag.fr>
References: <CAHtLG6ToiRT-EQMFhrR976=gat+8p0GFFyz+9qpqaq36=gVyGQ@mail.gmail.com>
	<CALWbr2w+ooM04nc79XKyVy48c_eH1AES5XgVDwwk+tFpmitLTw@mail.gmail.com>
	<CAHtLG6SfTi9XiqGDFhjR0DzLwSK0qVm0GL9-7boHEo=d2uCmvA@mail.gmail.com>
	<CALWbr2xU58Ymq3xzAdomi_ND==ByHFfCNuZvEPDcsEcozRgoTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 11:03:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgtKa-0006oc-NO
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 11:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab3E0JC7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 May 2013 05:02:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59576 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab3E0JC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 05:02:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4R92r4F000989
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 27 May 2013 11:02:53 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UgtKQ-00021D-KN; Mon, 27 May 2013 11:02:54 +0200
In-Reply-To: <CALWbr2xU58Ymq3xzAdomi_ND==ByHFfCNuZvEPDcsEcozRgoTg@mail.gmail.com>
	(Antoine Pelisse's message of "Mon, 27 May 2013 08:32:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 27 May 2013 11:02:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4R92r4F000989
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1370250174.82974@atuDbmlbH9uXW+gkC8AaOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225581>

Antoine Pelisse <apelisse@gmail.com> writes:

>> -msgstr "Copie compl=E8te (plus lent, sauvegarde redondante)"
>> +msgstr "Copy compl=E8te (plus lent, sauvegarde redondante)"
>
> I still don't get why "Copie" is replaced by "Copy" ?

Yes, this is clearly wrong. Copie is french, Copy is not.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
