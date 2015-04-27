From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Update git-multimail to version 1.0.2
Date: Mon, 27 Apr 2015 20:18:49 +0200
Message-ID: <vpq383ltoxi.fsf@anie.imag.fr>
References: <1430133445-21488-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq618hxxya.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:19:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmncX-0001CB-E5
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 20:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932973AbbD0STA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 14:19:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49513 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932852AbbD0SS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 14:18:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3RIIlHZ001256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Apr 2015 20:18:48 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3RIInRo007387;
	Mon, 27 Apr 2015 20:18:49 +0200
In-Reply-To: <xmqq618hxxya.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 27 Apr 2015 10:50:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 27 Apr 2015 20:18:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3RIIlHZ001256
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1430763531.01176@gzDzqpYvhhOnX4tCDCRVjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267865>

Junio C Hamano <gitster@pobox.com> writes:

>> --- a/contrib/hooks/multimail/README.Git
>> +++ b/contrib/hooks/multimail/README.Git
>> @@ -3,13 +3,13 @@ section of the Git project as a convenience to Git users.
>>  git-multimail is developed as an independent project at the following
>>  website:
>>  
>> -    https://github.com/mhagger/git-multimail
>> +    https://github.com/git-multimail/git-multimail
>>  
>>  The version in this directory was obtained from the upstream project
>> -on 2014-04-07 and consists of the "git-multimail" subdirectory from
>> +on 2015-04-27 and consists of the "git-multimail" subdirectory from
>>  revision
>>  
>> -    1b32653bafc4f902535b9fc1cd9cae911325b870
>> +    8c3aaafa873bf10de8dddf1d202c449b3eff3b42 refs/tags/1.0.2
>
> Huh, really?

What's the problem with this hunk? I just checked, and the tag is there,
with the right sha1.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
