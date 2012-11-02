From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Wishlist: git commit --no-edit
Date: Fri, 02 Nov 2012 10:42:24 +0100
Message-ID: <vpqfw4sgx33.fsf@grenoble-inp.fr>
References: <nntxt8ice9.fsf@stalhein.lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: nisse@lysator.liu.se (Niels =?iso-8859-1?Q?M=F6ller?=)
X-From: git-owner@vger.kernel.org Fri Nov 02 10:42:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUDm1-0005Ih-3i
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 10:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757026Ab2KBJmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2012 05:42:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50104 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099Ab2KBJma (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 05:42:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id qA29ZQgw016295
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2012 10:35:26 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TUDlh-0001CJ-6p; Fri, 02 Nov 2012 10:42:25 +0100
In-Reply-To: <nntxt8ice9.fsf@stalhein.lysator.liu.se> ("Niels
 \=\?iso-8859-1\?Q\?M\=F6ller\=22's\?\=
	message of "Fri, 02 Nov 2012 10:26:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 02 Nov 2012 10:35:26 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qA29ZQgw016295
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1352453726.95614@XRQKotMsTojb798g8CpKVw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208913>

nisse@lysator.liu.se (Niels M=F6ller) writes:

> I'd like to have a git commit option which is the opposite of --edit,=
 to
> use the selected commit message as is, without invoking any editor.
>
> Main use case I see would be
>
>   git commit --amend --no-edit

Err, isn't this already working? (maybe your version of Git is too old,
but my 1.7.9.5 does this at least)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
