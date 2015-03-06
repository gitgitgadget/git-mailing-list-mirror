From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] Disclaimer about the number of slots.
Date: Fri, 06 Mar 2015 12:47:30 +0100
Message-ID: <vpq4mpye4a5.fsf@anie.imag.fr>
References: <1425453571-8771-1-git-send-email-Matthieu.Moy@imag.fr>
	<1425453571-8771-2-git-send-email-Matthieu.Moy@imag.fr>
	<20150304075109.GC28502@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 06 12:47:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTqjQ-0003it-1P
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 12:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbbCFLrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 06:47:47 -0500
Received: from mx2.imag.fr ([129.88.30.17]:55581 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbbCFLrm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 06:47:42 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t26BlT0t022013
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Mar 2015 12:47:29 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t26BlUxf021246;
	Fri, 6 Mar 2015 12:47:30 +0100
In-Reply-To: <20150304075109.GC28502@peff.net> (Jeff King's message of "Wed, 4
	Mar 2015 02:51:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Mar 2015 12:47:29 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t26BlT0t022013
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426247251.1445@Ex4mjrnGhPGJBzFK9wxmzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264915>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 04, 2015 at 08:19:31AM +0100, Matthieu Moy wrote:
>
>> So, sending this in case other people think it's a good idea, but I
>> won't fight for it in case you don't think it is.
>> [...]
>> --- a/SoC-2015-Ideas.md
>> +++ b/SoC-2015-Ideas.md
>> @@ -20,6 +20,11 @@ Please, include link(s) to the mailing-list discussion(s) related to
>>  your microproject in your application (e.g. linking to
>>  [gmane](http://news.gmane.org/gmane.comp.version-control.git)).
>>  
>> +## Note about the number of slots
>> +
>> +In 2015, the Git organization has very limited mentoring capacity.
>> +We will probably be able to accept 2 students only this year.
>
> I'm on the fence.

OK, there's no clear consensus but no real objection either. I went
ahead and pushed my patches.

We can still reword or cancel my patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
