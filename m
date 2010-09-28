From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 000/159] [PULL] Updated + rebased ab/i18n
Date: Tue, 28 Sep 2010 10:58:56 -0700
Message-ID: <7veicdu4v3.fsf@alter.siamese.dyndns.org>
References: <1285666838-7471-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 19:59:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0eSP-0001g3-3X
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 19:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252Ab0I1R7H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 13:59:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59352 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab0I1R7G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 13:59:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83248DA8E5;
	Tue, 28 Sep 2010 13:59:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OZvIPWUi5Afn
	ts8tX6onvJbjkc0=; b=Rfm6qW24ZqqbulNlXAIqARiFF+7KE7+nLYEZMX/glmo3
	OwLTHo5FLUQvV5Wo2BidvS71ZnWXCnNbsJ9iHVHuWWah/B9tRmBJueX0esVEeBEM
	zsF4rYYFDZPHA6jAdc4o7n60OZ/hGfjR5XUcu4S8YAu8HdURgTMqXv4OyIuz7JM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PvMYru
	qpLW/5VFoZwMzsntdAzvZPhECzn0JwsWc/OsQ9z+nEOFoNGAF/IiX1tRCVy11qaP
	wWjDNnP5yc8i63VRkouiAlQnWvrvbVfaBoGDpOB6Khzq3AySKo4pytIQsSC5yx7e
	d5fs+G/N8ikrXhf1gND95+7qxOOYHrNv5BwYM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E494DA8E2;
	Tue, 28 Sep 2010 13:59:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3409DA8E1; Tue, 28 Sep
 2010 13:58:58 -0400 (EDT)
In-Reply-To: <1285666838-7471-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue\, 28 Sep
 2010 09\:40\:38 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 131470D2-CB2A-11DF-9EAB-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157450>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Please pull an updated ab/i18n. The version you have now should be
> ejected in favor of it:
>
>     git://github.com/avar/git.git ab/i18n
>
> There are no code changes since my last pull request, just a rebase.

If it is "just a rebase", I do not see a reason to pull from you, but y=
ou
seem to have some updates and they look sane ;-)

Thanks.
