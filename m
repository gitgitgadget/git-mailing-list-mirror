From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual: fix the description of fast-forward
Date: Mon, 26 Oct 2015 13:04:41 -0700
Message-ID: <xmqqfv0xgzvq.fsf@gitster.mtv.corp.google.com>
References: <1445732923-57550-1-git-send-email-xfq.free@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Xue Fuqiao <xfq.free@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:04:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqo0e-0004KC-Jc
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 21:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbbJZUEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 16:04:44 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751626AbbJZUEn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 16:04:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E64D326896;
	Mon, 26 Oct 2015 16:04:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Tznmm7
	9yJjHYhsZvYSwnNIpzNyi3JOpvdjGUxyDrxn/ffqRXXyFRvJ+1Fj9/6FlChMhpYm
	fnY/lmCRwwtQ3tAnrkGs92lvC7rNy6rq+Cfpxii4+JlP3AslaUX/hy//kKzAi/Ba
	m/XooyeFJZeYTrXdtb0nnkOZ0Btq8U5pyd8l8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lLtX/61bEuKss7ERzqiOYwaOpkxvBBYr
	P3dH7KZY6aAtphuO2q1d1hGxJ2p4ASQPkLxT+x6TBHzAzgisw5qZn9hLcZ+5eWJ6
	uQl/3iWFlhcJp3IdSJKnnn9fPMVtpY5KsqLbZLYxoqzIAYVI6K3/WZQgtJMaTgrp
	xHasbaf/6Ls=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DEEE426895;
	Mon, 26 Oct 2015 16:04:42 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6345426894;
	Mon, 26 Oct 2015 16:04:42 -0400 (EDT)
In-Reply-To: <1445732923-57550-1-git-send-email-xfq.free@gmail.com> (Xue
	Fuqiao's message of "Sun, 25 Oct 2015 08:28:43 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CBC3EE16-7C1C-11E5-8F4C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280215>

Thanks.
