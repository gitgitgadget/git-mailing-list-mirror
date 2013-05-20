From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 00/15] Interactive git-clean
Date: Mon, 20 May 2013 15:48:45 -0700
Message-ID: <7vk3mts1wy.fsf@alter.siamese.dyndns.org>
References: <cover.1368782129.git.worldhello.net@gmail.com>
	<cover.1368846844.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 00:48:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYsw-0002hd-3i
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758447Ab3ETWst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:48:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757248Ab3ETWss (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:48:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D11302038D;
	Mon, 20 May 2013 22:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=FlxCgdN8+uxJE2oweO/AW8pBWmQ=; b=wNaD1SBf6YoRKwrrR++L
	WIYIxPMbS5/640jiA/nLLPcVS5jfFG6rxLnIfeto7XH/ZxWzI3mzFr1Su6ISE3rt
	AiDt4MnE0Kh2ofEW44u87cwxKhSlLPzpBEbLP0ev5y6luWEUoFu1nF7P3/0FNtKA
	PmylIkT/CGwQHCxu6atl8W8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dj+D8Nx839uS33CZgeGyxf8aVYPOMiW7VuTYOYubZc32j7
	O0K6coTyQdJf4F2qES5rhMCskymNNG7fnZY3UuSpY5TzvdbUaHhNgV14sAr1nTi/
	UcnWiOyoIVtSxsDNdhttqYL+oLTnt8qzELSO5II/3bzQkBsnlWdf9J5k5RwME=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C91742038B;
	Mon, 20 May 2013 22:48:47 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53F6820388;
	Mon, 20 May 2013 22:48:47 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E91897C-C19F-11E2-9251-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224996>

Will replace what has been queued on 'pu' with trivial style fixups
(haven't had a chance to make time to read it through).  Thanks.
