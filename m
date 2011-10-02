From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Branches & directories
Date: Sun, 02 Oct 2011 21:09:36 +0200
Message-ID: <vpqehyvnrbj.fsf@bauges.imag.fr>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
	<CAE1pOi3OEFg7-OeQM0fvD69gf-5oPQ239CGy9nN0Waas8EM3Bg@mail.gmail.com>
	<CAMOZ1BvHKTPPmfB7Jx+y4OeRv-uwjmQkscXaRr-vEEy30G_Kdw@mail.gmail.com>
	<CAE1pOi0b2w8t53U7PSvVwVxZF9O0HTyfCR4vy+-baBjqCDeNJA@mail.gmail.com>
	<CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com>
	<CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com>
	<CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
	<CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
	<CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
	<CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
	<CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
	<CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
	<CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
	<4E889813.8070205@gmail.com> <87botznvua.fsf@an-dro.info.enstb.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Robin Rosenberg <robin.rosenberg@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ronan Keryell <Ronan.Keryell@hpc-project.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 21:10:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RARQV-0004Rl-PS
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 21:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab1JBTKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 15:10:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51646 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987Ab1JBTKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 15:10:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p92J7AtE009664
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 2 Oct 2011 21:07:10 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RARPs-0005I1-Tx; Sun, 02 Oct 2011 21:09:36 +0200
In-Reply-To: <87botznvua.fsf@an-dro.info.enstb.org> (Ronan Keryell's message
	of "Sun, 02 Oct 2011 19:31:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 02 Oct 2011 21:07:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p92J7AtE009664
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1318187233.71992@3UGj22F2POVjVytAK78a0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182608>

Ronan Keryell <Ronan.Keryell@hpc-project.com> writes:

>>>>>> On Sun, 02 Oct 2011 18:57:55 +0200, Robin Rosenberg <robin.rosenberg@gmail.com> said:
>
>     Robin> Hilco Wijbenga skrev 2011-08-22 22.10:
>     >> [...] I just wish there was at least an option to keep the
>     >> timestamp (and possibly other such things). Even Subversion can
>     >> do that... ;-) After all, not everybody uses C& make.

AFAIK, Subversion doesn't version timestamps. What it can do is to set
the timestamp to the commit date at the time the file is checked-out.

>     Robin> What tools do you use that need the benefits from retaining
>     Robin> timestamps?  The only one I can think of is clearmake, but
>     Robin> then that tool goes with another SCM. Eclipse, for example,
>     Robin> will be just as confused by timestamps that travel backwards
>     Robin> in time, as make is.
>
> I think of tools called "humans", very common indeed on Earth. :-)

For human beings, it's not really harder to run

  git log -1 file

than to look at the on-disk timestamp. And it continues working after
you start modifying the file, so it's much less fragile than the
filesystem timestamp.

But if you insist in reproducing SVN's "use-commit-times = yes" setting,
it should be doable with a post-checkout hook.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
