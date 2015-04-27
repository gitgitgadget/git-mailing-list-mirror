From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Update git-multimail to version 1.0.2
Date: Mon, 27 Apr 2015 20:54:22 +0200
Message-ID: <vpq618hqu5d.fsf@anie.imag.fr>
References: <1430133445-21488-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq618hxxya.fsf@gitster.dls.corp.google.com>
	<vpq383ltoxi.fsf@anie.imag.fr>
	<xmqqoam9whs0.fsf@gitster.dls.corp.google.com>
	<vpqh9s1s9by.fsf@anie.imag.fr>
	<xmqqk2wxwgv1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:54:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmoAz-00011J-T5
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 20:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbbD0Syh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 14:54:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50197 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964811AbbD0Syg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 14:54:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3RIsKj2004859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Apr 2015 20:54:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3RIsMAe007841;
	Mon, 27 Apr 2015 20:54:22 +0200
In-Reply-To: <xmqqk2wxwgv1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 27 Apr 2015 11:44:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 27 Apr 2015 20:54:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3RIsKj2004859
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1430765662.89695@vUzMUp0hXDuidHtj3F184Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267870>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Was that obtained from the upstream project (i.e. you) and match
>>> your 1.0.2 tag?
>>
>> Yes. Isn't that what the text above says?
>
> Well, the patch does not update git_multimail.py at all.  Requoting
> the part you omitted from my response
>
>     $ git rev-list -1 master contrib/hooks/multimail/
>     b513f71f6043c05c3918e670b332dfa7ec6b2661
>
>     which is b513f71f (git-multimail: update to version 1.0.0,
>     2014-04-07)
>
> it matches what "was obtained from the upstream project on
> 2014-04-07".

Yes, but it also matches "was obtained on 2015-04-27", since only the
README has changed (the commit message of this patch says: "The only
changes are to the README files, most notably the list of maintainers
and the project URL.").

> Or did you forget to include the update to the software in the
> patch?

The update to the software is empty.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
