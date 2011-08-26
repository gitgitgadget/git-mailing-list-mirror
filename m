From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 5/5] branch: allow pattern arguments
Date: Fri, 26 Aug 2011 11:45:03 -0700
Message-ID: <7vzkiwc8r4.fsf@alter.siamese.dyndns.org>
References: <20110825175301.GC519@sigill.intra.peff.net>
 <b4a43ac3686d66b3ef8eddbed2c98c56b6f13312.1314367414.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 20:45:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx1PE-0002Xj-FL
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 20:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab1HZSpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 14:45:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983Ab1HZSpK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 14:45:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3C504FAD;
	Fri, 26 Aug 2011 14:45:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V/hokFYGXYJD1CyZOwMkULROnk8=; b=JQRZCQ
	jhleZNM3GeVNGYuirAYnlsKfodfktL8kjJPw1vGU/eILvAo87Y4EyYF3/gW2ZHjw
	ClyjExvr1B1AvvT6Hz45ZNrFaNHY/rsvdzp0iFePamDs28wap9w2IhkBGlJMWtwo
	NWhZsp5YiOa7FCw5NL7GbpTKbeo9F9ikwKDxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ezpkQMizmhzBmU3BCiewVpDDz7RLmw7b
	Ks5kUZgKoQnnIVXZeN1R+c+w52OE2RD2u/xQzjiUm6uvDO/hNa565isMmPYz6hSG
	7vtvp92ki/q5pNqjlRUyfNUlzi3LCYfCM+uZ0SXcqHGIjExLo/qXupWf7RWrFgTO
	fwTEOQQKG1s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B60A4FAC;
	Fri, 26 Aug 2011 14:45:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13BD94FAB; Fri, 26 Aug 2011
 14:45:04 -0400 (EDT)
In-Reply-To: <b4a43ac3686d66b3ef8eddbed2c98c56b6f13312.1314367414.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 26 Aug 2011 16:05:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8389EEFC-D013-11E0-AABF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180188>

This and [4/5] both looked good; will update mg/branch-list with this
round.

Thanks.


 
