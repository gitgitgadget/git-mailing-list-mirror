From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git push default behaviour?
Date: Fri, 09 Mar 2012 13:11:03 +0100
Message-ID: <vpq4ntyrn3c.fsf@bauges.imag.fr>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
	<1331203321.21444.13.camel@beez.lab.cmartin.tk>
	<4F58C977.8000400@xiplink.com> <vpq62efjeqd.fsf@bauges.imag.fr>
	<CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>
	<vpqfwdjas0m.fsf@bauges.imag.fr>
	<20120309033826.GA6164@sigill.intra.peff.net>
	<7vsjhi9wku.fsf@alter.siamese.dyndns.org>
	<vpqobs65gfc.fsf@bauges.imag.fr>
	<7vwr6u6qrn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 13:11:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5yfm-0002LN-0Q
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 13:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab2CIMLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 07:11:45 -0500
Received: from mx1.imag.fr ([129.88.30.5]:40814 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071Ab2CIMLp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 07:11:45 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q29C6rcW005306
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Mar 2012 13:06:53 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S5yf2-0006jY-HF; Fri, 09 Mar 2012 13:11:04 +0100
In-Reply-To: <7vwr6u6qrn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 09 Mar 2012 01:57:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 09 Mar 2012 13:06:54 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q29C6rcW005306
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1331899614.70507@nrTOgKc9gxBxt7O24a7qng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192714>

Junio C Hamano <gitster@pobox.com> writes:

> I can send a message saying "[...]" to the kernel list. Anybody could,
> for that matter.

That would have been something sensible to do a few years ago, but
today, I think we are far, far beyond the point where Git was a tool
meant primarily for kernel hackers. I don't think considering the kernel
community as more important than other users will help making Git easy
to use for bare mortals.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
