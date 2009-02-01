From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] chain kill signals for cleanup functions
Date: Sat, 31 Jan 2009 17:58:07 -0800
Message-ID: <7vab96zzo0.fsf@gitster.siamese.dyndns.org>
References: <20090122042643.GB31427@coredump.intra.peff.net>
 <20090122060235.GC30133@coredump.intra.peff.net>
 <20090130075552.GA27716@coredump.intra.peff.net>
 <4982B68C.2070207@viscovery.net>
 <20090130082101.GA28809@coredump.intra.peff.net>
 <7vd4e49v48.fsf@gitster.siamese.dyndns.org>
 <20090131014420.GA7696@sigill.intra.peff.net>
 <20090131065049.GA3130@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 01 02:59:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTRcb-0000Hm-6O
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 02:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbZBAB6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 20:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbZBAB6P
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 20:58:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbZBAB6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 20:58:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 92D4E959CC;
	Sat, 31 Jan 2009 20:58:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4880F959CB; Sat,
 31 Jan 2009 20:58:09 -0500 (EST)
In-Reply-To: <20090131065049.GA3130@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 31 Jan 2009 01:50:49 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C8D3CCAA-F003-11DD-A80C-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107969>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 30, 2009 at 08:44:20PM -0500, Jeff King wrote:
>
>> > Will do, but I've been sick today, haven't caught up with the list
>> > traffic, and I do not think I'll be reading my mails for the rest of the
>> > day either.  It may take some time for it to appear in the public
>> > repositories.
>> [...]
>> Now I'm off to go make fun of you, buried deep in a thread where you
>> won't see it.
>
> Hmm, reading that again, it sounds mean, and I didn't mean it that way.
> I should have put a ";P" at the end. What I meant was "while the cat is
> away, the mice will play" (i.e., make mischief while our benevolent
> dictator is out of commission).
>
> Hope you feel better soon.

Thanks.  I guess not much happened on the list while I was sick in bed.

I'll try to take a bit more rest and catch up tomorrow.
