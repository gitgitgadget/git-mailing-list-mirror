From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix typo in documentation of git-svn
Date: Mon, 05 Aug 2013 09:39:24 -0700
Message-ID: <7v61vkm6rn.fsf@alter.siamese.dyndns.org>
References: <51FD159B.30007@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felix Gruber <felgru@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 05 18:39:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Noj-0004Pc-BD
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 18:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab3HEQj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 12:39:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63206 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655Ab3HEQj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 12:39:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9675E36DCD;
	Mon,  5 Aug 2013 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y9G+xxO4xTryNx+GLTmCi0wv7yI=; b=qvriPM
	s4VYCXELOtuLZqJ/qaKp9073oACsuP7g/XbRQZaO4pPLRgUtpETXghF43otxp1qP
	j4w65FW2RUHh+l4g5TDaDxhOk0I7iLw8bv+UzL2A0dxmWAiculRcmVjuyfHzSCV2
	Qxr7OYgU1Pqy38EAOxqXyKhhyUeGoISeK8WoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nH7chKltSxbO++YRZu+k48zToM5G0EqN
	nbz54W1ZYwOV1TYDxZR7jt1G0x4Lu2kIj/sjospzueft99Wjnb9PFC4OARE0papM
	fpAH0GIXd6nL3OGJrXe6XIfPbo/fDHiEldvi4wfFlQ6wtxWZTlmZbGGve647rM9q
	ZCdj0eKuCCM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C5D836DCB;
	Mon,  5 Aug 2013 16:39:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7065E36DC9;
	Mon,  5 Aug 2013 16:39:26 +0000 (UTC)
In-Reply-To: <51FD159B.30007@gmx.de> (Felix Gruber's message of "Sat, 03 Aug
	2013 16:37:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9776749E-FDED-11E2-9CE3-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231675>

Thanks, will apply after fixing whitespace damage to the patch.
