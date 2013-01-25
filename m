From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git-core vs git package on ubuntu
Date: Fri, 25 Jan 2013 15:06:04 +0100
Message-ID: <vpqham5cq7n.fsf@grenoble-inp.fr>
References: <4A4C2896-042A-4BE3-9E74-012D881D5776@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mario Michael Krell <supermariton@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 15:06:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyjvM-0006b7-01
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 15:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826Ab3AYOGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 09:06:10 -0500
Received: from mx2.imag.fr ([129.88.30.17]:41931 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754947Ab3AYOGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 09:06:09 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r0PE6274017694
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 Jan 2013 15:06:02 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Tyjuu-00032B-DN; Fri, 25 Jan 2013 15:06:04 +0100
In-Reply-To: <4A4C2896-042A-4BE3-9E74-012D881D5776@googlemail.com> (Mario
	Michael Krell's message of "Fri, 25 Jan 2013 14:50:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 Jan 2013 15:06:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0PE6274017694
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359727563.96991@LBzZcuWS44eh1wHG3V+9/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214552>

Mario Michael Krell <supermariton@googlemail.com> writes:

> Dear git developers,
>
> In your documentation you say,

Which documentation?

> that git should be installed on Unix using
>
> apt-get install git-core

A quick grep shows that this is not the case in the documentation
provided with Git, and it's not what I see on
http://git-scm.com/download/linux either.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
