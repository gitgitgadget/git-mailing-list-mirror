From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix typos on pt_BR/gittutorial.txt translation
Date: Thu, 30 Jul 2009 17:35:40 -0700
Message-ID: <7vocr1665f.fsf@alter.siamese.dyndns.org>
References: <b8bf37780907292044i5ad7b879ueb5048447e4e5bb5@mail.gmail.com>
 <20090730145044.GA1727@vespa.holoscopio.com>
 <4A71C6A7.80008@drmicha.warpmail.net>
 <7viqhaar7v.fsf@alter.siamese.dyndns.org>
 <b8bf37780907301551w4cdc7e96m137aa188ce1a0a8c@mail.gmail.com>
 <20090730231911.GI1727@vespa.holoscopio.com>
 <7vtz0t7mnw.fsf@alter.siamese.dyndns.org>
 <20090731000808.GO1727@vespa.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Andr=C3=A9?= Goddard Rosa <andre.goddard@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 02:36:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWg6J-0006fJ-TX
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 02:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbZGaAft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 20:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbZGaAft
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 20:35:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbZGaAft (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 20:35:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3345F171A8;
	Thu, 30 Jul 2009 20:35:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EFF46171A3; Thu, 30 Jul 2009
 20:35:41 -0400 (EDT)
In-Reply-To: <20090731000808.GO1727@vespa.holoscopio.com> (Thadeu Lima de
 Souza Cascardo's message of "Thu\, 30 Jul 2009 21\:08\:09 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 181583C8-7D6A-11DE-8ABD-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124493>

Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com> writes:

> On Thu, Jul 30, 2009 at 04:53:39PM -0700, Junio C Hamano wrote:
>> Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com> writes:
>> 
>> > I'd rather remove the linux example and use something else (like git
>> > itself), since the Documentation is not about linux, as Juno says and
>> > that would stop the disagreements.
>>
>> That is unacceptable, _if_ you are adding a _translated_ version of our
>> primary documentation.
>
> I can't agree more. In that view, would you agree to remove any mention
> to linux in the primary version?

You must be kidding.

If the situation were that the word "Linux kernel" cannot be translated
correctly to many languages, it may make good sense to use a more commonly
known example in the original (and translated) text.  But as far as I can
tell from this thread so far, Portuguese speakers in the tech field would
understand which project you are referring to when you say either "kernel
do linux" or "o kernel linux" just fine.  Avoiding the "Linux kernel"
example only because you have some language lawyering tendency feels just
plain silly.

First of all, I never said anything about "stopping the disagreements".

You can do your disagreement with other people in Portuguese speaking
community all you want.  I only asked you to do your disagreeing with them
in _other forums_.  Do it in your blog, in your own Linux tutorial or git
documentation, or whatever.  I really do not care, and I do not want to
get involved.

But not in our documentation, whose original uses the Linux kernel as an
example, simply because that's the original proeject git came from.

Pick whichever word you feel is the most appropriate translation, and send
in an update (or a pull request), and let's get this round of typofixes
over with in the first place.  I do not care if that version said "kernel
do linux" or "o kernel linux".

If enough people care deeply about one way or another like you seem to do,
they can send in further updates and I may (or may not) pick it up to
reverse whatever choice you make in that version.  But that will be in a
later round.  Let's not let this block other noncontroversial and
obviously correct updates, Ok?
