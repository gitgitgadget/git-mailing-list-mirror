From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation/submodule: add command references and
 update options
Date: Mon, 01 Aug 2011 15:34:48 -0700
Message-ID: <7vr554hibb.fsf@alter.siamese.dyndns.org>
References: <4E371151.4040407@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nikolai Weibull <now@bitwi.se>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 02 00:34:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo14Z-000309-NM
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 00:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab1HAWew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 18:34:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783Ab1HAWev (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 18:34:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4C2C5E8E;
	Mon,  1 Aug 2011 18:34:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9rqItJ/kwuh5gSf9NwI6JCwVKMk=; b=OoDO7g
	7iPlHsPeYpXIJLL5YKNqJ3+jHmjcBts//UogIiMu5Ef9cIZWFF3kOwBBCJh4w0eu
	icuz7crgY1FUYgOQbGRiVP5HWYn6o2yfM49TdloMEGmWmC5XborBF8FkIWTZveVU
	Mue11LjhxD4h4eoh6fvNu5pyF7Wjych+q7m6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T9hSzKKw4mrzxQe8l31QlKRriLup7Xl9
	sfDprn+bABJv5pvePyPJzsJ9wrX9GySs1chNkTyXJOBuY7a3a0VVyM/DyFQ490Gj
	guCaPhj/NiQOaEvgjztwmNkRyWSCtwvSvbjt0CUgw//t3a9pHFPIOg0egt9dJd/P
	LLv0xceSKO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CC3C5E8D;
	Mon,  1 Aug 2011 18:34:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31BF55E8C; Mon,  1 Aug 2011
 18:34:50 -0400 (EDT)
In-Reply-To: <4E371151.4040407@web.de> (Jens Lehmann's message of "Mon, 01
 Aug 2011 22:49:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77C8E9F8-BC8E-11E0-8B64-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178424>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Reference the "git diff" and "git status" commands where they learned
> functionality that in earlier git versions was only available through the
> 'summary' and 'status' subcommands of "git submodule".

Thanks; will queue.
