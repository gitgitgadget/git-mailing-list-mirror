From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Tue, 25 Sep 2012 08:17:15 +0200
Message-ID: <vpq8vbywrro.fsf@grenoble-inp.fr>
References: <201107252233.02088.jnareb@gmail.com>
	<201109031738.11678.jnareb@gmail.com>
	<CAMP44s2ZSKx3jDZOSX7EM2bYtuUvvEctZYw6R3wNWQEbCeX4Rw@mail.gmail.com>
	<201109141939.14070.jnareb@gmail.com>
	<CAMP44s31xx5qfF4-f3kGsa1uEe7TMVmqSDvB9zL=prR12xwM6g@mail.gmail.com>
	<CANQwDwfVM+besf2if-z6UT6K1QYfj7A7jXsEgfyfxJ1Ww9oBdA@mail.gmail.com>
	<vpqobkvxwhq.fsf@grenoble-inp.fr>
	<CANQwDwe1H3Va5T7uy6zUJ0oz_mk0=fW8hK_buky4x4hMThY9UQ@mail.gmail.com>
	<vpqobkvwg1r.fsf@grenoble-inp.fr>
	<CANQwDwew-PGq03q4VyjbzqPJxM+cB2O4J810ft67Cqn0xVwFKQ@mail.gmail.com>
	<vpqhaqnw6xc.fsf@grenoble-inp.fr>
	<CANQwDweRf1_UzRozSeRoF4p-Qh-tJq+mLYJq0GSL7dW8_umpSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 08:18:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGOT4-0000IC-0w
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 08:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab2IYGRw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2012 02:17:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39236 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827Ab2IYGRv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 02:17:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8P6CAUl001453
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 25 Sep 2012 08:12:12 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TGOSK-0006MN-3k; Tue, 25 Sep 2012 08:17:16 +0200
In-Reply-To: <CANQwDweRf1_UzRozSeRoF4p-Qh-tJq+mLYJq0GSL7dW8_umpSg@mail.gmail.com>
	("Jakub \=\?utf-8\?Q\?Nar\=C4\=99bski\=22's\?\= message of "Mon, 24 Sep 2012
 21:43:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 25 Sep 2012 08:12:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8P6CAUl001453
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1349158335.75906@wbC+Qq2uCPNxnpzK+Y2G7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206348>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Second, the situation is more complicated: one can be actively involv=
ed
> in 1 distributed project with 200+ contributors via Gerrit, often con=
tribute
> to 1 centralized project with 15-25 contributors, and rarely interact=
 with
> distributed project using "blessed" repository workflow where number
> of contributors range from few to few hundred.

We're doing a user survey, so if a project has 200 contributors, it wil=
l
statistically have 10 times more survey participants than a 20
contributors project. Sure, statistics don't always work, but if we
don't trust statistics, we shouldn't do a survey.

> Third, no other in matrix form.

Well, forcing the user to chose between existing options is not
necessarily bad IMHO. It at least avoids free-form answers like "I'm
doing almost exactly option b) but I don't call it this way so I didn't
tick b)".

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
