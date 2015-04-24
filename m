From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Verbose as default for commit (optional)
Date: Fri, 24 Apr 2015 22:03:14 +0200
Message-ID: <vpqbnidmgzh.fsf@anie.imag.fr>
References: <20150424191809.GA18897@alvaca.santafe.altoros.com.ar>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eloy Espinaco <eloyesp@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 22:03:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yljou-0008I8-L2
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 22:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbbDXUDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 16:03:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39153 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933928AbbDXUDS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 16:03:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t3OK3CWI007363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Apr 2015 22:03:12 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3OK3EZ2015115;
	Fri, 24 Apr 2015 22:03:14 +0200
In-Reply-To: <20150424191809.GA18897@alvaca.santafe.altoros.com.ar> (Eloy
	Espinaco's message of "Fri, 24 Apr 2015 16:18:09 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 24 Apr 2015 22:03:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3OK3CWI007363
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1430510593.00906@D5fZdi+cyUKlRimFZ/TxWQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267752>

Eloy Espinaco <eloyesp@gmail.com> writes:

> Hi,
>
> It is my first mail to the list, so "hello world".

Hi, and welcome to the list.

> I wanted to make a feature-request about a config setting to make the
> commit always verbose. I'm not the only one asking for that, there is an
> old question in [Stack Overflow][1].

This seems a reasonable addition. In general, we commonly have config
options for commonly used CLI options.

> So I was thinking if it was possible to make a pull request for that, so
> I attach the patch. (I'm proud of it :) ).

Nice try, but the attached file is empty ;-). Actually, as much as
possible, avoid sending attachments but prefer inline patches.

You'll need a bit of reading to send a proper patch:

https://github.com/git/git/blob/master/Documentation/SubmittingPatches

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
