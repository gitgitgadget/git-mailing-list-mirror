From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Tue, 23 Feb 2016 14:13:34 +0100
Message-ID: <vpqr3g3h8n5.fsf@anie.imag.fr>
References: <vpqoabox66p.fsf@anie.imag.fr>
	<CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
	<vpqd1s2e74l.fsf@anie.imag.fr>
	<20160212130446.GB10858@sigill.intra.peff.net>
	<vpqd1s04zzs.fsf@anie.imag.fr>
	<CACsJy8BzkWSc11ODenEuGBBta+dkLS893o7oRS57_ctoB5ie8A@mail.gmail.com>
	<vpqziutkps7.fsf@anie.imag.fr>
	<20160222214246.GE15595@sigill.intra.peff.net>
	<xmqqlh6c5ryz.fsf@gitster.mtv.corp.google.com>
	<20160222220248.GC18250@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 14:14:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYCmw-00022m-QG
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbcBWNNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 08:13:53 -0500
Received: from mx1.imag.fr ([129.88.30.5]:58947 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbcBWNNu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:13:50 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1NDDYwP032501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 14:13:34 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NDDZ6E008145;
	Tue, 23 Feb 2016 14:13:35 +0100
In-Reply-To: <20160222220248.GC18250@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 22 Feb 2016 17:02:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Feb 2016 14:13:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NDDYwP032501
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456838017.30172@rMaovrpVNuKA4JQttUbAkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287050>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 22, 2016 at 01:56:52PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I agree that there are a lot of different ways to resolve each instance,
>> > and it will vary from case to case. I think the original point of a
>> > microproject was to do something really easy and not contentious, so
>> > that the student could get familiar with all of the other parts of the
>> > cycle: writing a commit message, formatting the patch, posting to the
>> > list, etc.
>> 
>> I had an impression that Micros are also used as an aptitude test,
>> and one important trait we want to see in a potential developer is
>> how well s/he interacts with others in such a discussion.  So "easy
>> and not contentious" might not be a very good criteria.
>> 
>> I dunno.
>
> I sort-of agree. I think of the microprojects as more of a "fizz-buzz",
> where you intentionally keep the technical level very low so that you
> can evaluate the other things.

I agree with "very low", but I don't think we should eliminate
completely the difficulty. During the selection, microprojects can be
very efficient in eliminating the really bad candidates (usually, there
are quite a few), but once the first selection is done, we still need
tools to separate "moderately good" and "really good" candidates.

> So I think a little back and forth is good; almost everybody does
> something a little wrong in their first patch submission. But I'd worry
> about a topic that is going to involve a lot of bikeshedding or subtle
> nuances to finding the correct solution. I certainly think _some_
> candidates can handle that, but for the ones who cannot, it may
> frustrate all involved.

Well, starting a microproject and realizing afterwards that it was a
hard one is frustrating. But picking a very easy project and see someone
else do a brillant job on a harder one, and this someone else get
accepted is also frustrating.

I don't think this "kill -Wshadow warning" is really too hard. I'd say
it's hard enough to be interesting for students who have a chance to be
selected in the end.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
