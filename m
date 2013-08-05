From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/rev-list-options: add missing word in --*-parents
Date: Mon, 05 Aug 2013 08:47:19 -0700
Message-ID: <7v4nb4nnqw.fsf@alter.siamese.dyndns.org>
References: <1375468807-27007-1-git-send-email-hegge@resisty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Torstein Hegge <hegge@resisty.net>
X-From: git-owner@vger.kernel.org Mon Aug 05 17:47:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6N0K-0001TD-Lf
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674Ab3HEPrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:47:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547Ab3HEPrY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:47:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 993E2364E3;
	Mon,  5 Aug 2013 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=G1/SG5
	ISjDXUZCoun4lyv8Qsu02/2VN5l5JN/L/k3Xvl7gq9fhPoh8d5a5nCTvYhdr8Qn1
	7WZzYAQOv97MbhUXhArEbvChsHkXACd1k7ngOh30ojqh9iBgotw7Yqb2fK3OhiKj
	IPnUmL9BpAx0lrHiKMKYUISlF7gX7/K5q01RM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YNja53O2UgJUMYVUjeQ75U3p0szV2kw8
	CV1LBq5r+sQdM4mmvK5ozqdhUJXBB/ol3zSXl3Cb0H/DVgFhllYgalSHjy9dbPP0
	UDpAY/JcGlSnmPFgaJJ/Uge68SD2jdx/7h1Mg38EbL3894NSHtm6wwfHKvge8Qeu
	O+b7rg+OgHc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 847A0364E2;
	Mon,  5 Aug 2013 15:47:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA603364DE;
	Mon,  5 Aug 2013 15:47:21 +0000 (UTC)
In-Reply-To: <1375468807-27007-1-git-send-email-hegge@resisty.net> (Torstein
	Hegge's message of "Fri, 2 Aug 2013 20:40:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5100FAD6-FDE6-11E2-A219-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231659>

Thanks.
