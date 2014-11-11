From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for 2.2.0 round 1
Date: Tue, 11 Nov 2014 09:35:47 -0800
Message-ID: <xmqq61el7i8c.fsf@gitster.dls.corp.google.com>
References: <CANYiYbHmebuwuGTPNHfZ4MHKeJSMBnwmVSaZ0ZD6tFKrYAawgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Peter Krefting <peter@softwolves.pp.se>,
	Tran Ngoc Quan <vnwildman@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 18:36:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoFMI-000730-GF
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 18:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbaKKRf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Nov 2014 12:35:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750859AbaKKRf5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Nov 2014 12:35:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FA9F1C622;
	Tue, 11 Nov 2014 12:35:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rXN3yy8JHJjt
	6kPQcv6EBVIdGsg=; b=DSkcNFVKHPRgWt6nb9ATCC8AYksxCHfrPqf4eLKHBfXq
	h1rU4dQ3wYy5PtwRXrvvktLiI3ipRF0SqAikyo/4ZeoQrNZhUTwh5GoYlsnr1JJr
	Sh4KUFPi/tPJFXbZbzesW5YrzwMNw5n2BQpskG3wiRIAUxXPQPbwk6hf93AQ+mI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=izKw51
	E115UFRNz1V+yXMBnhfnK5np3qu6ERQgBihWuRQHB2znns8t6og8EGJgRWoq9a1s
	Nx0UmbvaHd8ruZA1LAXKXcvw+HjQw/MrwISwGOsWWWT95LIfkUNAXxQZqIookjWe
	rK9Y7VmHgRI3UtX7fVvDgGqIKyUIZ/L6iHwfw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 357E91C61E;
	Tue, 11 Nov 2014 12:35:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 267D21C615;
	Tue, 11 Nov 2014 12:35:49 -0500 (EST)
In-Reply-To: <CANYiYbHmebuwuGTPNHfZ4MHKeJSMBnwmVSaZ0ZD6tFKrYAawgQ@mail.gmail.com>
	(Jiang Xin's message of "Sun, 9 Nov 2014 22:36:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2CF88082-69C9-11E4-AA9D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Please pull the following git l10n updates.
>
> The following changes since commit 4ace7ff4557350b7e0b57d024a2ea311b3=
32e01d:
>
>   Git 2.2.0-rc0 (2014-10-31 11:57:23 -0700)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po master
>
> for you to fetch changes up to 6c31a5e94af1036bb29da8a75f1e735e662aee=
92:
>
>   l10n: Updated Bulgarian translation of git (2296t,0f,0u) (2014-11-0=
2
> 19:11:08 +0200)

Thanks, all.

>
> ----------------------------------------------------------------
> Alexander Shopov (1):
>       l10n: Updated Bulgarian translation of git (2296t,0f,0u)
>
> Jean-Noel Avila (1):
>       l10n: fr.po (2296t) update for version 2.2.0
>
> Jiang Xin (4):
>       l10n: git.pot: v2.2.0 round 1 (62 new, 23 removed)
>       Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
>       Merge branch 'fr_2.2.0' of git://github.com/jnavila/git
>       l10n: zh_CN: translations for git v2.2.0-rc0
>
> Peter Krefting (1):
>       l10n: sv.po: Update Swedish translation (2296t0f0u)
>
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
>       l10n: vi.po: Update new message strings
>
>  po/bg.po    | 3211 +++++++++++++++++++++++++++++++------------------=
--------
>  po/fr.po    | 3199 +++++++++++++++++++++++++++++++------------------=
--------
>  po/git.pot  | 3109 +++++++++++++++++++++++++++++--------------------=
------
>  po/sv.po    | 3187 ++++++++++++++++++++++++++++++-------------------=
-------
>  po/vi.po    | 3306 ++++++++++++++++++++++++++++++++-----------------=
----------
>  po/zh_CN.po | 3197 +++++++++++++++++++++++++++++++------------------=
--------
>  6 files changed, 10327 insertions(+), 8882 deletions(-)
>
> --
> Jiang Xin
