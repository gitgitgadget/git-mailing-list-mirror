From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bug reporting
Date: Mon, 29 Aug 2011 13:44:53 -0700
Message-ID: <7vpqjo54my.fsf@alter.siamese.dyndns.org>
References: <20110829132052.0ad7a088@robyn.woti.com>
 <20110829192618.GF756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Jacobs <bjacobs@woti.com>, Scott Chacon <schacon@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 29 22:45:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy8hZ-0003GC-Mc
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab1H2Uo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:44:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53719 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754718Ab1H2Uoz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:44:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4EFF4EA5;
	Mon, 29 Aug 2011 16:44:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q2D7QjM2bjWYpf5DCJ1vduVYYTM=; b=Tb6wDI
	nE1FFdtaD/RckmZolVShkKPrpZKF4KOwPL17OGzqM7CF3FikTzr2fSI0nFe8EQKo
	XOGUhi17e4Fp9GZt7zlNH/NwuCmXfp1MHJcm8CaCH3n2nZ+mAMzPG6hxd4LhCJUl
	Cb/NZvSZPVq8pwXS+yUpuvn/nx4+2odcZe7zM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gB9RARN78O8mP/ak6xTLLZwKCYg1usEd
	VGIAj8m7JpiToNaylZLFm2j49VRFNk518PH+MTcIqjO2YhrdVGD2rNmST5rDwYai
	1LcU0LfEOnI+6kDZ3b2CpwuvYGtMcNk+shL5oHxx4oWg5Rq1XPcxYi4XR/V9cyJb
	0Z7r+PcYKMk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBA354EA4;
	Mon, 29 Aug 2011 16:44:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6367F4EA3; Mon, 29 Aug 2011
 16:44:54 -0400 (EDT)
In-Reply-To: <20110829192618.GF756@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 29 Aug 2011 15:26:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFF35C5C-D27F-11E0-BE0A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180348>

Jeff King <peff@peff.net> writes:

> In the meantime, I've updated:
> ...

Thanks. I've also made sure that the very first paragraph of "A note fromt
he maintainer" talks about it (yes it already does).
