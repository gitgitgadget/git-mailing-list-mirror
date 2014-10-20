From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Allow building Git with Asciidoctor
Date: Mon, 20 Oct 2014 12:08:33 -0700
Message-ID: <xmqqbnp636fi.fsf@gitster.dls.corp.google.com>
References: <1413764438-297386-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 21:08:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgIK1-0001Ez-9K
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 21:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbaJTTIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 15:08:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751176AbaJTTIh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 15:08:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0BB116FB0;
	Mon, 20 Oct 2014 15:08:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yuPLEWi/w2B0S9vGKdAz/MjiOtY=; b=Z3mT7P
	yhIG+zh4q1qcDsqhRVt11qiZSvCLYwSZLzqnaGX0w6RbtWYBC0kPiSG1sryUwhsa
	k+PbYCZikifN0y5dylwc9qPmn3V1CiGfcgAN2gDCBE34Ji7NHkzP3lXxMgzHEICb
	xD7CjrBZ+ro+HHq3RL+d6rRZFMQfVUZNEZiAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uBX9LMXPN8Q+gQPrM5Hv0F3/pQrmAxYm
	ovPkjuvz79qSLs0Gk7eQhzZNoXNzhaOnhttJI9uHgOiqhDx/OJ8rf6uoHE3WK6LN
	JwIC75gpCZ/hBv0AZqyor206eNFemYJy9WdJTbSws3w/IfPC6jvqv1LOsxQAZC8t
	7Wu6mmD7lWY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D860716FAF;
	Mon, 20 Oct 2014 15:08:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7362916FAC;
	Mon, 20 Oct 2014 15:08:34 -0400 (EDT)
In-Reply-To: <1413764438-297386-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Mon, 20 Oct 2014 00:20:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7D0FEAB8-588C-11E4-B6C8-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Too late that the original is already in 'next'.  Care to reroll as
an incremental, plaese?

Thanks.
