From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Sun, 21 Jan 2007 23:16:43 +0100
Message-ID: <87vej0gh4k.fsf@morpheus.local>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vwt3h7dp6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701202240210.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200701210137.41219.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.63.0701210234350.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17842.53449.35322.514320@lisa.zopyra.com> <7vr6tp5aqq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Jan 21 23:17:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8kzv-0001Tw-Jy
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 23:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbXAUWRG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 21 Jan 2007 17:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbXAUWRG
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 17:17:06 -0500
Received: from main.gmane.org ([80.91.229.2]:59226 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbXAUWRF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 17:17:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H8kzg-0000z2-CM
	for git@vger.kernel.org; Sun, 21 Jan 2007 23:16:56 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 23:16:56 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 23:16:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:NUt7+h2fodbSSR0SNFIdz5TsmO0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37352>

Junio C Hamano <junkio@cox.net> writes:

> Bill Lear <rael@zopyra.com> writes:
>
>> How about a '--order' switch?
>>
>>    --order=3Dchrono[logical]
>>    --order=3Drev[erse][-chrono[logical]] (default)
>>
>> The switches "--reverse" and "--noreverse" are certainly confusing i=
n
>> the context of a default that is "reverse chronological order".
>
> I think --reverse is just fine.  It is "reverse" from usual, and
> people already know (or they should learn) what the usual order
> is.
>
>> BTW, my mailer is defaulting to sending mail to the original poster,
>> CCing others, including the mailing list.  I'm used to simply replyi=
ng
>> to the list.  Is this the proper convention here, to reply directly =
to
>> humans and CC the list?
>
> I only speak for myself, but I always prefer to address my
> message's To: header to the person I am primarily talking to,
> while leaving other people on Cc: line (which usually includes
> the list address).

I, on the other hand, have recently been annoyed by having my inbox
filled with mails that I already can read on the list (actually the
gmane newsgruop).  So there is probably not a single good answer.

--=20
David K=C3=A5gedal
