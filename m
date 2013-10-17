From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] checkout: allow dwim for branch creation for "git checkout $branch --"
Date: Thu, 17 Oct 2013 13:13:07 +0200
Message-ID: <vpqr4bkqhfg.fsf@anie.imag.fr>
References: <1380113349-19838-1-git-send-email-Matthieu.Moy@imag.fr>
	<CACsJy8AbBrVSz=p+ARxvR_QXtku1BxbtQPv7pz_QCveeUEtwCQ@mail.gmail.com>
	<vpqob7huhyw.fsf@anie.imag.fr>
	<xmqq7gdc6gl8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, jc@sahnwaldt.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 13:13:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWlWO-0003KS-4L
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 13:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646Ab3JQLNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 07:13:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57886 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab3JQLN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 07:13:29 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r9HBD6h3008934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Oct 2013 13:13:06 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id r9HBD7KY032080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 17 Oct 2013 13:13:07 +0200
In-Reply-To: <xmqq7gdc6gl8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 16 Oct 2013 14:39:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 17 Oct 2013 13:13:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r9HBD6h3008934
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1382613191.1324@zWTo3mUX+F5fENlz2KggCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236292>

Junio C Hamano <gitster@pobox.com> writes:

> Did anything further happen to this discussion?  Is v3 the version
> with agreement among the list members I just should pick up?

v3
( http://thread.gmane.org/gmane.comp.version-control.git/235409/focus=235408 )
is the last version I sent, and I got no feedback on it, so I guess it's
ready for you to pick.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
