From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 19:34:04 +0200
Message-ID: <vpq7gi1eupf.fsf@anie.imag.fr>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
	<20130609180437.GB810@sigill.intra.peff.net>
	<CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
	<20130609184553.GG810@sigill.intra.peff.net>
	<7vppvvnetw.fsf@alter.siamese.dyndns.org>
	<CAMP44s3p1atFz52-mKaKpZkLGp+Uoehc1ovTUQAN-raxWzWd8Q@mail.gmail.com>
	<7v8v2il62c.fsf@alter.siamese.dyndns.org>
	<CAMP44s1x4Dm2KwyuN=oisSFdoCPxYzu+ZjZjHN45_=i7b=z0_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 19:37:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um62D-0005Uw-Cc
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 19:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab3FJRhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 13:37:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36341 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182Ab3FJRhc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 13:37:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5AHY3mE029446
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 19:34:03 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Um5yn-00063W-8f; Mon, 10 Jun 2013 19:34:05 +0200
In-Reply-To: <CAMP44s1x4Dm2KwyuN=oisSFdoCPxYzu+ZjZjHN45_=i7b=z0_Q@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 10 Jun 2013 11:53:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 19:34:03 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227332>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It is not bad behavior. It is bad behavior *in your opinion*,

And in essentially everyone else on this list, it seems.

> an opinion that wouldn't be shared by other projects, like the Linux
> kernel.

Googling your name and LKML gives me this in the first page (addressed
to you):

https://lkml.org/lkml/2012/4/12/434
"I'm stupider for just reading your email. Go away."

https://lkml.org/lkml/2012/4/15/112
"I'll make one more try at explaining to you, but then I'll just set my
mail reader to ignore you, because judging by past performance (not
just in this thread) you will just continue to argue."

I don't follow the lkml so maybe I've just been unlucky and Google
didn't show me an accurate sample, but arguing that your behavior is
welcome on the LKML seems weird.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
