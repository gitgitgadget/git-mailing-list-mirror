From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git symbolic-ref: documentation fix
Date: Fri, 09 Dec 2011 10:07:25 -0800
Message-ID: <7vd3bxebnk.fsf@alter.siamese.dyndns.org>
References: <1323271216-18237-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Dec 09 21:24:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6zu-0001GN-2r
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab1LIUYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:24:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab1LIUYd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:24:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 828E4665F;
	Fri,  9 Dec 2011 15:24:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=sd1/N+gsfXrC/WnpD4NY
	ffz9d/re2pRlaT+sdWc5dqQcl4ScwJEjw+dCy/9EJMYLr/IFdr36kGMkyhDCRjHj
	/hX2PEWSsbYFxX14wl9jrWcNr0k8SIBldqDGjalCITaxMcLVEMKE+FiVzIIPe0un
	ChNMIbGVBckIU9A49B/NhWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=py7YlpZJcj4rqbor6dzoxKdCcmLhNgwFAIJH4TkgvpF2l4
	1KpcJ300APM/5ziDBuRB4EDsfj5nuMSvCZjznMzA1uHP8bOleqoAo2Py8GcjtXRu
	ngjHfdtOu+pyd9bxbKo6WvcUE7zfrUpg6HMsf0KQ4ve7gtvY8NGZZ1wznhDkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 794CF665E;
	Fri,  9 Dec 2011 15:24:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13C1A665D; Fri,  9 Dec 2011
 15:24:32 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE1E2608-22A3-11E1-9816-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186686>

Thanks; will queue.
