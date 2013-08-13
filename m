From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git-po] [fr] first commits for French localization (#62)
Date: Tue, 13 Aug 2013 10:45:43 -0700
Message-ID: <7vr4dxwkl4.fsf@alter.siamese.dyndns.org>
References: <git-l10n/git-po/pull/62@github.com>
	<CANYiYbFz2kQj512SiOTTc4atdH5Na70grSgRhSBfTNgXdiqgAQ@mail.gmail.com>
	<CANYiYbHZi0RPmgzvkQh1h1TAr4YT5a6GSdf9m=7oMdJMiKXvFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Noel Avila <jn.avila@free.fr>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 19:45:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9IfJ-0004XB-0m
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 19:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286Ab3HMRps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 13:45:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756870Ab3HMRps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 13:45:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5DC838D1B;
	Tue, 13 Aug 2013 17:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wOUEo2Yr1sfma7mO3baKBFXuKPE=; b=xRtzRB
	qLF93mZyonwO2K9xc0XhkHfAe12oLpkyexzqj29azH8CQ5qYNaxiPR210TI2yKVF
	WvY/NYHBPFWwihZtuKgVA7E+izXu0kP/4xN5RdC35G7Mezhm+5VHcW3XqG/mClfh
	6fZ/McovsDMOhNFpSdXQ/5TxeBNirKvVR0tTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yPzKeooMT762wtyRNtPIMXhlAqVBuZIf
	sapa2YVry+eiLltiqZEso2VG1IQvs+EEM3cHq/CAzjgnye3oQmPwp4bRsY660u+w
	Vh7T/NAmSYT4c6fjXeKdi4z1bS/VebOLZ3mvehjUGAdxGKYihfas6G3l3uB6ES9m
	4HsU+5m/bvs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8876338D1A;
	Tue, 13 Aug 2013 17:45:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C04C38D14;
	Tue, 13 Aug 2013 17:45:45 +0000 (UTC)
In-Reply-To: <CANYiYbHZi0RPmgzvkQh1h1TAr4YT5a6GSdf9m=7oMdJMiKXvFQ@mail.gmail.com>
	(Jiang Xin's message of "Mon, 12 Aug 2013 15:30:27 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E40467C-0440-11E3-96E1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232239>

Jiang Xin <worldhello.net@gmail.com> writes:

> Haven't seen new languages support for git l10n for over 1 year.
> Here comes French translation.

Nice.

Pulled, and will be part of -rc3.

Thanks.
