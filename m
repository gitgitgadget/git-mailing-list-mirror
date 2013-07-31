From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] howto: Eliminate all tabs
Date: Wed, 31 Jul 2013 10:03:15 -0700
Message-ID: <7v8v0mvezw.fsf@alter.siamese.dyndns.org>
References: <20130716180158.GA7524@bottich>
	<cover.1375288760.git.halsmit@t-online.de>
	<4d37bfa3326469ab5b7cdbf0018f7aa671c2d74a.1375288760.git.halsmit@t-online.de>
	<20130731165425.GC11219@bottich>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junio@vger.kernel.org,
	Thomas Ackermann <th.acker@arcor.de>
To: Dirk Wallenstein <halsmit@t-online.de>
X-From: git-owner@vger.kernel.org Wed Jul 31 19:03:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Zo3-0004hb-Rk
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 19:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760554Ab3GaRDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 13:03:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39705 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756993Ab3GaRDT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 13:03:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52F6D33BA4;
	Wed, 31 Jul 2013 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/81zYcHXrYktUwpGpUCQZ4oeM+o=; b=t1sWqc
	gR9FZvp4MqVZ7Ihs6iXZt4qpUPxTSbhxg9AA8O6ANk1xKFKDE+NSKoRc3wjSqHed
	taSQDkLKXEfXIJA+TwVRiv5rs9bOB/uETAXiXACyBdQjFojfY0954c5DldYrOBlo
	BPTDTXjxg+FWOeiEtbZIwkeDTY1T2lJtphRrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F1SpfkTqtdRffi5Kshaw0bT/pQ6nv7sD
	1h4ooqiORhXde0oGYjCB25TiCxZLNW5XadeP31ThyLZy3Jcj2+g9MSMMl+gNV43m
	bcudrucWbzwiWn7XBJr3NBr6gVO73g90/0rW1v1h3N+NaX5EgsHGo1dvaH3D2Tws
	nzkgS7MJSuQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4767733BA3;
	Wed, 31 Jul 2013 17:03:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A23E333B9E;
	Wed, 31 Jul 2013 17:03:17 +0000 (UTC)
In-Reply-To: <20130731165425.GC11219@bottich> (Dirk Wallenstein's message of
	"Wed, 31 Jul 2013 18:54:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1875B684-FA03-11E2-9BB1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231434>

Dirk Wallenstein <halsmit@t-online.de> writes:

> diff --git a/Documentation/howto/rebase-from-internal-branch.txt b/Documentation/howto/rebase-from-internal-branch.txt
> index 19ab604..aefe5b1 100644
> --- a/Documentation/howto/rebase-from-internal-branch.txt
> +++ b/Documentation/howto/rebase-from-internal-branch.txt
> @@ -1,8 +1,8 @@
> -From:	Junio C Hamano <gitster@pobox.com>
> -To:	git@vger.kernel.org
> -Cc:	Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>
> +From:Junio C Hamano <gitster@pobox.com>

Why does this patch have to break the e-mail headers like this?

These are copies of old e-mails; keep them as close to the original
as they were.

Besides, the tab width of our source is 8, period.  Get over it.
