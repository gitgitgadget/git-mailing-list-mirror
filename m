From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hold your fire, please
Date: Fri, 28 Dec 2012 15:52:48 -0800
Message-ID: <7vehi9hgz3.fsf@alter.siamese.dyndns.org>
References: <7vd2y1rix1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 29 00:54:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TojlN-0005MW-Og
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 00:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101Ab2L1Xwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 18:52:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754236Ab2L1Xwx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 18:52:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42BC2990C;
	Fri, 28 Dec 2012 18:52:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y2erdKnNXRZVR7Uhbn7gQAfpMwc=; b=xZ8BdU
	2Ma/itHn5E5Xa6Mz6kMUOkOk9jy2C+zCLVu7FqitPOt/8L9QzWjujub8+85OWW0K
	muhLrRYUi55H5WdCsEXLkfZ7Q2REqTbJCFfXGrhDW1ePHEgPpZQh3S/8cgWXGn/R
	LNQO/zFc5tZJd3LgQbeDfy8t6yGCuyDvykQk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WhPFwIaUx5L3XXbwPGrmoDs8aeaQ+Wah
	Yeq6bxN8XfgbnUg2J1sRnxKMTxZUyoCScv60M5CsgADyYIgr7hqwQy8/sbIT+m6o
	gVO4ogLLIGIiXKB8boAdZX8oSDc3HGUlFZP87xblxdX7OfH+FgM1h3Z2ngP6+ZRd
	h81TVuZ4FQw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31217990B;
	Fri, 28 Dec 2012 18:52:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A56879909; Fri, 28 Dec 2012
 18:52:51 -0500 (EST)
In-Reply-To: <7vd2y1rix1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 22 Dec 2012 11:22:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0E5C46C-5149-11E2-B04A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212276>

Junio C Hamano <gitster@pobox.com> writes:

> Primarily in order to force me concentrate on the releng for the
> upcoming release, and also to encourage contributors to focus on
> finding and fixing any last minute regressions (rather than
> distracting others by showing publicly scratching their itches), I
> won't be queuing any patch that is not a regression fix, at least
> for the next few days.  I may not even review them.
>
> Thanks.
>
> And have a nice holiday if you are in areas where it is a holiday
> season ;-)

Just as a friendly reminder, I am reposting this to remind people.
