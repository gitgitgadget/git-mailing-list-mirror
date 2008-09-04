From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Are more and more patches getting lost lately?
Date: Thu, 04 Sep 2008 01:45:30 -0700
Message-ID: <7vhc8w5mfp.fsf@gitster.siamese.dyndns.org>
References: <20080904083343.6117@nanako3.lavabit.com>
 <7vd4jk8r78.fsf@gitster.siamese.dyndns.org>
 <20080904172059.6117@nanako3.lavabit.com>
 <7bfdc29a0809040130u21d43a22ncf2e481eefd9ff89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nanako Shiraishi" <nanako3@lavabit.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 10:46:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbAUI-0003Rv-Bb
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 10:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbYIDIpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 04:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbYIDIpk
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 04:45:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbYIDIpj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 04:45:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3BDF45E505;
	Thu,  4 Sep 2008 04:45:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6C49B5E504; Thu,  4 Sep 2008 04:45:32 -0400 (EDT)
In-Reply-To: <7bfdc29a0809040130u21d43a22ncf2e481eefd9ff89@mail.gmail.com>
 (Imran M. Yousuf's message of "Thu, 4 Sep 2008 14:30:38 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D8699D64-7A5D-11DD-B000-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94908>

"Imran M Yousuf" <imyousuf@gmail.com> writes:

> I actually liked the following 2 patch and since it was Junio I did
> not think support was required :-D.
> ...
>> From: Junio C Hamano <gitster@pobox.com>
>> Subject: [PATCH/RFC] feeding Maildir to git-am
>> Date: Tue, 19 Aug 2008 22:25:57 -0700
>> Message-ID: <7vbpzotfyy.fsf@gitster.siamese.dyndns.org>
>>
>> http://article.gmane.org/gmane.comp.version-control.git/92963
>>
>> From: Junio C Hamano <gitster@pobox.com>
>> Subject: Re* [PATCH] git-apply - Add --include=PATH
>> Date: Mon, 25 Aug 2008 01:05:31 -0700
>> Message-ID: <7vhc99h644.fsf@gitster.siamese.dyndns.org>
>>
>> http://article.gmane.org/gmane.comp.version-control.git/93604

I think for most of these patches, and other patches from me of the same
nature, I tried to make it clear that the patches were primarily to
illustrate possibly better solutions, and I do not consider them finished
solutions.

The quality of these patches from me do not meet my patch acceptance
criteria.

More importantly I wasn't the one with the itch.  Onus of testing them,
polishing them as necessary and providing documentation into the final
applicable patch lie on the original requestors' shoulders.

Especially when I am busy.
