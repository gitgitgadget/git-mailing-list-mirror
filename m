From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull gitk.git master branch
Date: Tue, 14 Dec 2010 09:09:47 -0800
Message-ID: <7voc8ouvqc.fsf@alter.siamese.dyndns.org>
References: <20101212063135.GA7677@brick.ozlabs.ibm.com>
 <7vwrne8tow.fsf@alter.siamese.dyndns.org>
 <7v7hfe74ea.fsf@alter.siamese.dyndns.org>
 <7vbp4q5ddo.fsf@alter.siamese.dyndns.org>
 <20101213210317.GA10027@brick.ozlabs.ibm.com>
 <7vy67txs7p.fsf@alter.siamese.dyndns.org>
 <20101214090707.GA11890@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Erwin Ittner <alexandre@ittner.com.br>,
	git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 18:10:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSYOA-0003Ds-PN
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 18:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757533Ab0LNRKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 12:10:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501Ab0LNRJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 12:09:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3517A3CA6;
	Tue, 14 Dec 2010 12:10:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eZPxsu/iUxAxQIvl6sU4FwPYth4=; b=xjYums
	adDo69tQB10NduXvd/owhgolIccuuv5BK5G5lN1rFzq/xm3m1E7PX1bSYpBGKIRY
	KIqmbCyNq5cJnxA7vwWrHl8KrfYVH38hUkOhSTNSRMgZTtUhBDhYN+NeoXd2cmYI
	LUMt+J7UXI807tVBnGmdDmSU2OJACr34Y9PII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TZJ9ZYhHUn6069lFtDm1UZNsvqZww1ge
	+kD9Uo03upkkOBnlprdGtaZaFLqmU77TmXB+ck3HRPOSfqWmrmjBcrPUNaoq7uhp
	+BoA9wb7slrQC5nDm92uKlVWalni/Dg0sXmAHbGuO9oCBZOeoBL9cr4ImUzuST3V
	X1mk9MuIAmw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 042AA3CA3;
	Tue, 14 Dec 2010 12:10:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D82883CA2; Tue, 14 Dec 2010
 12:10:15 -0500 (EST)
In-Reply-To: <20101214090707.GA11890@brick.ozlabs.ibm.com> (Paul Mackerras's
 message of "Tue\, 14 Dec 2010 20\:07\:07 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 079BE048-07A5-11E0-B9A0-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163658>

Paul Mackerras <paulus@samba.org> writes:

> OK, I re-did the top commit using the lowercase name.  Please do a
> git pull -f to get the new version of that commit.

Thanks.  Will do.
