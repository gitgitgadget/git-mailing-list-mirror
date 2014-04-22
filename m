From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 22:22:56 +0200
Message-ID: <vpqlhux3yhr.fsf@anie.imag.fr>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
	<53557071.5040500@gmail.com>
	<xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
	<xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
	<5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 22:23:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WchEU-0004cM-SE
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 22:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757987AbaDVUXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 16:23:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50693 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757982AbaDVUXI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 16:23:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3MKMuoa022507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Apr 2014 22:22:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3MKMvd4013766;
	Tue, 22 Apr 2014 22:22:57 +0200
In-Reply-To: <5356c1a61f6d8_463e11ef310a5@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 22 Apr 2014 14:23:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 22 Apr 2014 22:22:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3MKMuoa022507
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1398802980.09126@TjOMQZcZJfMkpBwi0ML1Ig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246782>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Why is not material for v2.0? Because you say so? Are you going to wait another
> ten years to introduce this to v3.0?

There's no need to wait for a 3.0 to introduce this. If these would
be low-priority compared to user-defined aliases, there's no backward
compatibility issue, it can very well be a 2.1, or whatever number comes
after 2.0.

> This is actually the perfect time to do it.

Junio has just tagged a -rc for 2.0, so it's clearly too late to start
discussing new features for this particular release.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
