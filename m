From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: quote braces in {upstream} notation
Date: Wed, 10 Feb 2010 10:06:51 -0800
Message-ID: <7vfx59art0.fsf@alter.siamese.dyndns.org>
References: <a91746a91d0ad0b38a4e49f1f79a056a2d3eac69.1265819421.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 10 19:07:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfGxz-0008HT-5v
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 19:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241Ab0BJSHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 13:07:04 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab0BJSHA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 13:07:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8D5998AED;
	Wed, 10 Feb 2010 13:06:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DObS4IS61UjMO3Sw5x7jMmDT1sI=; b=TehxeN
	9LFy1PIVUHFLa7KxVs+NKN3WAAzPHvP1ocyx0XO9zy37P/Ww8w5KWlrZbgC0aUyj
	0DVk4xER569cx2QdU1Yr/wjvKyCxJmANP2mXJV/sotm4hdtkSlHN3xjDdHhc5rIF
	wmHxqtVcntOIIKVFbzds+NxTUTBRuypFauuQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b+6u52OsuqtugqgpWk6xEQpZ812ve+Gp
	KTHaIjbtGOTghO5sAQSJniU42gPiFhwxiFr1tueN0W5SFcKQHV/2keds3yDZwenW
	Vaoeynm7ASH2UmogmwtejgkiYRknY4BEyb1JusDRD1Sc5KR3KBhsXfGpYjg2hOGS
	s6aNv+cTzlI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96F8298AEB;
	Wed, 10 Feb 2010 13:06:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE6D998AE9; Wed, 10 Feb
 2010 13:06:52 -0500 (EST)
In-Reply-To: <a91746a91d0ad0b38a4e49f1f79a056a2d3eac69.1265819421.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed\, 10 Feb 2010 17\:30\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 12BBDC30-166F-11DF-B016-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139529>

Yikes; thanks for spotting this.
