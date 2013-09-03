From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitweb patch, no response
Date: Tue, 03 Sep 2013 13:04:45 -0700
Message-ID: <xmqqfvtlr7s2.fsf@gitster.dls.corp.google.com>
References: <CANzJMBWmE2YM5f8U-h3yL0=Npaobm4t_7beoNvLnwQr5QC+0fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christopher Durkin <cjdurkin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 22:05:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGwqO-0002a9-9Y
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 22:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412Ab3ICUEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 16:04:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644Ab3ICUEw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 16:04:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2E293F7B8;
	Tue,  3 Sep 2013 20:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fhMgQO5fdh6T/8fespGied/Gn/4=; b=auSwMm
	pQbGFX8XORCOlNINNk/AoMP8OQ5d1jr81CGxUYNZopJsHSWrUfVdFNEPBjhDhFKo
	JwuxM4Eilpk6WyMh7r/2PrWi4GiHZuTejLnBquu9b4pwamD9ZoV7ISx7oQ2+N2x2
	MsWzXpMHq90LejZ7MoEsCGVI6muvP2U8QHdZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H/KJtnhu5/vFKi15sqMxSjjCr6Macx0U
	UIYbhCIVzAJHNhiM9skj2wVHTWArgYJXwCtwqEuOvdlA8F31XBYSyO36aase/0W6
	9aOQexxj+skfzUZbF2olrC9WjKgm6zXPk/IdieY8Nzqb7WBnQ8Pmzp5Q++kFTdh5
	phXfgt1+oWM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DCF13F7B4;
	Tue,  3 Sep 2013 20:04:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EBE93F7A8;
	Tue,  3 Sep 2013 20:04:48 +0000 (UTC)
In-Reply-To: <CANzJMBWmE2YM5f8U-h3yL0=Npaobm4t_7beoNvLnwQr5QC+0fA@mail.gmail.com>
	(Christopher Durkin's message of "Tue, 3 Sep 2013 15:24:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1603936C-14D4-11E3-AFAA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233771>

Christopher Durkin <cjdurkin@gmail.com> writes:

> I submitted a small feature addition patch for gitweb (see
> http://article.gmane.org/gmane.comp.version-control.git/232327/match=gitweb)
> a couple of weeks ago.
>
> I didn't get any responses, good or bad. Was there something wrong
> with my submission in terms of formatting? Something else that I
> missed? Any suggestions are greatly appreciated.

It either fell through cracks, as this is a high traffic list, or
nobody was interested in seeing the new feature.

Thanks for a pointer; I'll take a look at it soonish.
