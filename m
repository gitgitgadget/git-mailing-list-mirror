From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Update git-multimail to version 1.0.2
Date: Mon, 27 Apr 2015 21:20:31 +0200
Message-ID: <vpqa8xtpedc.fsf@anie.imag.fr>
References: <1430133445-21488-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq618hxxya.fsf@gitster.dls.corp.google.com>
	<vpq383ltoxi.fsf@anie.imag.fr>
	<xmqqoam9whs0.fsf@gitster.dls.corp.google.com>
	<vpqh9s1s9by.fsf@anie.imag.fr>
	<xmqqk2wxwgv1.fsf@gitster.dls.corp.google.com>
	<vpq618hqu5d.fsf@anie.imag.fr>
	<xmqqfv7lwfvx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 21:21:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmoaI-0000xL-Du
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 21:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbbD0TUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 15:20:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50619 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964966AbbD0TUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 15:20:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3RJKTeq007655
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Apr 2015 21:20:29 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3RJKVJM008150;
	Mon, 27 Apr 2015 21:20:31 +0200
In-Reply-To: <xmqqfv7lwfvx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 27 Apr 2015 12:05:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 27 Apr 2015 21:20:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3RJKTeq007655
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1430767231.75129@YjBsnTHk+IaLbZxwvoAF8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267874>

Junio C Hamano <gitster@pobox.com> writes:

> Hmm, that may be technically correct but it is grossly misleading to
> update the existing "was obtained on 2014-04-07" to "was obtained on
> 2015-04-27", especially if nothing was actually obtained, isn't it?

That is because you're looking at the patch. The intended audience are
people reading the README.Git file, and the text reads just fine then.

> I honestly am surprised that, after seeing the announcement about "a
> new repository, co-maintainer and multiple contributors", no code
> change is made over the past 12 months.

That is the point indeed. Michael does not use git-multimail himself,
and does not find time to work on it. I'm joining the effort, but
currently have no time either. But eventually I'll go through the list
of pending pull-requests, and we'll actually get new code.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
