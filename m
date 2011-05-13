From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] your file
Date: Fri, 13 May 2011 09:52:41 -0700
Message-ID: <7vy62a7dba.fsf@alter.siamese.dyndns.org>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
 <1305292458-3920-6-git-send-email-okano.osamu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Osamu OKANO <okano.osamu@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 18:52:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKvbi-0001sG-JK
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 18:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759349Ab1EMQwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 12:52:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab1EMQwt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 12:52:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 515914B69;
	Fri, 13 May 2011 12:54:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AkiANaCIPuEDhfLFA7Bi7tukYAI=; b=G/eScu
	LABpEQRHiYZfeSrbe311JEPM/2MrATqr5rz4WC8T3ntKsj/6AwEbzV6N/Ww3xtMu
	jEhrSzUGPA3RBWvayxoD+M3ZXuUZKaLvgxA2CtMKQHG/XwiLsic7+WkDnXPLe+nM
	m+1uz/JQ0hlUGBHQMEqXiGu2oqiwVI7eu2mvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S+Xxxp53I7vr0r6nrFdOJsPtj2mxIhMB
	Xd+skpz3Z54EAOo3qeBngjavelEgDdOHyhxgjCs+qHhIIG3gb3CBWaDkbYGUowCt
	dTvvww1svGMfWEX3jgT25UDwrkdqTy7izwuXDz58w/AuovGYedieTtIqCBT4LdWQ
	8/PbR/q8BLo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D80B4B67;
	Fri, 13 May 2011 12:54:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 51E644B66; Fri, 13 May 2011
 12:54:48 -0400 (EDT)
In-Reply-To: <1305292458-3920-6-git-send-email-okano.osamu@gmail.com> (Osamu
 OKANO's message of "Fri, 13 May 2011 22:14:16 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7EAE14A-7D81-11E0-8B2B-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173549>

Osamu OKANO <okano.osamu@gmail.com> writes:

> ---

Why?  Sorry, this change does not make sense to me.

>  Documentation/git-stage.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
> index ba3fe0d..8fcb93c 100644
> --- a/Documentation/git-stage.txt
> +++ b/Documentation/git-stage.txt
> @@ -3,7 +3,7 @@ git-stage(1)
>  
>  NAME
>  ----
> -git-stage - Add file contents to the staging area
> +git-stage - Add your file contents to the staging area
>  
>  
>  SYNOPSIS
