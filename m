From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Sep 2013, #02; Mon, 9)
Date: Sun, 22 Sep 2013 15:00:28 +0200
Message-ID: <523EE9EC.9040207@web.de>
References: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com> <522F486A.1000705@web.de> <xmqqhadfp1nx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 22 15:00:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNjHE-0002QK-4X
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 15:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab3IVNAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 09:00:35 -0400
Received: from mout.web.de ([212.227.17.11]:53732 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab3IVNAe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 09:00:34 -0400
Received: from [192.168.178.41] ([79.193.89.54]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Mg75d-1Va3SX2jVl-00NPi2 for <git@vger.kernel.org>;
 Sun, 22 Sep 2013 15:00:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqhadfp1nx.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:ymXvufaNoNYpJC9te4k0Nat253xPQiAYge1tqbEDDBAc5wN9/Ya
 afbD8WbgqN63Ztue2tOID1RRlz1Bt67DTFVrunO2KfZ3Nfvnw4dn9JgzR1AesJ8MdtqtB8g
 vWimDpXAFm5L55ogufKfzJC8IF3NnlPnf/icBzUoLBDimRy7HQEhB++1aR7XQ02n3TL2PLo
 OvdNeMYgDKBX/KM/hOjqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235165>

Am 21.09.2013 00:29, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 10.09.2013 00:53, schrieb Junio C Hamano:
>>> * bc/submodule-status-ignored (2013-09-04) 2 commits
>>>  - submodule: don't print status output with ignore=all
>>>  - submodule: fix confusing variable name
>>>
>>>  Originally merged to 'next' on 2013-08-22
>>>
>>>  Will merge to 'next'.
>>
>> I propose to cook this some time in next to give submodule
>> users who have configured ignore=all the opportunity to test
>> and comment on that. And as Matthieu noticed the documentation
>> is not terribly clear here, I'll prepare one or two patches to
>> fix that which should go in together with these changes.
> 
> The patches are still in 'next' but I think with the documentation
> update you and Matthieu did, it should be ready to be in 'master'
> now, no?

No objections from my side as nobody reported any problems during
the month that series cooked in next.
