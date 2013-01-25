From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git-core vs git package on ubuntu
Date: Fri, 25 Jan 2013 15:25:03 +0100
Message-ID: <vpq4ni5cpc0.fsf@grenoble-inp.fr>
References: <4A4C2896-042A-4BE3-9E74-012D881D5776@googlemail.com>
	<vpqham5cq7n.fsf@grenoble-inp.fr>
	<58A2D0C1-5E74-4449-9AC4-D2BDC494555C@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Mario Michael Krell <supermariton@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 15:26:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TykE6-00078F-2b
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 15:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202Ab3AYOZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 09:25:14 -0500
Received: from mx1.imag.fr ([129.88.30.5]:60701 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026Ab3AYOZM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 09:25:12 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0PEP24Q018817
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 Jan 2013 15:25:02 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TykDI-0003W6-0m; Fri, 25 Jan 2013 15:25:04 +0100
In-Reply-To: <58A2D0C1-5E74-4449-9AC4-D2BDC494555C@googlemail.com> (Mario
	Michael Krell's message of "Fri, 25 Jan 2013 15:15:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Jan 2013 15:25:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0PEP24Q018817
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359728707.70529@58gK7/zAborV6/QH37PwOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214554>

Cc-ing the Git list again.

Mario Michael Krell <supermariton@googlemail.com> writes:

> I am sorry for being so unspecific. I had problems finding your
> mentioned website and quickly went through the "getting started"
> tutorial and found the mentioned command at:
>
> http://git-scm.com/book/en/Getting-Started-Installing-Git

OK, this is the "pro Git" book. I just submitted a pull request:

  https://github.com/progit/progit/pull/358

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
