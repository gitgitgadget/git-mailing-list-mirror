From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RelNotes/1.7.7: minor fixes
Date: Wed, 07 Sep 2011 16:29:32 -0700
Message-ID: <7vbouw0w4j.fsf@alter.siamese.dyndns.org>
References: <61f2b23c1717455d9b2088b1b8f3350756d757e0.1315396440.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 08 01:29:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1RYq-0000MV-OP
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 01:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757463Ab1IGX3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 19:29:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755892Ab1IGX3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 19:29:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51DCC5637;
	Wed,  7 Sep 2011 19:29:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QIsW9F7VsdNSPl2HjSkscbwRd8w=; b=EjodxX
	qROAYBLzlvFXbVXk5vTZP3ZEV7SgGLPkxWs0euCQ08P74MeSVHMQuvLDcKt76YnK
	pEWcvWh5WMfjFQCfa/AcOzr3VqrZf9b09YAha250B+GAcKIEO+rjBd15Mu93fNuf
	dK7GhlitwOWyOhjSe/FFUqiWaOHxu4JIVEx7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=shiMG429ir2aMw+47o6gl/kLpd0zKklm
	DKltjbB+s3QJF+baRkDTn7Hgs/NAzFWDcJrl25roX4V79k2YxwQIiHUS5q4N8++s
	YvC1MlpJANf6XB4V66+3IgyrvoWdvwpKM26bttL3uhvakrKF5OOFPfszg3LA2imK
	Zaleh/cXwNw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ABAC5636;
	Wed,  7 Sep 2011 19:29:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C39DA5635; Wed,  7 Sep 2011
 19:29:33 -0400 (EDT)
In-Reply-To: <61f2b23c1717455d9b2088b1b8f3350756d757e0.1315396440.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed, 7 Sep 2011 13:54:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E3ECEB8-D9A9-11E0-9755-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180928>

Thanks, I obviously kant speel.
