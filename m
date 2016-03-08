From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git has been accepted as a GSoC 2016 mentor organization!
Date: Tue, 08 Mar 2016 15:01:47 -0800
Message-ID: <xmqqmvq8k204.fsf@gitster.mtv.corp.google.com>
References: <448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	<vpqh9h7f9kz.fsf@anie.imag.fr>
	<xmqq60xnjh1s.fsf@gitster.mtv.corp.google.com>
	<vpqziuzdr5r.fsf@anie.imag.fr>
	<20160217204528.GA22893@sigill.intra.peff.net>
	<xmqq60xnhviw.fsf@gitster.mtv.corp.google.com>
	<1455788324.3786.14.camel@dwim.me> <vpq1t896s5c.fsf_-_@anie.imag.fr>
	<1455875178.343346.31.camel@dwim.me> <vpq4mcr8c3j.fsf_-_@anie.imag.fr>
	<20160308224625.GA29922@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 00:01:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adQdX-0005T0-Lp
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 00:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbcCHXBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 18:01:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751075AbcCHXBv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 18:01:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 917534A723;
	Tue,  8 Mar 2016 18:01:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NqAhTcR0EuaJ/ly32gHxT3u35xU=; b=NaxoOC
	UFFogHlZMQrc9IT7NOK/i0EwX/5MOeOeN1nXW5+gPj1GFo8lKivitbg1pUKOWgWd
	8LFyrHpWHg1BDJWe2cdBGq0qeb8LI07wgOZ1NQHRE/HuBMDXYxGfPDuztE1EAn6i
	VT/DDN+3gMNPOmmKyaZ+sQvHAnmQint680NQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qnnU88lD8eQ4CjMJ1V7KbHuU3dpw9rRf
	PHduGSJhzU17NFhCgMOS8yJBZUce/a+sB9qJ+DaU04MjtOg9WtndOy61aRTr+p9Z
	SGURW2b136ezrGlSu/VuEYKpS1n1bKoxKeuhdN2gcou/0bfvVkNVyln2ygyM2DYe
	czpcszKpOMo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 86ED54A722;
	Tue,  8 Mar 2016 18:01:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E2E544A721;
	Tue,  8 Mar 2016 18:01:48 -0500 (EST)
In-Reply-To: <20160308224625.GA29922@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 8 Mar 2016 17:46:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD10E5F8-E581-11E5-9386-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288456>

Jeff King <peff@peff.net> writes:

> I've also signed us up for Outreachy, which is an internship program
> designed to encourage open source participation by under-represented
> groups. Details are here:
>
>   https://www.gnome.org/outreachy/
>
> but I'll try to summarize here what it means for us.

https://wiki.gnome.org/Outreachy/2016/MayAugust#Participating_Organizations

does not seem to list us though.  Is that expected?
