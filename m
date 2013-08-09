From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] .mailmap: mark bouncing email addresses
Date: Fri, 09 Aug 2013 16:19:20 -0700
Message-ID: <7vwqnu311j.fsf@alter.siamese.dyndns.org>
References: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com>
	<1376072305-15255-3-git-send-email-stefanbeller@googlemail.com>
	<20130809200101.GX14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org,
	<apw@debian.org>, <daniel.trstenjak@gmail.com>, <axboe@kernel.dk>,
	<rutger.nijlunsing@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 01:19:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7vxz-000464-2w
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 01:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031498Ab3HIXT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 19:19:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031447Ab3HIXT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 19:19:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADF1F3712C;
	Fri,  9 Aug 2013 23:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=817E09OpCG6L2+/62GAZVhFugWQ=; b=dyfypM
	NgMZn+qeH2sDw2qWa2pn17MezHo3hSt1X5PoywJ7qQenoMNpQpb2mf+B4YKzX4zn
	3B0uVQi3zCV2szJKwzno4Qf4875afpoEor0XVcl5jx+SafDLGAYNHRC0KZGiepE5
	A+YsBiVwdcSGwg5d6Zw5IrsDzIpie51PhrWWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iYyM05bpoqhYV0/MpbasKNRICaboejBD
	a1IUngc0mSNH68WcmqUW3ub34+Tg5C9bUJR9GCdjNQgVSRQSkw+XPgDA5gKAUC+e
	i5E/LEMJx+3oY5YTqyXSURR8MuTFPmBoiU6mEa8/keKMuIoiYsTP6YcZigfM7BDW
	9Snz4NXG20g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A15823712B;
	Fri,  9 Aug 2013 23:19:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78B5E3712A;
	Fri,  9 Aug 2013 23:19:24 +0000 (UTC)
In-Reply-To: <20130809200101.GX14690@google.com> (Jonathan Nieder's message of
	"Fri, 9 Aug 2013 13:01:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 210EB662-014A-11E3-896A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232052>

Jonathan Nieder <jrnieder@gmail.com> writes:

> From a quick search for homepages:

Thanks for digging.

So I'll discard this patch for now, and instead send this message
CC'ed to these guessed addresses.

-- >8 --

Dear Amos, Daniel, Jason, Jens, and Rutger:

    our record indicates that you contributed to our project (Git --
    distributed source control system) in the past under more than
    two e-mail addresses, all of which now seem to be defunct.

    We would want to keep our .mailmap up-to-date, primarily in
    order to consolidate these multiple entries for each of you into
    one.  Could you tell us your preferred e-mail address your
    contributions are listed as?  This message is sent to our best
    current guess of your address.

    Thanks.
