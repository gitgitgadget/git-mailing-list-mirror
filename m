From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-add.txt: Explain --patch option in layman terms
Date: Mon, 31 Aug 2009 10:06:39 +0300
Organization: Private
Message-ID: <873a78a2dc.fsf@jondo.cante.net>
References: <87ocpxb46g.fsf@jondo.cante.net>
	<7vab1hdppb.fsf@alter.siamese.dyndns.org>
	<87tyzp9da4.fsf@jondo.cante.net>
	<7vskf954sr.fsf@alter.siamese.dyndns.org>
	<87ab1gaol2.fsf@jondo.cante.net>
	<7vr5usyj3i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 09:07:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi0yj-0007pv-2t
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 09:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbZHaHGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 03:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbZHaHGw
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 03:06:52 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:34047 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbZHaHGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 03:06:52 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id ACA268C856;
	Mon, 31 Aug 2009 10:06:52 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A00DCFA96C0; Mon, 31 Aug 2009 10:06:52 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 4E8782BD4D;
	Mon, 31 Aug 2009 10:06:39 +0300 (EEST)
In-Reply-To: <7vr5usyj3i.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 30 Aug 2009 16:31:29 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127464>

Junio C Hamano <gitster@pobox.com> writes:

> Jari Aalto <jari.aalto@cante.net> writes:
>
>> I think the convention used in git's manual pages deviate from the
>> standard practise. We could make the git manual pages into line of:
>>
>> - write all the first level headings in all caps: "HEADING LIKE THIS"
>> - write second level heading: start Upper-lower: "Heading like this"
>>
>> Cf. rsync(1), ssh(1) etc. many pages prior git's existense.
>

[URL: That's a separate issue. The resolution hung in the air how to
proceed]

Please be patient. I understand that you have lot work. I do care,
therefore I take the time to suggest some chnages.

> Are you volunteering to coordinate such a change (in other words, you do
> not necessarily have to do _all_ the work yourself, alone)

We need resolution first. What would you think about that change?

I could offer patches, but not in any time frame to do it in one-swoop
do-it-all patch. To distribute time and effort to do so, it would be
sensible to handle one manual at a time. The whole work would eventually
get done.

There could be section in TODO.

    RFH - Request for help: Manual page adjustments

    - If you have some spare time, the following manual pages adjustment
      is needed for all git manuals ....

Or 2-weekly RFH post could announce the need. That would be one way to
coordinate participants.

Jari
