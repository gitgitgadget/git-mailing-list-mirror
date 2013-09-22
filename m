From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Sep 2013, #02; Mon, 9)
Date: Sun, 22 Sep 2013 19:06:45 +0200
Message-ID: <vpqhadcg50a.fsf@anie.imag.fr>
References: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com>
	<522F486A.1000705@web.de>
	<xmqqhadfp1nx.fsf@gitster.dls.corp.google.com>
	<523EE9EC.9040207@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 22 19:07:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNn7m-0006pa-TT
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 19:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab3IVRHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 13:07:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43045 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382Ab3IVRHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 13:07:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8MH6hZY011278
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 22 Sep 2013 19:06:43 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VNn7N-0003o1-Jz; Sun, 22 Sep 2013 19:06:45 +0200
In-Reply-To: <523EE9EC.9040207@web.de> (Jens Lehmann's message of "Sun, 22 Sep
	2013 15:00:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 22 Sep 2013 19:06:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8MH6hZY011278
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380474407.17985@k9i4PS48eF89j1Awx8ckzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235168>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 21.09.2013 00:29, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> 
>>> Am 10.09.2013 00:53, schrieb Junio C Hamano:
>>>> * bc/submodule-status-ignored (2013-09-04) 2 commits
>>>>  - submodule: don't print status output with ignore=all
>>>>  - submodule: fix confusing variable name
>>>>
>>>>  Originally merged to 'next' on 2013-08-22
>>>>
>>>>  Will merge to 'next'.
>>>
>>> I propose to cook this some time in next to give submodule
>>> users who have configured ignore=all the opportunity to test
>>> and comment on that. And as Matthieu noticed the documentation
>>> is not terribly clear here, I'll prepare one or two patches to
>>> fix that which should go in together with these changes.
>> 
>> The patches are still in 'next' but I think with the documentation
>> update you and Matthieu did, it should be ready to be in 'master'
>> now, no?
>
> No objections from my side as nobody reported any problems during
> the month that series cooked in next.

No objection from me either. I'm not a user of the feature, so I can't
really tell how good it is.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
