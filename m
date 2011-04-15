From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 6/5] Documentation/format-patch: suggest Toggle Word
 Wrap add-on for Thunderbird
Date: Fri, 15 Apr 2011 11:49:13 -0700
Message-ID: <7vfwpjcpue.fsf@alter.siamese.dyndns.org>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net> <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org> <20110414211125.GA15277@elie>
 <7vlizcfpz8.fsf@alter.siamese.dyndns.org> <20110415021100.GA19829@elie>
 <4DA7F6C0.4050707@viscovery.net> <7vtydzcse4.fsf@alter.siamese.dyndns.org>
 <4DA887FF.4070606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 20:49:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAo5L-0004JG-IE
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 20:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab1DOSte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 14:49:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab1DOStd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 14:49:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24C193AE8;
	Fri, 15 Apr 2011 14:51:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BmDETzh0a0W8BOpniF37cSfZx4k=; b=d7Dst8
	zf7WWOLHdK9ejwcR6XedZ2bXstuVe549wp8W+zKbFsUunOkuS3h/nlIZzuuObUsa
	+Gt7gMziTlyC6j0+8dOX/2da9HGzJuQFNHQo52yyM/nI554iWxJBNueeMxPLdpeO
	ZtkBQA3p8zEiUgmco+NnAodY5zLORRBQvexu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M24UelwmBqVCzYZ0O7MoDr01pP0FJOog
	tkysoE0crfO5y8E5lGhWA9XsNbBS8m9CX1i/YYQZDrTwDwBmf+P9gkYsXFkykxeL
	XgThOHB3g8Sfx6R0iYYdP7L+aXXigr85JViRDNpcfgrrTjxRV8kbOnqASL6d/Rz2
	j4dbUb4HkBA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 97FC73AE1;
	Fri, 15 Apr 2011 14:51:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C7193AC8; Fri, 15 Apr 2011
 14:51:13 -0400 (EDT)
In-Reply-To: <4DA887FF.4070606@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 15 Apr 2011 20:01:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C2168B2-6791-11E0-B441-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171630>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 15.04.2011 19:54:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> From: Johannes Sixt <j6t@kdbg.org>
>>>
>>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>>> ---
>>>  How about this as 6/5? I used the method described for this submission, so if
>>>  what you got is unusable, you know what to think of the suggestion ;)
>> 
>> It seems to apply fine ;-).
>> 
>>>  I put this suggestion as approach #1 because I think it is superior to the
>>>  other two (iff it worked).
>> 
>> Care to reword "superior" in a less subjective way (which should be very
>> easy --- both existing suggestions seem to force plain-text no-wrap on any
>> and all outgoing mails and to make it cumbersome to flip back and forth,
>> as opposed to this one that gives a one-click on-demand way to do so only
>> when you are sending a patch) and put it in the log message?
> 
> Does this add-on toggle "format fl[oa]wed" also? Otherwise you have to
> make this is off also.
>
> BTW: "AboutConfig" was great while it was needed, but these days you can
> access Thunderbird's about:config from the options.

I have no idea on neither of these two points, as I don't use these GUI
thingies myself.
