From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 2 new messages
Date: Fri, 07 Sep 2012 10:44:27 -0700
Message-ID: <7vhar9ybgk.fsf@alter.siamese.dyndns.org>
References: <1346865100-10908-1-git-send-email-ralf.thielow@gmail.com>
 <CANYiYbFBoK7D+9oZ2YGsrHYafOETLRUWUmHzfnAyA7RRhqgEkA@mail.gmail.com>
 <CAN0XMOL+2RV3wxp0nCAJzBBVF2vRNsK6H=MFYEqvKTw+nkcuXw@mail.gmail.com>
 <CAN0XMOL9cxy8noicF-P-cjLkw76Zf3Uyu4C2RqbcTYrug5+w8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBR?= =?utf-8?B?dcOibg==?= 
	<vnwildman@gmail.com>, Peter Krefting <peter@softwolves.pp.se>,
	trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
	<pclouds@gmail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 19:44:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA2be-0001Gm-2t
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 19:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148Ab2IGRob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 13:44:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54970 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab2IGRo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 13:44:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EF5D8486;
	Fri,  7 Sep 2012 13:44:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oXf9aSGs4ZLlj8iEvVlhaumJkxg=; b=TANGd/
	CExMiQEKWFCyIqs1KP6UApQkHmdA+dVcvf9bp+7z7FOR0LfasDpIs8wbV0NoC3tg
	8HoYay5Cjt3Bb36MXostrtjhIyRDq8IC3k1OlnJfXumfi3arDbddc6/XxG7Yjfoa
	jqkGYJoLhZXD5OpZdEOoA7oimR9LkGdG8bmOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M97BlPexANngLxW7VfhO7+UeKIkoAmEg
	oTCnDoHQcvke36hkeluMj9UoaoC9tiMco1n475T3ZZ19C0FKQpSKqUPnaeHFfXsF
	BjVJVML9wzS2Ks9jdfnLkgmEYdIdi+YS4pgRapSmW8ClzGjb9XdbttID42gMgVLB
	0d9e2y3CdUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BAA88485;
	Fri,  7 Sep 2012 13:44:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 646748482; Fri,  7 Sep 2012
 13:44:28 -0400 (EDT)
In-Reply-To: <CAN0XMOL9cxy8noicF-P-cjLkw76Zf3Uyu4C2RqbcTYrug5+w8Q@mail.gmail.com> (Ralf
 Thielow's message of "Fri, 7 Sep 2012 19:05:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC139FB0-F913-11E1-8A3D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204982>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> On Fri, Sep 7, 2012 at 6:36 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
>> On Fri, Sep 7, 2012 at 12:31 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
>>> I just notice that the 1st line of the orignal message below has
>>> only 56  characters, much shorter than other lines. It is because
>>> this is a warning message, and would add a prefix: "warning: ".
>>>
>>> #: builtin/push.c:151
>>> msgid ""
>>> "push.default is unset; its implicit value is changing in\n"
>>> "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
>>> "and maintain the current behavior after the default changes, use:\n"
>>> "\n"
>>> "  git config --global push.default matching\n"
>>>
>>> For this reason, translations as follows are not well-formed.
>>> So I rewind git-po, and your commits may need a bit amend.
>>>
>>
>> I admit that I don't really understand what you mean. I can't
>> see a big difference in line lengths. It's not more than others
>
> I got it. This "warning: " is added automatically.
> Sorry

We may want to revisit this behaviour, by the way.

If you have a long string that barely happens to fit on a line with
"warning: " prefix in the original, your translation might want to
spell it in two lines, i.e.

	warning(_("A quick brown fox jumps over the lazy dog."));

which gives

	warning: A quick brown fox jumps over the lazy dog.<LF>

might want to turn into

	warning("AA qquuiicckk bbrroowwnn ffooxx\n"
        	"jjuummppss oovveerr tthhee llaazzyy ddoogg.");

and currently gives:

	wwaarrnniinngg: AA qquuiicckk bbrroowwnn ffooxx<LF>
        jjuummppss oovveerr tthhee llaazzyy ddoogg.<LF>

But we may want to give

	wwaarrnniinngg: AA qquuiicckk bbrroowwnn ffooxx<LF>
        wwaarrnniinngg: jjuummppss oovveerr tthhee llaazzyy ddoogg.<LF>

instead.

Check out the way advice.c::advise() does its "hints: " prefix for
hints, but we probably would want to avoid anything that allocates
more memory in the die() codepath.
