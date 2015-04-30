From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2015, #04; Mon, 27)
Date: Wed, 29 Apr 2015 18:38:16 -0700
Message-ID: <xmqqlhha2y5z.fsf@gitster.dls.corp.google.com>
References: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com>
	<xmqqbni64kum.fsf@gitster.dls.corp.google.com>
	<55416037.2070501@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Thu Apr 30 03:38:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YndQq-0002yL-D6
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 03:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbbD3BiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 21:38:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751022AbbD3BiT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 21:38:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E5634DD9C;
	Wed, 29 Apr 2015 21:38:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4zyF0HbxPAnRPT+IXhNOfFfPYp8=; b=RsiUs9
	15qB40J8S6Apcn0iHEmp6/y6rFvF46I1/zXoXGV0EaUwBBW2eH6Iw5erOU6gSstM
	2BnR1dxWUANtwA2UTyvhj17B5frMXp4/a733KCv4uJ8MqELvHB5OFCiivU0heXXg
	qMvsVvSJIsw6cQ56bLP1aQidwPGaBwQgvcj7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=knkv6FljUVNFSCZDzIDzTdA96R9QYEYm
	B6V/VlZbqoyLKO1XMvIGa8Qqdf9XB9WokKEda0chS+HpBU5klCqejW0QdWIupaQs
	BVoiDz7gmKjj8Nd6OoA7nvlpeTd9UGsK/nOeB6ED6Vgi3F+feEONBvutdlYVStqw
	rMoAOPie8nI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25CE24DD9B;
	Wed, 29 Apr 2015 21:38:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A12AA4DD98;
	Wed, 29 Apr 2015 21:38:17 -0400 (EDT)
In-Reply-To: <55416037.2070501@posteo.de> (Koosha Khajehmoogahi's message of
	"Thu, 30 Apr 2015 00:50:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 936D5F46-EED9-11E4-9DDE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268049>

Koosha Khajehmoogahi <koosha@posteo.de> writes:

> Sorry for the delay. I will send a new reroll ASAP.

No rush.

I just wanted to make sure none of these is abandoned (and
drop any that is).

Thanks.
