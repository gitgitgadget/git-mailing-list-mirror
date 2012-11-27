From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support for git aliasing for tcsh completion
Date: Tue, 27 Nov 2012 09:16:27 -0800
Message-ID: <7v38zvnez8.fsf@alter.siamese.dyndns.org>
References: <1353989472-4142-1-git-send-email-marc.khouzam@gmail.com>
 <CAFj1UpE5V5fKtt0fFOXLPrsQdOL8xpvzT=66Qi3=cMHit092Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:16:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdOm5-0005RV-Pu
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868Ab2K0RQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:16:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab2K0RQa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 12:16:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9B90923D;
	Tue, 27 Nov 2012 12:16:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kFpPeDdHvkYPxINT6fOns10abwg=; b=FX7G41
	x5Lgyq81DxAnHoaeqCAaXhzhw1HjDoZ/SETv6AgCfQxUT2lFyb47HJh1vSc8aJKG
	Ha/o6ppQ7pMFiEqxOufUXztVdAQSgZcHSByBjLxo6FMtbqHUw1BYtLtCuJvaNN09
	5Y26/YJCBYmQ4CJXgfeJOBcdZLN5VKmrFOPko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=STOLLUOuzcUewWBJyRfxVJ3aWX5DS018
	7m4rt+igMwGaaDt+5waR7oBnsgHTa7qmKJEOdfyjrxNcvr7w3mps58YOGsuDeTUn
	JWrf9WJ+MVvXZbApBh/NyTc6Ndg5nv4BUpZfTpXK/rB8OmPYX//zjLwSQ8dnkr2g
	xvYKRsbF58w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5896923C;
	Tue, 27 Nov 2012 12:16:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2762A9239; Tue, 27 Nov 2012
 12:16:29 -0500 (EST)
In-Reply-To: <CAFj1UpE5V5fKtt0fFOXLPrsQdOL8xpvzT=66Qi3=cMHit092Rg@mail.gmail.com> (Marc
 Khouzam's message of "Mon, 26 Nov 2012 23:13:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E9BCE6C-38B6-11E2-9406-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210567>

The patch was linewrapped so I had to fix it up; please double check
what will be queued on 'pu' to make sure that I did not miss
necessary whitespaces or added unnecessary ones when I rejoined long
lines.

Thanks.
