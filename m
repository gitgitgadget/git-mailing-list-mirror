From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add gitk-git Hungarian translation
Date: Sun, 13 Dec 2009 20:43:00 -0800
Message-ID: <7vocm2jhd7.fsf@alter.siamese.dyndns.org>
References: <1258284204-17247-1-git-send-email-djszapi@archlinux.us>
 <19205.2740.244981.703612@cargo.ozlabs.ibm.com>
 <a362e8010911220005u1783cd44yf84ae5bc5b42d980@mail.gmail.com>
 <a362e8010911281833p58058a06sbe305d61709ac051@mail.gmail.com>
 <a362e8010912131030v4c1ef231r7246d7291f6a5677@mail.gmail.com>
 <20091213230305.GA8135@brick.ozlabs.ibm.com>
 <7vskbejmrw.fsf@alter.siamese.dyndns.org> <20091214032816.GB24152@drongo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Laszlo Papp <djszapi@archlinux.us>,
	Laszlo Papp <djszapi2@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 05:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK2mO-0000ND-NK
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 05:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491AbZLNEnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2009 23:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756283AbZLNEnX
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 23:43:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090AbZLNEnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2009 23:43:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF94B87EB4;
	Sun, 13 Dec 2009 23:43:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h9Ot4v2W0KT/IAc+reCwQB1L4c8=; b=E1ejc/
	sadsMnOkFP/zeq+4XerQ89S/0oL1wrTLfPbna2xqbcqHb6GuZTZP41bDX6jQIbRT
	9Vnts0gfn+DcKbo3TCCrqlfSTc0DhpiQCVrf7ln8/k9Cesxc87MCkEJebfjXHKes
	+O0+k4vjnrRXXPATXyhY8+/DtTun+cJWCezjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HbkKJp4zwUOghJuAki/lKn27r49CXPDV
	lPIc4M6VXqfJJHV+3fssA74hOJKrkTqGJYs0WQWAAX/kg+RBICRPBdPK7bjtUpD2
	BzXnAQlkfcSAEdNH4XKW3fB1Xf3BRIM4E6+QbAs/HLufvNcl2P1k3rIofcC0EpZn
	XXkSkxpaNdk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74EE887EAD;
	Sun, 13 Dec 2009 23:43:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90F3387EAC; Sun, 13 Dec
 2009 23:43:02 -0500 (EST)
In-Reply-To: <20091214032816.GB24152@drongo> (Paul Mackerras's message of
 "Mon\, 14 Dec 2009 14\:28\:16 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2D28CDD0-E86B-11DE-B461-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135167>

Paul Mackerras <paulus@samba.org> writes:

> I also don't read any Hungarian, which is why I didn't want to try to
> fix up problems that were more than just MUA line-wrapping.  As you
> say, if a Hungarian speaker can verify that your fix is correct, we
> could fix up the original patch.  A clean re-post with a suitable
> subject would be nicer, though.

You are right on all counts (the breakage was inside the editor of the
author before the commit was made, the "fix-up" is more than just a MUA
breakage, and a clean re-post with a proper title would be nicer).

Thanks.
