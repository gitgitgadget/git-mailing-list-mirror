From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] bisect: revise manpage
Date: Fri, 26 Jun 2015 18:30:19 +0200
Message-ID: <vpqh9putotg.fsf@anie.imag.fr>
References: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>
	<CAP8UFD1GwH1ewapraL6cms04OVk8wHdtv+TJ7=HKL0_CLGjK-g@mail.gmail.com>
	<vpqmvzmwrng.fsf@anie.imag.fr>
	<CAP8UFD3y3gBp6bdLHus4TNo3LSwWLLOOWgzRR+6Yqh-rg4ASRg@mail.gmail.com>
	<558D68A7.6010608@alum.mit.edu>
	<CAP8UFD1_qDhT5kE+Kk_8BCyPH_dL=zR-X8sdhsQoHE5nW8BUGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 18:30:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8WWS-0003o8-Qr
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 18:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbbFZQac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 12:30:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54620 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906AbbFZQab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 12:30:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QGUHqQ021724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 18:30:17 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QGUJxk013263;
	Fri, 26 Jun 2015 18:30:19 +0200
In-Reply-To: <CAP8UFD1_qDhT5kE+Kk_8BCyPH_dL=zR-X8sdhsQoHE5nW8BUGw@mail.gmail.com>
	(Christian Couder's message of "Fri, 26 Jun 2015 17:28:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Jun 2015 18:30:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5QGUHqQ021724
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435941020.44993@OB1GJ8CLK+Ag45EeYI0/eQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272788>

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jun 26, 2015 at 4:58 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
>> The reference `refs/bisect/bad` will be left pointing at that commit.
>
> Yeah ok.

I took this one.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
