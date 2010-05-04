From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: Add explicit license detail, with change
 from GPLv2 to GPLv2+.
Date: Tue, 04 May 2010 10:02:12 -0700
Message-ID: <7vocgvmwh7.fsf@alter.siamese.dyndns.org>
References: <87vdbi37yp.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Tue May 04 19:02:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9LVx-0001h8-S7
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 19:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759827Ab0EDRC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 13:02:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab0EDRCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 13:02:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE4AFB009B;
	Tue,  4 May 2010 13:02:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rVNlbuW6ng8UCLR2FNmtbEBU6Pg=; b=tVlBvZ
	xim8rDsG0okX5CgXEKUR0hmLsWH6nHg7q9cuI3i1nSOcyZR9gAxnMcB+Eouzpvk9
	R/PZEaHOC81FBr5Oz1A2JAOOQQcaiFzHnIqblZaeOlyncKOgLojfE+RJQWw/Psln
	CYDb3EjxdcgwscMx67g3gef5gQ/1t1GlIOuGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hRyoS0hyVhBOBXZ0pr/4AdkIagUDKjzk
	PNAo5S99oC2aHYtkqgePjrJQGf7opUMBYtnspLNbSxN3qmNPlMAYRrgMAZiYBTnC
	q2caq4ZvXEkqZlCVpA14WpVdr2CxNEoAtGaLe1YMvsOE5LguSmT+oTjoihZMs46g
	RKU5eFSKxs8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A2465B0095;
	Tue,  4 May 2010 13:02:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D3CBB008E; Tue,  4 May
 2010 13:02:13 -0400 (EDT)
In-Reply-To: <87vdbi37yp.fsf@steelpick.2x.cz> (Michal Sojka's message of
 "Fri\, 16 Apr 2010 15\:53\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE8E3A0A-579E-11DF-8DEE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146329>

It appears that I forgot to apply this; sorry.
