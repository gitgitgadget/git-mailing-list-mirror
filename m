From: David Kastrup <dak@gnu.org>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 09:39:33 +0200
Message-ID: <877g6fb2h6.fsf@fencepost.gnu.org>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
	<53557071.5040500@gmail.com>
	<xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
	<xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
	<5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
	<20140422213039.GB21043@thunk.org>
	<alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
	<53588713347b7_59ed83d308cf@nysa.notmuch>
	<CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
	<53588f448d817_59ed83d3084e@nysa.notmuch>
	<CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
	<5358bae8ab550_1f7b143d31037@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: James Denholm <nod.helm@gmail.com>, David Lang <david@lang.hm>,
	Theodore Ts'o <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 09:39:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdEG6-0002aT-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 09:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbaDXHjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 03:39:37 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:41231 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbaDXHjf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 03:39:35 -0400
Received: from localhost ([127.0.0.1]:40270 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WdEFq-0005TO-8J; Thu, 24 Apr 2014 03:39:34 -0400
Received: by lola (Postfix, from userid 1000)
	id C5064E0989; Thu, 24 Apr 2014 09:39:33 +0200 (CEST)
In-Reply-To: <5358bae8ab550_1f7b143d31037@nysa.notmuch> (Felipe Contreras's
	message of "Thu, 24 Apr 2014 02:19:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246945>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> James Denholm wrote:
>> Felipe Contreras wrote:
>> >This is a false dichotomy; there aren't just two kinds
>> > of Git users.
>> >
>> > There is such a category of Git users who are not
>> > fresh-out-of-the-boat, yet not power users either.
>> 
>> Oh, I didn't mean to suggest a dichotomy of any kind. However these are the
>> two groups (I suggest) are the most immediately relevant - one calls for
>> change, and the other would be negatively impacted.
>
> Nobody would be negatively impacted. Who would be impacted negatively
> by having default aliases?

The people having to read and understand scripts written in the
expectation of default aliases.

> And I have showed they are not problems.

You managed to convince yourself, so feel free to put aliases in every
Git you use and distribute.

-- 
David Kastrup
