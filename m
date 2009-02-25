From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push
Date: Wed, 25 Feb 2009 01:49:51 -0800
Message-ID: <7v4oyi7sn4.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com>
 <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
 <43d8ce650902242309nef12bd9j9088170b18cc8d4e@mail.gmail.com>
 <7v4oyjc64z.fsf@gitster.siamese.dyndns.org>
 <43d8ce650902250108q48837d85mfcee33b990c5bf00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:51:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGQM-0000pe-3g
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZBYJuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 04:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755203AbZBYJuA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:50:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbZBYJt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 04:49:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 093019D6D7;
	Wed, 25 Feb 2009 04:49:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D77C39D6D6; Wed,
 25 Feb 2009 04:49:52 -0500 (EST)
In-Reply-To: <43d8ce650902250108q48837d85mfcee33b990c5bf00@mail.gmail.com>
 (John Tapsell's message of "Wed, 25 Feb 2009 09:08:36 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A8E5F252-0321-11DE-BAD7-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111423>

John Tapsell <johnflux@gmail.com> writes:

> 2009/2/25 Junio C Hamano <gitster@pobox.com>:
>
>> Please don't talk about changing the default without thinking the
>> ramifications through.
>
> Talking about doesn't harm anything.  I don't really get why you're a
> bit hostile.

I am not saying any discussion about the defaults is bad.

But these topics add flames from uninformed people we have to douse early
to the list traffic, and make it harder to find useful topics by degrading
S/N ratio.

In other words, it certainly harms a lot.

I just want people to think twice (or more) if the change you are going to
propose is worthwhile before imposing that cost to everybody.  A couple of
changes around "git push" scheduled for 1.7.0 are default changes, and it
was worthwhile to discuss about them, but I do not think this one deserves
the human bandwidth, especially we already had discussion on it recently
and we have a reasonable configuration mechanism for doing what you want
already.
