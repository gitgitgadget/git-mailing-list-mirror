From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Translation inclusion criteria
Date: Tue, 29 Mar 2011 11:59:09 -0700
Message-ID: <7vhbalrbwi.fsf@alter.siamese.dyndns.org>
References: <4D889CC9.4060603@gmail.com>
 <1301417951.13114.7.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rodrigo Rosenfeld Rosas <rr.rosas@gmail.com>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:59:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4e8V-0005Uz-JV
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067Ab1C2S7X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 14:59:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab1C2S7W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 14:59:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C8ECA45E8;
	Tue, 29 Mar 2011 15:01:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dncF7xIPURC5
	u1AxrqaReO91ODc=; b=MNzJzPlOrLz0ZCqGBD/yH2MiRRcgTIoO/gEFmknrcX6m
	i+Q0uabmm8Ao1T0E4PoZCNT8JPA3yj6mKspUoIy6Uou6EQQsnqrU0mXJ4RvusLSp
	hp/oUbdEq7R2kDxo3qpPhW8R+1qnLsBukg0tEoO195VelY1NsLm2k6pztt7Z9xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=F1MeLK
	bCSZdIosQbdOi3zZbTqWCQ1Aq3vzgXwLnxDWJcEXNC/axV0z0ycsteF1OnWA6gs+
	7kHrsKu00svVK1pROizk/ZCt09s1UkMjPN2D+LnzegD5jj7bFc9ZKofm1f3M1JxE
	3Dl6euZ3FpZR2J8XNmL0iL8T3M8CoMolzoj+Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87EF545E6;
	Tue, 29 Mar 2011 15:01:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 311FE45DC; Tue, 29 Mar 2011
 15:00:58 -0400 (EDT)
In-Reply-To: <1301417951.13114.7.camel@drew-northup.unet.maine.edu> (Drew
 Northup's message of "Tue, 29 Mar 2011 12:59:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E569BBE6-5A36-11E0-A2CA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170306>

Drew Northup <drew.northup@maine.edu> writes:

> On Tue, 2011-03-22 at 09:57 -0300, Rodrigo Rosenfeld Rosas wrote:
>> Hi, I've followed the instructions in git-gui/po/README in 2008 but=20
>> pt.po was never included in master. Now I've just updated it.
>>=20
>> Is there anything else I should do for it being merged to master? Wh=
at=20
>> is the criteria for including new translations?
> ...
> Rodrigo,
> Internationalization of Git is very much an ongoing process. I suspec=
t
> that has something to do with the uptake of your contribution. =C3=86=
var may
> have more information.

All the git-gui changes come through Pat Thoyts these days; =C3=86var h=
as
nothing to with git-gui i18n/l10n (except perhaps as a translator to hi=
s
own language, but I don't see his name in the shortlog).

Perhaps the submission was sent with wrong Cc:; I don't pay attention t=
o
git-gui and gitk l10n patches myself.
