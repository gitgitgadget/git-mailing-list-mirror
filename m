From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Update git-multimail to version 1.0.2
Date: Mon, 27 Apr 2015 20:41:05 +0200
Message-ID: <vpqh9s1s9by.fsf@anie.imag.fr>
References: <1430133445-21488-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq618hxxya.fsf@gitster.dls.corp.google.com>
	<vpq383ltoxi.fsf@anie.imag.fr>
	<xmqqoam9whs0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:41:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymny3-0004yg-8T
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 20:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932973AbbD0SlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 14:41:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49938 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932949AbbD0SlO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 14:41:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3RIf3hN003615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Apr 2015 20:41:03 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3RIf5p6007660;
	Mon, 27 Apr 2015 20:41:05 +0200
In-Reply-To: <xmqqoam9whs0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 27 Apr 2015 11:25:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 27 Apr 2015 20:41:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3RIf3hN003615
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1430764864.32986@Z9cWunzvFyYzNn/YtMyGzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267868>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>> --- a/contrib/hooks/multimail/README.Git
>>>> +++ b/contrib/hooks/multimail/README.Git
>>>> @@ -3,13 +3,13 @@ section of the Git project as a convenience to Git users.
>>>>  git-multimail is developed as an independent project at the following
>>>>  website:
>>>>  
>>>> -    https://github.com/mhagger/git-multimail
>>>> +    https://github.com/git-multimail/git-multimail
>>>>  
>>>>  The version in this directory was obtained from the upstream project
>>>> -on 2014-04-07 and consists of the "git-multimail" subdirectory from
>>>> +on 2015-04-27 and consists of the "git-multimail" subdirectory from
>>>>  revision
>>>>  
>>>> -    1b32653bafc4f902535b9fc1cd9cae911325b870
>>>> +    8c3aaafa873bf10de8dddf1d202c449b3eff3b42 refs/tags/1.0.2
>>>
>>> Huh, really?
>>
>> What's the problem with this hunk? I just checked, and the tag is there,
>> with the right sha1.
>
> The patch is to apply to a file in my tree, so "The version in this
> directory" is "contrib/hooks/multimail/git_multimail.py" in my tree.
>
> Was that obtained from the upstream project (i.e. you) and match
> your 1.0.2 tag?

Yes. Isn't that what the text above says?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
