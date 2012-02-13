From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bulgarian translation of git
Date: Sun, 12 Feb 2012 19:56:48 -0800
Message-ID: <7vy5s7idxb.fsf@alter.siamese.dyndns.org>
References: <75009f1d7c4aba4d62bb226ab122932c@192.168.122.10>
 <CANYiYbGr3zN-kJwq_MCnttNZP6Cc0aj-fsZjd4V=4z+BA5TvUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?iso-2022-jp?B?QWxleGFuZGVyIFNob3BvdiAoGyRCJyEnXSdWJ1wnYydRJ18bKEI=?=
	 =?iso-2022-jp?B?GyRCJ1UnbCdiGyhCIBskQic6J2AnYSdgJ1MbKEIp?= 
	<lists@kambanaria.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 04:57:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwn28-00064x-7N
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 04:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab2BMD4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 22:56:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48380 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097Ab2BMD4v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 22:56:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A0D66D92;
	Sun, 12 Feb 2012 22:56:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9CM+DLyulL/JvuZM7zrogqyzP1U=; b=kE73HZ
	P9QOBKbYF/GD6BlGCC+mHWy2FvX1zTiRTxe8BBJXNyyqC7hgRZSpmF7wPT5DZn2h
	Hpjci9nX3pYyxhQzw4dUhztcA6s+vFKyLWLCxik+AHcUctK1O3+VVdTprETRRD4e
	BZg8WuUNCKl9rNX7akluEjZ41T1HyH0ao5bSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gmq8FTXGNVXbexyxG2K8Exw8OUqEftCB
	Mus/o7/+b4EDIioXNYXr7aGHj1pVfswh+BRAH/jCXYaonIbCUhEmky2T1p0AFjvJ
	qvhPa3DqEXEO0RvVcZmMrnLAektNfD9EQXid/v1jsX/OkMbLePoWooFHwqQqsstz
	J+qFewKklu8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 813DA6D91;
	Sun, 12 Feb 2012 22:56:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D851E6D8E; Sun, 12 Feb 2012
 22:56:49 -0500 (EST)
In-Reply-To: <CANYiYbGr3zN-kJwq_MCnttNZP6Cc0aj-fsZjd4V=4z+BA5TvUw@mail.gmail.com> (Jiang
 Xin's message of "Mon, 13 Feb 2012 10:46:14 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1C3C9B8-55F6-11E1-BEC0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190600>

Jiang Xin <worldhello.net@gmail.com> writes:

> Junio has a suggestion on how to contrib l10n for git, and you can see the
> discussion here: http://article.gmane.org/gmane.comp.version-control.git/189584.
>
> Seems that the suggested git-po repo has not been setup yet, so let me
> have a try.
>
> 1. Repositiry git-po is hosted on GitHub: https://github.com/gotgit/git-po/
>
> 2. I made a commit on the maint branch with a initial version of 'po/git.pot'
>     https://github.com/gotgit/git-po/commit/4247a7a9d39e2a74ce1d58e5eb1f5e5d87977989

Somebody needs to eyeball this commit before anything else happens on top
of it, so that if there is a glaring mistake it can be caught before it
spreads to affect work by translators for various languages.


> 3. As l10n coordinator for Chinese, I translate against the pot file, and
>     the translated po file 'po/zh_CN.po' is commited in my own branch:
> maint-zh-cn.
>     You can find the commit in:
> https://github.com/gotgit/git-po/commits/maint-zh-cn
>
> 4. I will merge the commit in branch maint-zh-cn back or other l10n
> coordinators' contributes
>     to maint branch.
>
> I have a question, which version of po should be maintained? master
> branch or maint branch.

I would say for this round the git-po repository and its pot file should
pick up whatever new translatable strings are added to 'master'.

After this is merged in 1.7.10, we may want to maintain separate tracks,
but at this moment there is no point maintaining something mergeable to
1.7.9.x maintenance track.
