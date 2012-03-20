From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git and Google Summer of Code 2012
Date: Tue, 20 Mar 2012 10:26:39 -0700
Message-ID: <7v62dz6v5c.fsf@alter.siamese.dyndns.org>
References: <001636c5c21b02c35904bba0ff9a@google.com>
 <201203201637.10417.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Andr=C3=A9_Walker?= <andre@andrewalker.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 18:26:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA2pe-0003al-AL
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 18:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266Ab2CTR0p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 13:26:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48345 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756204Ab2CTR0o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 13:26:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 540827B2F;
	Tue, 20 Mar 2012 13:26:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pa+f1etQUmvQ
	X+qT/1ygpaOeLsk=; b=YFhWZGZobhvFTXz0XIbT3jECvhGjr1k6VgBX/I2pngHW
	2SlTD1MKY68gPr9xSb8Mrlj9kowbfj29JvZdxIMs5jrTDVOpNl+C1KE62enB+kKJ
	FKryWT0VqX6ffs0UL2TfnSRjuhSOxetBfzvIlni1z5yIs2VqFDNSe5CXyqW8rh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JcPqKY
	L+LtUDtCrHQrVN7EmBTMnem4ubOXssIs3g7l8MLzhgaBnM5BmgEljaL08EjtAAl2
	7iljb9+NjGu+fg7RRJjOo5rzuV7SK1qzhdpaVesELLFrLD/noVj7JJYUyv1znxbY
	XJH+CmHHXMK4ddmGnRR95EjJ4DHDLXGxfPXwI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B3F37B2E;
	Tue, 20 Mar 2012 13:26:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4EFC7B2D; Tue, 20 Mar 2012
 13:26:40 -0400 (EDT)
In-Reply-To: <201203201637.10417.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue, 20 Mar 2012 16:37:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB1EC7AA-72B1-11E1-BD1E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193522>

Jakub Narebski <jnareb@gmail.com> writes:

> On Tue, 20 Mar 2012, Andr=C3=A9 Walker wrote:
>
>> Hello Jakub, I tweeted to you, but as your last tweet was from Janua=
ry, I'm =20
>> guessing here [personal email via Google Profile] is probably a bett=
er
>> place to talk.
>
> Actually the discussion of GSoC project application ideas with mentor=
ing
> organization[1] should take place in the open, on git mailing list,
> git@vger.kernel.org.  (You don't need to be subscribed to send email =
to
> it, and there is custom on this mailing list of Cc-ing all people
> participating in discussion; you can read git mailing list via other
> interfaces e.g. via GMane.)

The parenthesized part applies to general audience but not to GSoC
students, I would think. Isn't the participation in the mentoring
community mandatory for them?
