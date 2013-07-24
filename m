From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .mailmap: combine more (email, name) to individual persons
Date: Wed, 24 Jul 2013 16:04:50 -0700
Message-ID: <7v4nbj5zl9.fsf@alter.siamese.dyndns.org>
References: <1374688518-13563-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 25 01:04:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2877-0006tc-F3
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 01:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab3GXXEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 19:04:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60782 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805Ab3GXXEx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 19:04:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7F14334ED;
	Wed, 24 Jul 2013 23:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+eWgJyyk3PEXsDGMvgMtgcUUCAk=; b=gLXAnm
	u1xlyc848tG9stFYBtv7GPyd/jG4NVdaJhbGdz/YE52OX5PCTAc/x5Smo/e2hXam
	s+0H71fGKgP70/2w4ADvcdAV+0KaYU7nCYvrWCUqzs+nJUDoWDm0Wtk83v08zyVk
	we0x9h4ydkqQ20BL6Folc3xGqDOFz/b9IF6IE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aqpZbrOaLPoNsEkdfDAiInwaiMtZqcne
	xDYa3+GZE/EmDEKMQBR50mgAs0Th9oTCsMcjYJAFBwygSXvi9vJJo6guIr1KNOAz
	zvJtkZM9Pj4TcGsMYLdFreIlJ/jInV8Qb4h+/2j33wFTqb91LOIqNK633fdmtAuk
	3pdO6Xua7QA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCCFE334EC;
	Wed, 24 Jul 2013 23:04:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E43C334EA;
	Wed, 24 Jul 2013 23:04:52 +0000 (UTC)
In-Reply-To: <1374688518-13563-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Wed, 24 Jul 2013 19:55:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7282E6CC-F4B5-11E2-B171-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231122>

Thanks!
