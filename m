From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix grammar in the 1.8.3 release notes.
Date: Mon, 29 Apr 2013 14:20:38 -0700
Message-ID: <7va9ohghjt.fsf@alter.siamese.dyndns.org>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
	<1367262904-9885-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 23:21:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWvVI-0000co-Ng
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 23:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555Ab3D2VUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 17:20:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932336Ab3D2VUk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 17:20:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 063811A6E4;
	Mon, 29 Apr 2013 21:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SvVM9VOkSJXjiIlLPRglwY2I4y4=; b=c+EQIE
	a1XSBImVOJaKuOT8OtYNrm9vgrNWewqjAKCXEvoUMrdHGJcvFjIA2wuCuSX/Qc7S
	q1XH/tMsmt7ZtfJG0jp7f43xI8yk0jnD45obr76D1A2J2nAcrO7jyKkFjhiG/r97
	o+1hi29LSWZbNVIoYCectdNayeUpazfSWjocI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O76hCgUwBiz2lKi4aywYXBvdSee5DkPo
	HEchjIcC3GcreXS/9FgmXIwFGaqKtcOtBPNVYbW/qAshVC8XBTvWQ8qj4YH/1m7m
	vBUikrQJD+R8mDXvXuJHy2E4UENNIUT1ColRjghLhN8uJ35lGziJWMD7VD9JZ9Hr
	hZVo63ejTFM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F153E1A6E3;
	Mon, 29 Apr 2013 21:20:39 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AC041A6E0;
	Mon, 29 Apr 2013 21:20:39 +0000 (UTC)
In-Reply-To: <1367262904-9885-1-git-send-email-marcnarc@xiplink.com> (Marc
	Branchaud's message of "Mon, 29 Apr 2013 15:15:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4186590-B112-11E2-95C4-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222867>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
>
> ---
>
> This started out as an attempt to make the backward compatibility notes
> more parsable, but then I just kept going...

Thanks; everything other than the "bundle" thing looked sensible.
