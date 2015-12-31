From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2] user-manual: add addition gitweb information
Date: Wed, 30 Dec 2015 16:44:25 -0800
Message-ID: <xmqqtwmzbg5y.fsf@gitster.mtv.corp.google.com>
References: <xmqqoad7d1g0.fsf@gitster.mtv.corp.google.com>
	<1451517920-30703-1-git-send-email-ischis2@cox.net>
	<2699825.69Q9PnVUEi@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Stephen & Linda Smith <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 31 01:45:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aERMZ-0006Qu-7c
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 01:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbbLaAo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 19:44:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751624AbbLaAo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 19:44:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B27D737F64;
	Wed, 30 Dec 2015 19:44:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7j4EMLzfEYoNCFBAwMzW+GVLjtE=; b=Osz3Qa
	SvLOEDW/Fwya5mcetC0Y+ajxR1w1w9oN8YWlSu9TempKIz40itAXbxOivlpiYnO5
	uGdaRWN9qI3oPQ/iAnZR7b+ECQD6FbMkiw5lN4ph3wSacV99+MC8Yz2PnW1yiiY2
	naI/LPk5jWLUJhFgZNvBZBK8x/BvPWHWkWxd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L9gcc2Rm+naFR/YPvY/0CZLzY/ARfQX6
	DJ8SzsB6UH75SNib59ARvUpIEczuqVHBiEc0QW8dCXys8X+Xs66cSujhOLCGcK5u
	JGEBPryMCQKfL49PWByUzj2yE/7JGBr422soluFrf+LCjwXdFZE43M2pMpJj+IMo
	YZfe0Q56td8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A910237F63;
	Wed, 30 Dec 2015 19:44:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C6BF37F62;
	Wed, 30 Dec 2015 19:44:26 -0500 (EST)
In-Reply-To: <2699825.69Q9PnVUEi@thunderbird> (Stephen & Linda Smith's message
	of "Wed, 30 Dec 2015 17:23:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A486783C-AF57-11E5-AFF3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283224>

Stephen & Linda Smith <ischis2@cox.net> writes:

> [Re-worded my explanation.]
>  
> "revisions, file contents and logs was in the second sentence of the first patch.
> "files and history" was in the first sentence of the first patch.
>
> When I was getting rid of the duplication I decided that "revisions, file contents 
> and logs" was a little more explicit and so decided to keep that wording.
>
> As a secondary reason that is the wording in gitweb.txt.

Makes sense; thanks.
