From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git in nutshell Inbox
Date: Tue, 09 Jul 2013 16:39:50 +0200
Message-ID: <vpq4nc3g5l5.fsf@anie.imag.fr>
References: <CABpATRsi-Akyv_d4xHsa0AdOdw4_P5VBpoWgx=ViWpA2Q0itPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Muhammad Bashir Al-Noimi <mbnoimi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 16:40:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwZ5L-0000Iz-HJ
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 16:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab3GIOkC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 10:40:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57082 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028Ab3GIOj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 10:39:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r69Edo9F030436
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 9 Jul 2013 16:39:52 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@imag.fr>)
	id 1UwZ54-0004Cp-N1; Tue, 09 Jul 2013 16:39:51 +0200
In-Reply-To: <CABpATRsi-Akyv_d4xHsa0AdOdw4_P5VBpoWgx=ViWpA2Q0itPw@mail.gmail.com>
	(Muhammad Bashir Al-Noimi's message of "Tue, 9 Jul 2013 16:28:34
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 09 Jul 2013 16:39:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r69Edo9F030436
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1373985594.78894@roMqccOn86JKf9CtcovpiA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229956>

Muhammad Bashir Al-Noimi <mbnoimi@gmail.com> writes:

> I'm bzr user and I want to migrate to git. Generally I use bzr through
> Bazaar Explorer which is very easy & neat GUI utility for managing bzr
> repositories. May you please guide me to most easy way to migrate to
> Git?

(I think it's a mistake to stick to GUI: the concepts are easier to
understand with Git commands IMHO")

But there are nice GUIs for Git too. The "official" one is git gui,
distributed with Git. I do not like the visual aspect a lot, but it has
a very good coverage of Git's functionalities. Otherwise, have a look at

  https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Graphical_Interfaces

git-cola is a good one.

> * I'm very comfortable with bzr (it has awesome GUI utility) but I
> decided to leave it because of its technical weakness by comparing to
> git.

Another reason to migrate is that bzr's developpement has stopped :-(.

> * Most git hosting I'm interesting in is gitorious.org because it's
> from open source family (that's what I read about) may you correct me
> if I'm wrong?

gitorious.org runs with free software (you can host a gitorious at home
if you want). github.com is probably the most popular hosting site, it
uses a lot of free software (and GitHub contributes a lot to free
software), but the complete solution is closed-source (you'll have to
pay if you want to run it at home, and won't be able to modify it).

There are tons of alternatives. See e.g.
https://git.wiki.kernel.org/index.php/GitHosting

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
