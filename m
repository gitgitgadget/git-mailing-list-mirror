From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] hotfix on fr.po for the maint branch
Date: Fri, 30 Aug 2013 09:54:59 -0700
Message-ID: <xmqq61un15lo.fsf@gitster.dls.corp.google.com>
References: <CANYiYbG6MweCwLaUw5Uk3S9a0hUY1vuS+ORCF1BipkZkJeHjrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jean-Noel Avila <jn.avila@free.fr>,
	Sebastien Helleu <flashcode@flashtux.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 18:55:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFRyY-00043Z-7r
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 18:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599Ab3H3QzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 12:55:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755448Ab3H3QzC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 12:55:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5B173D13B;
	Fri, 30 Aug 2013 16:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8akAEuz7n2JhMj9xh26T1Wee0pw=; b=fUdcIN
	hD63fOlQ4fOGrZz1AQczvWU4sRCcdvSUH0FCGlj+kVrrZRg7o/EhX2SXD/6dYT/A
	JOOaNev2EuwtfXNCrOj8byA1aKud2eeBq08o8ZTYTWRYFky/VhPCl08gdBMsevny
	bFma6feOMeHDmVakxSbzoyJ2ZCbJuaEgbmlHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pr6z6pvRes0QMdqoLIU8DccuvPwEfmXI
	O7uGPEX7r6xXkOMB4k0UfaasFEx40CabB3W0Jqsf2rIm6EuB5hgnDpPGgLRrTOBm
	PWkDyFNJGEmjBL6Acv5TXVSwSBCNJxBXH8mzPIg9pcbrU5TYfHRmqKh6j0AsZYYV
	kSEsJAegdHc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8E1D3D13A;
	Fri, 30 Aug 2013 16:55:01 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48A103D139;
	Fri, 30 Aug 2013 16:55:01 +0000 (UTC)
In-Reply-To: <CANYiYbG6MweCwLaUw5Uk3S9a0hUY1vuS+ORCF1BipkZkJeHjrw@mail.gmail.com>
	(Jiang Xin's message of "Fri, 30 Aug 2013 17:07:26 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E8FE6078-1194-11E3-A8B6-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233444>

Jiang Xin <worldhello.net@gmail.com> writes:

> Please merge this commit to the maint branch.
>
> The following changes since commit e230c568c4b9a991e3175e5f65171a566fd8e39c:
>
>   Git 1.8.4 (2013-08-23 11:49:46 -0700)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po master
>
> for you to fetch changes up to 21860882c8782771e99aa68fab6e365c628ff39d:
>
>   l10n: fr.po: hotfix for commit 6b388fc (2013-08-30 16:59:29 +0800)
>
> ----------------------------------------------------------------
> Sebastien Helleu (1):
>       l10n: fr.po: hotfix for commit 6b388fc

Hmph, what happened that requires a "hotfix" to message strings?

>
>  po/TEAMS |    1 +
>  po/fr.po | 1591 ++++++++++++++++++++++++++++++++++----------------------------
>  2 files changed, 874 insertions(+), 718 deletions(-)
>
> --
> Jiang Xin
