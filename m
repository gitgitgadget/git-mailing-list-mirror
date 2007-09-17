From: Junio C Hamano <gitster@pobox.com>
Subject: Re: metastore
Date: Sun, 16 Sep 2007 23:06:46 -0700
Message-ID: <7vtzpt3jwp.fsf@gitster.siamese.dyndns.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151507310.28586@racer.site>
	<20070915145437.GA12875@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151430040.5298@iabervon.org>
	<Pine.LNX.4.64.0709152310380.28586@racer.site>
	<Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
	<7vwsur590q.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161245490.24221@asgard.lang.hm>
	<7v7imq5ki0.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161541330.24221@asgard.lang.hm>
	<7vk5qq3y76.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161925000.24221@asgard.lang.hm>
	<7v7imp539u.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709162126380.24221@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Sep 17 08:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX9lC-0003Cg-De
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 08:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXIQGG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 02:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbXIQGG7
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 02:06:59 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:53636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbXIQGG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 02:06:59 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 96E2C13537B;
	Mon, 17 Sep 2007 02:07:10 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709162126380.24221@asgard.lang.hm>
	(david@lang.hm's message of "Sun, 16 Sep 2007 21:35:21 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58391>

david@lang.hm writes:

> On Sun, 16 Sep 2007, Junio C Hamano wrote:
>
>> I also need to rant here a bit.
>>
>> Fortunately we haven't had this problem too many times on this
>> list, but sometimes people say "Here is my patch.  If this is
>> accepted I'll add documentation and tests".  I rarely reply to
>> such patches without sugarcoating my response, but my internal
>> reaction is, "Don't you, as the person who proposes that change,
>> believe in your patch deeply enough to be willing to perfect it,
>> in order to make it suitable for consumption by the general
>> public, whether it is included in my tree or not?  A change that
>> even you do not believe in yourself has very little chance of
>> benefitting the general public, so thanks but no thanks, I'll
>> pass."
>
> I hope that my questions did not seem to fall into this catagory.

Not at all.
