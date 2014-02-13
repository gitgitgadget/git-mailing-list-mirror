From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] release notes: typo fixes
Date: Thu, 13 Feb 2014 13:25:23 -0800
Message-ID: <xmqqsirmk8n0.fsf@gitster.dls.corp.google.com>
References: <a19c8a36a99d643ceb3d5b41480db98ca1cf099a.1392287654.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 13 22:25:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE3mo-0001tc-Dw
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 22:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbaBMVZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 16:25:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbaBMVZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 16:25:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB78C6CCC3;
	Thu, 13 Feb 2014 16:25:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/4lFbe8ZRuFUBcYmo83ByW/QmDU=; b=BLX9IP
	96IvG/QHkaPABtNlC9iQT+ZLtsi/eLcyqgEoUdeGlIBcYPAXu7rDI7ZzUOV2BFi9
	yMt2Z4WrRJQnEcwroC2E3jnjdzuur/34JNnDe3y/16EX/Tr5qWuD+S0jV7g8CTeg
	b6b2D7jso9AGX8q/PtsE8XqowudUJXXqIKXZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OPLi4LX76cAox1PpGxZ65lHEXvcvhtpm
	yhdSDHRLVPK9h8GrUp50/VI8amw3QWVo4PGoAalb0oTEC0Liv/2ZqubWzKtpNZfp
	eoS7OZyKGqRqEMnNUsWq1dyrrpL4pTYkJ9RiSYCMw5zHs1HcnGON3Yn4AUt9cZqo
	luXzlZN+9E4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B59256CCC1;
	Thu, 13 Feb 2014 16:25:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EFA76CCBE;
	Thu, 13 Feb 2014 16:25:26 -0500 (EST)
In-Reply-To: <a19c8a36a99d643ceb3d5b41480db98ca1cf099a.1392287654.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Thu, 13 Feb 2014 11:35:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5B0B087C-94F5-11E3-ABCF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242079>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Just a few things I spotted while trying to keep myself informed :)

Thanks.  Very much appreciated.
