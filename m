From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull one more gitk commit
Date: Thu, 16 May 2013 16:42:06 -0700
Message-ID: <7v7giy331t.fsf@alter.siamese.dyndns.org>
References: <20130516233141.GB25890@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri May 17 01:42:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud7oM-0000eQ-Qu
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab3EPXmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:42:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551Ab3EPXmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:42:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 217C81F383;
	Thu, 16 May 2013 23:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wm6NeyGXfYwezRJ43/zmvTHglsA=; b=sGGnCt
	CL31nUKbrDskGQoBJ+WQCMRUxhV3S/8qm5up3sDyriz1dCDaU7Fiq2+pzDjOuvPr
	93gJ0u5VZMUlElA+uxWaw2S5YTz0t5j/T034Ynq+u9x0Hi2/2kpsrnK465FKVtM2
	fAoEdgnWJ/E1v99ERUfq8RsbDijJWIVMPtrE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jpyUXKEe4I+dx1+UIX2htCNLGf9s5LR6
	zKExAmOpM0ywtIPB+D9JvDdZ8r22wOAonzUfmzyj5EhoLfVIA5GqvHhQ1A+OcxX7
	x5VTKosj7Biq/35T7WGBKUH+Jkq6ZDtG3NlMHU7Xwy5DXfraK1ECD8mBuoRGxX8d
	K/x5yBoR6KE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14F601F382;
	Thu, 16 May 2013 23:42:09 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92DDC1F380;
	Thu, 16 May 2013 23:42:08 +0000 (UTC)
In-Reply-To: <20130516233141.GB25890@iris.ozlabs.ibm.com> (Paul Mackerras's
	message of "Fri, 17 May 2013 09:31:41 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3903937E-BE82-11E2-86B7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224638>

Paul Mackerras <paulus@samba.org> writes:

> If there is still time to get stuff in for 1.8.3, please pull my
> gitk repository from the usual place to get the update to the
> Swedish translations that I just received from Peter Krefting.

Thanks, will do as the first thing in tomorrow's integration cycle.
