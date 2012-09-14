From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] rev-list/log: document logic with several limiting options
Date: Fri, 14 Sep 2012 10:21:07 +0200
Message-ID: <5052E8F3.2030305@drmicha.warpmail.net>
References: <b23f3c547358b79731c7a25d9ac496138e6ab74d.1347374615.git.git@drmicha.warpmail.net> <7vsjaoil6d.fsf@alter.siamese.dyndns.org> <50509171.9060604@drmicha.warpmail.net> <7vbohbdufz.fsf@alter.siamese.dyndns.org> <50518B13.5010702@drmicha.warpmail.net> <7vvcfh62l3.fsf@alter.siamese.dyndns.org> <5052E0D8.3040500@drmicha.warpmail.net> <5052E1C2.1050008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 10:21:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCR9S-00087j-IH
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 10:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991Ab2INIVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 04:21:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39452 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756751Ab2INIVJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 04:21:09 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EB294202CF;
	Fri, 14 Sep 2012 04:21:08 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 14 Sep 2012 04:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=R7G34hUZkNipDNRW/ikCl3
	X2D6s=; b=SyTYr6dY/nTCsA3NE3MPxYN0KySHulg+raaEwwOZYvgmk7uRG2/92/
	MCGZfgZBBZfWrRpsyYM2wsL68HaF3R+KY4g/MtgbO59OPf5qmGrCWjO0yuwZbD0Y
	N2hdd0HgS7ALeaOQ/Fx14/LUhWOllb6pTxKhzoru5DVMwgIvwOLr4=
X-Sasl-enc: g0Dd2DYB5vX6df3aZgR/RQAjp6ZqNeS/ha9DBhIeq8C+ 1347610868
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 767DE4837F4;
	Fri, 14 Sep 2012 04:21:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <5052E1C2.1050008@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205465>

Oh, my gosh, it's not as early as this indicates, rather coffein
depletion already:

> Message-ID: <5052E1C2.1050008@pobox.com>
> Date: Fri, 14 Sep 2012 09:50:26 +0200
> From: Junio C Hamano <gitster@pobox.com>
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0

[no, that Thunderbird user isn't Junio]

> MIME-Version: 1.0
> To: Michael J Gruber <git@drmicha.warpmail.net>
> CC: git@vger.kernel.org
> Subject: Re: [PATCH] rev-list/log: document logic with several limiting options

> Michael J Gruber venit, vidit, dixit 14.09.2012 09:46:
> [snipped, just adding]
> 
> ...and maybe the meaning of "(or ...)" and "*or*" isn't what I think it
> is either?

[and that confused persion isn't Junio either]

I didn't mean to imposter Junio. Something went wrong with "virtual
identity" choosing the From: address. Terribly sorry.

Michael (really...)
