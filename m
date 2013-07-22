From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] Update po/ja.po
Date: Mon, 22 Jul 2013 16:37:46 -0700
Message-ID: <7v7ggi9ned.fsf@alter.siamese.dyndns.org>
References: <CAPM==HJ4pTrb5cp0gNNef3PDdk5Sae-aw0ADzsb7zOY4VjDMVA@mail.gmail.com>
	<7vsiz69qfh.fsf@alter.siamese.dyndns.org>
	<CAPM==H+_rpNojKjJe3-fJSXp0_8ishws=N7BsU7TJpfr2yG31A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Yamada Saburo <devil.tamachan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 01:37:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Pfu-0003Vx-2v
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 01:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab3GVXhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 19:37:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626Ab3GVXht (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 19:37:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B30D32905D;
	Mon, 22 Jul 2013 23:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GJCIBdsr4KP9MbrUv1iIE8Dd/H8=; b=lqJUKd
	HKeH+KXBMxdIwbQxj86zvD/aSmPuA9akTNkbP+rnbzcjm3OUfoBqtwfBytMbvPyZ
	H5Ar9LTXrk+1S+xOmemJD7O0ymd31HDpKqc+LUNxrt7TW3rq1iT7sECWwhb6m+3T
	8UYa9nNoEkBmvA5CCiGk9Ii20lackIuxZlP+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=igc3mGOkc3foMkrdDTFGyL1GDUkN9eou
	RXZy2Jn8VGltF6fElwW2R5UN9tuSjxGJc90Xjcizedr+WXXSgWt9Ewk1j8dobGW0
	61CHUI6xgvB2mN4A78x2TYGR26YOBYMVIFN0vQSyck3KBgc792TUhJvpjW8tUHB+
	aDr1VUX7+WA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A69BB2905C;
	Mon, 22 Jul 2013 23:37:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F22A2905B;
	Mon, 22 Jul 2013 23:37:47 +0000 (UTC)
In-Reply-To: <CAPM==H+_rpNojKjJe3-fJSXp0_8ishws=N7BsU7TJpfr2yG31A@mail.gmail.com>
	(Yamada Saburo's message of "Tue, 23 Jul 2013 07:58:33 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B765E45E-F327-11E2-84D6-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231012>

Yamada Saburo <devil.tamachan@gmail.com> writes:

> Is free translation impossible?

Sorry, I do not understand the question.  Aren't you helping us with
that?

> I want to give priority to ease of use.
> Does Mr. Hamano know that it is said that Japanese translation of
> Git-gui is very unclear?

Yes.  Aren't we trying to make things better?

> It is wonderful that my translation is
> severely examined so far by me compared with a former translator.

Sorry, I am not sure what you mean by that.  Past mistakes by others
are not a good excuse for doing shoddy job this time, especially
when you are trying to make things better, no?
