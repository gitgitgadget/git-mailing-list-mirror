From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: do not display fetch usage on --help-all
Date: Mon, 14 Feb 2011 15:10:14 -0800
Message-ID: <7vr5baqkkp.fsf@alter.siamese.dyndns.org>
References: <c98bbd60ccdbe059811280e09951100611487ccf.1297702066.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 00:10:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp7Yq-00078l-2D
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 00:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab1BNXKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 18:10:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab1BNXKW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 18:10:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25D293EA6;
	Mon, 14 Feb 2011 18:11:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h9hWfNivXGKDwQOfC8aDrZ/D9ak=; b=V2SQpW
	ovuskyjRxgxBRS2w45O20lTogqnjQh8sZDkj3AyR9fMrf3GxMsMN67nf8ae1d+r5
	OCt5lQeLrG9tHB11IkYPVtnuKAj4hQqsORglZvKTLO3zJCNuRLXp1eC2yNm/6kwp
	8DaACPCwepHGc5gcZv7tAwDqvUuIYLaRJfHTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CAlmbmg6QX28lQfJ5GMM9WNdxsAmxxjA
	ohtAr8EcjnQ/C/Hqyuj1gACMig2hOKmAmStXu7JuGSkmd1ZDLyxG4tkN6KRId4zl
	+jpoBy3sKhr2uL/5Rv6uvGgO5vBQ/TdKWQILhUFUNrWovL1HShwsQoBzr4mY7Q2K
	ZBwQNd86G28=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 022E33EA5;
	Mon, 14 Feb 2011 18:11:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 281073EA4; Mon, 14 Feb 2011
 18:11:19 -0500 (EST)
In-Reply-To: <c98bbd60ccdbe059811280e09951100611487ccf.1297702066.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 14 Feb 2011 17\:48\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BD5E80AA-388F-11E0-BD80-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166792>

Thanks, will apply.
