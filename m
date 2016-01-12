From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] Korean l10n updates for Git 2.7.0 (maint branch)
Date: Tue, 12 Jan 2016 15:05:51 -0800
Message-ID: <xmqqwpres8j4.fsf@gitster.mtv.corp.google.com>
References: <CANYiYbHVUi3xftFuwTHkiXgS=7KZEv309dE5vyywsFVvSMcEEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Changwoo Ryu <cwryu@debian.org>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 00:06:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ816-0003wA-Ps
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 00:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbcALXFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 18:05:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753169AbcALXFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 18:05:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 441163B031;
	Tue, 12 Jan 2016 18:05:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vU8nC1WZAvCdKsR3LUiIalBexPk=; b=ukXN2e
	dKusEp7y6ziI9gjakGh7XbYFCNAEaPknAMZSg+qivxQEMXkQGrk3i5cqEEOE35eQ
	GqLSsjwGBbwTvNrwL3+T2Uf5wvaKGqgb1on3lKNXZP+hMrVpanh/SVixK3mvqH8E
	JCp6whh59PhC3oVAI7bNCVnnV5l/lZyYuISq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JhubPmOuq8hT8R/KwMJbHp6216bPd9sW
	PnytrNrNNTY2xu4pzWXEXQIBOUExmTexPuwkDq2GjorIKhNefD+DC1JA8hkvRK8i
	IwN2ET5dc9susjQQcRdjmovmZHEuEkG+8yuRO9gfwm7NNOKMV59XpxaACH4DYmIy
	qfRQnRE7tgM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 39ABD3B030;
	Tue, 12 Jan 2016 18:05:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF5653B02F;
	Tue, 12 Jan 2016 18:05:52 -0500 (EST)
In-Reply-To: <CANYiYbHVUi3xftFuwTHkiXgS=7KZEv309dE5vyywsFVvSMcEEA@mail.gmail.com>
	(Jiang Xin's message of "Tue, 12 Jan 2016 01:20:00 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 073265D0-B981-11E5-B575-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283850>

Jiang Xin <worldhello.net@gmail.com> writes:

> Changwoo contributed a new language (Korean) l10n support, but missed the
> update window for Git 2.7.0.  Please merge this to the maint branch.

Thanks, both.  Will do.
