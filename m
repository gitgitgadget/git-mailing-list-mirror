From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] push: better error messages for detached HEAD and "no destination"
Date: Tue, 01 Mar 2011 00:00:19 +0100
Message-ID: <vpqwrkjepdo.fsf@bauges.imag.fr>
References: <1298927645-2716-1-git-send-email-Matthieu.Moy@imag.fr>
	<1298927645-2716-3-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTim7O4O2UUWzZOrZOWN1zp2iruLYf3+3WMFTi8_5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:00:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuC4v-0000xi-8I
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 00:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab1B1XA2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 18:00:28 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47984 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667Ab1B1XA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 18:00:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p1SN0Hwh011041
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Mar 2011 00:00:17 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PuC4i-0002B7-28; Tue, 01 Mar 2011 00:00:20 +0100
In-Reply-To: <AANLkTim7O4O2UUWzZOrZOWN1zp2iruLYf3+3WMFTi8_5@mail.gmail.com>
	(Jay Soffian's message of "Mon, 28 Feb 2011 17:48:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 01 Mar 2011 00:00:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1SN0Hwh011041
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1299538819.05065@/KnfXGE3HD5qHekmytzm2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168159>

Jay Soffian <jaysoffian@gmail.com> writes:

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Either specify the URL from t=
he command line or configure a remote repository using\n"
>
> Maybe "Either specify the URL explicitly or configure..."

I prefer "from the command-line" to "explicitely", because "explicitely=
"
could mean "in a configuration file", or so.

> Well, I just bikeshedded that 3 different colors, didn't I? You're we=
lcome. :-)

Thanks, I took the 2 other colors.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
