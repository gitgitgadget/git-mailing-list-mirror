From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Refer to git-commit-tree in
 git-filter-branch help
Date: Mon, 27 Sep 2010 15:19:31 -0700
Message-ID: <7vsk0ux218.fsf@alter.siamese.dyndns.org>
References: <1284389994-16892-1-git-send-email-wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 00:19:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0M30-0006Rs-Pu
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 00:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456Ab0I0WTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 18:19:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891Ab0I0WTk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 18:19:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6441DA35E;
	Mon, 27 Sep 2010 18:19:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Bp6E/ylf60cyNoU2J6NI9H8
	MQwl0ay3i8W9YI4B2cvetrxrbRiIQ11BOzdYqaIzCa1Xni2BU8uAaqdt9jjqvvLA
	dyPpejrKGHqZjR7I0pn5TyYbWuFT3kxmngqEnXeLCZolnI6jceaCy0lWjFoB2c8X
	xZB+P6Mb4uMEOcAAFyK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=WaJvz/6sp0rOFh0p7e+5QGM/Vyat1gABgcmukViXAQcf4Zxia
	HsnShEEtbLniBbuU5vTyXhciaUsT5w3nmNNPou6Kxen8W2kv6fNAEILNh8vXgVdh
	PhjRXKrMSWizW1C15VOQrG8d4KGzKRO5nuTovqhv4tN5DOIH33RYv1Hvs8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C28D1DA35B;
	Mon, 27 Sep 2010 18:19:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23F67DA35A; Mon, 27 Sep
 2010 18:19:32 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F80050E-CA85-11DF-884E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157368>

Thanks.
