From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 11:42:04 +0200
Message-ID: <vpqpq4gi0b7.fsf@grenoble-inp.fr>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<alpine.DEB.1.00.1210171759230.3049@bonsai2>
	<CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com>
	<alpine.DEB.1.00.1210171936170.3049@bonsai2>
	<CAMP44s2=hhMz35SpYXMBLcQPfVaPxY4pBWZDF7zbqVwz=tbedA@mail.gmail.com>
	<CAGdFq_i4c=ei4ni5bv9nNEbCfNG4sbRkqyip2voW17GhkRAKPQ@mail.gmail.com>
	<CAMP44s2-BCuA5v7jE8S3d-Gg+DxKf6Yte9MvTDBDr4jEkLKZ9g@mail.gmail.com>
	<alpine.DEB.1.00.1210181031320.3049@bonsai2>
	<CAMP44s2wOX0-UrTM5t5ewZ4yhOJJU=+SfB9PoTQKdsP4Pzsnpg@mail.gmail.com>
	<7vbog0m8r0.fsf@alter.siamese.dyndns.org>
	<CAMP44s0yqBFWFyYx6VdNhq43U1u2S-OPrbKAyMWBGS1n=ffQMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 11:42:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOmcd-0006B3-Re
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 11:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab2JRJmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 05:42:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56759 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755044Ab2JRJmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 05:42:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q9I9YuPI010698
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 18 Oct 2012 11:34:56 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TOmc8-0008Dl-TV; Thu, 18 Oct 2012 11:42:04 +0200
In-Reply-To: <CAMP44s0yqBFWFyYx6VdNhq43U1u2S-OPrbKAyMWBGS1n=ffQMg@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 18 Oct 2012 11:38:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 18 Oct 2012 11:34:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q9I9YuPI010698
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1351157700.06523@qL7xNp62QAQS8i0jelhG/A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207989>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Basically what I already described:
> 1) You need a non-vanilla version of git
> 2) It's not easy to set up
> 3) It's not even clear which branch you should be using (in case you
> are not using msysgit)

I do not read that as "it does not work", but instead as "no one took
the time to push this code into git.git (although someone did in
msysgit)".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
