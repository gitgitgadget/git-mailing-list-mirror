From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Review of git multimail
Date: Thu, 04 Jul 2013 10:11:49 +0200
Message-ID: <vpqvc4q68xm.fsf@anie.imag.fr>
References: <1372793019-12162-1-git-send-email-artagnon@gmail.com>
	<51D36BD8.1060909@alum.mit.edu>
	<CALkWK0=taYiV3UTaj9r-FLdaCeZRzVBTp_MH4sQt8-v+YYqbaA@mail.gmail.com>
	<87ppuzz6xr.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Thu Jul 04 10:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UueeB-0000N7-Ie
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 10:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933440Ab3GDIMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 04:12:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47271 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932202Ab3GDIMD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 04:12:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r648Bprq015691
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Jul 2013 10:11:51 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uuedp-0007rP-U7; Thu, 04 Jul 2013 10:11:50 +0200
In-Reply-To: <87ppuzz6xr.fsf@mcs.anl.gov> (Jed Brown's message of "Wed, 03 Jul
	2013 16:09:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 04 Jul 2013 10:11:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r648Bprq015691
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1373530313.73647@8Ua5xOsTFMlMyVtk2L7LWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229560>

Jed Brown <jed@59A2.org> writes:

> Note that RHEL5 has only python2.4 and will be supported through March,
> 2017.  Since it is not feasible to have code that works in both python3
> and any versions prior to python2.6, any chosen dialect will be broken
> by default on some major distributions that still have full vendor
> support.

At worse, if git-multimail is ported to Python 3, people using old
distros will still be able to use today's version which works in Python
2 and already does a good job.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
