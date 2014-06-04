From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Jun 2014, #01; Tue, 3)
Date: Wed, 04 Jun 2014 23:00:30 +0200
Message-ID: <538F88EE.5070102@web.de>
References: <xmqqzjhtvdua.fsf@gitster.dls.corp.google.com>	<538F7050.3040103@web.de> <xmqqwqcwtn5u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 23:00:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsIId-0004UM-MG
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 23:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbaFDVAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 17:00:39 -0400
Received: from mout.web.de ([212.227.15.3]:62205 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbaFDVAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 17:00:38 -0400
Received: from [192.168.178.41] ([79.193.71.10]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MXpZD-1XLIKm199j-00WpXq; Wed, 04 Jun 2014 23:00:31
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqwqcwtn5u.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:Ug/ZcqH8kd45KfkmzkvIIH832MussEZVJQCvMutteDcfKHR6Oft
 5skD3TXBGiKIoQzyMa2Xe2+/0s72Rqi6Oqg6zpjwPuRpMRNNxJwx2eKRL2kXrzaquCspbfY
 kbJYWG6LH/kE8c66y/8PgsgUK0XDZ9mP4tbTwXy6zrjR1KqMoHxgbg4mrRmkH1/EjaMc+h4
 3z1fkUZ8Z5xPqs9IS7Z2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250780>

Am 04.06.2014 22:50, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 04.06.2014 00:16, schrieb Junio C Hamano:
>>> * jl/status-added-submodule-is-never-ignored (2014-04-07) 2 commits
>>>  - commit -m: commit staged submodules regardless of ignore config
>>>  - status/commit: show staged submodules regardless of ignore config
>>>
>>>  There also are a few patches Ronald Weiss and Jens are working on
>>>  polishing around this topic, and a patch from Jens each for gitk
>>>  and git-gui.
>>>
>>>  Waiting for the dust to settle until picking them up all.
>>
>> To me it looks like the dust settled enough around that part of the
>> topic and I remember consensus about that change. But it would be
>> nice to have the gitk and git-gui patches in at the same time.
> 
> Yes, what I meant was that after the dust settled, it may turn out
> that these two may need to be adjusted.  If these two commits can be
> used without any change as a base for any further development, that
> is good---shall I move it back to "Cooking" category?

I'm not aware of any necessary adjustments, so I'd appreciate if
they'd be moved back into "Cooking".
