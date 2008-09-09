From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: [ANNOUNCE] Guilt v0.31
Date: Tue, 09 Sep 2008 18:29:29 +0200
Message-ID: <48C6A469.30702@fastmail.fm>
References: <20080908135244.GB27550@josefsipek.net> <36ca99e90809081133s58e3d32h8b85804f5bb76902@mail.gmail.com> <20080908184322.GE27550@josefsipek.net> <36ca99e90809081150v4ad6e7a0n72b5cca39e02b1bc@mail.gmail.com> <7vmyiifnwa.fsf@gitster.siamese.dyndns.org> <48C64B8B.5000606@fastmail.fm> <48C673CF.2000107@fastmail.fm> <7vd4jd8i9b.fsf@gitster.siamese.dyndns.org> <48C698DF.7010401@fastmail.fm> <7vtzcp71el.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Josef 'Jeff' Sipek <jeffpc@josefsipek.net>,
	Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	guilt@lists.josefsipek.net, Brandon Philips <brandon@ifup.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 18:30:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd673-00039u-Ok
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 18:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834AbYIIQ3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 12:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754799AbYIIQ3f
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 12:29:35 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39531 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754072AbYIIQ3e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2008 12:29:34 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D620315E6F7;
	Tue,  9 Sep 2008 12:29:33 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 09 Sep 2008 12:29:34 -0400
X-Sasl-enc: 4JBWiBk4zTOwc5AdB3MwovrRG/Dd8KkWHbyC7f0PzJYa 1220977773
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9D8ED279C4;
	Tue,  9 Sep 2008 12:29:32 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <7vtzcp71el.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95403>

Junio C Hamano venit, vidit, dixit 09.09.2008 18:02:
> Michael J Gruber <michaeljgruber+gmane@fastmail.fm> writes:
> 
>> I keep hearing this argument, and I'm even more surprised to hear it
>> right after a major release. If not now then when's a good time for
>> cleaning up confusing inconsistencies?
> 
> Actually, after a major release is the worst time to push for such an
> agenda.

For many projects, things become unstable after a major release. This is
the time to experiment. Right before a major release, everything needs
to settle down, with a focus on bugfixes and stability.

That said, I know the "logic" of the make targets now, so I really don't
care any more what they are named. I just meant to keep others from
being confused. So I guess I'll go with the existing naming and fit
quick-install-html right in. Will go into a new thread tomorrow or so.

> Especially when that release burned the maintainer with numerous complains
> against a major change in it, that has been advertised for a long time,
> which was pushed by other people for no good reason other than "such a
> clean-up would make things much tidier".
> 
> Grrr ;-).

Junio,
I think you handled that in the best possible way, and I felt
sympathetic with you when that thread with a RFC went OT back to
discussing things over again.

Cheers,
Michael
