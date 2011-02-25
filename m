From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 24/73] gettextize: git-checkout "Switched to a ..
 branch" message
Date: Fri, 25 Feb 2011 11:56:19 -0800
Message-ID: <7vaahjanx8.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-25-git-send-email-avarab@gmail.com>
 <20110225081048.GH23037@elie>
 <AANLkTikGZL--hn-BTPmPK-9oDi0p1h6o7EZ47jeEF0iY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 20:56:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3mG-00014l-S6
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 20:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810Ab1BYT4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 14:56:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab1BYT4b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 14:56:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3DE074D41;
	Fri, 25 Feb 2011 14:57:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Y5iCIfpgExSLiDzU5Xc1R1/taY=; b=LyMy0f
	pnCLMCvEv6aQj+vnCQNvdg74rhVG81DpH/DML9GuHz+vBZyMHtvcEbdPL4eLU48S
	9HnovW7Tcxyj2Dv3kpAlAZwMi7AyH3qdSL5KtUO+HRYuUmVm4xxUjMx2R8Uz+bDP
	nZ2j+cbFTuxI78KPZFI5Ay+tjZsW1uS5eVE5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I/YfuO71mnvnLiIzYCcjV7qjUAVQf9qU
	GvUbVETQNv7lI5eM6jT9J0JR5XNdVd9SaHL8bf15qUSRkQC3Eo/3/zrct9W09mOW
	8pCYd1C5wYp5He0uCvjBRgGCvw4lVyDR6C06orcBpQVuXnhEjZ/jBSXvKhWJokn1
	v0B+ntwejok=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EDCB24D3F;
	Fri, 25 Feb 2011 14:57:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 51EFE4D3D; Fri, 25 Feb 2011
 14:57:37 -0500 (EST)
In-Reply-To: <AANLkTikGZL--hn-BTPmPK-9oDi0p1h6o7EZ47jeEF0iY@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 25 Feb
 2011 20\:47\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 81D47296-4119-11E0-9322-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167928>

I've locally amended this, and inserted the distclean-pot, in the series,
so no need to resend only for these two.

If you are re-rolling the series, please don't forget to include them, as
I'd be wholesale replacing in that case.

Thanks.
