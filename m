From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 v2] user-manual: Document that "git merge" doesn't
 like uncommited changes.
Date: Sun, 22 Nov 2009 16:08:17 -0800
Message-ID: <7vpr7aayry.fsf@alter.siamese.dyndns.org>
References: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
 <1258928778-32419-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Nov 23 01:08:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCMTr-00009a-Eh
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 01:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884AbZKWAIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 19:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755855AbZKWAIW
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 19:08:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbZKWAIW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 19:08:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EFFF828D0;
	Sun, 22 Nov 2009 19:08:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pQrbVQb/xWbX3kobDOQaXaIUMSw=; b=YAJ2VU
	gnMzvmkEjIlT5Safd1oZk0/0x8FEfNLpmmLJPy4Hxbqr4kEZES/whP/F8m4IAFwb
	hEKrIxUADockWbfdazEjEmpDiqbLH3IMQO+oTxoCKHVQco0WcDS7xDOMTpfy+fJH
	RbrvtoLh1x/Ybq7Ld1jm8t85lxj5GXNsCqesI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=chqWSd4OM9slzo0W3wItK3ViRgtPYMhg
	JTgCjDES9yAs45Qp/pV7WDZlAphYjWzB3YofgYjlPSw3gkHpGfgezPaGMKbMjSYD
	7XJuX4voBOpxapejiIkH6QwUAY8kLYJlJsYLXzUyt7kt73MvilZukQ3Cu6IEPs4B
	oJFd1wmRZBA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5D1B828CF;
	Sun, 22 Nov 2009 19:08:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4E90828CE; Sun, 22 Nov
 2009 19:08:18 -0500 (EST)
In-Reply-To: <1258928778-32419-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Sun\, 22 Nov 2009 23\:26\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F96034A-D7C4-11DE-A291-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133470>

Looks much nicer; thanks.

Will queue.
