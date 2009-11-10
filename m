From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/24] check-ref-format: update usage string
Date: Tue, 10 Nov 2009 12:11:23 -0800
Message-ID: <7v4op287is.fsf@alter.siamese.dyndns.org>
References: <20091109150235.GA23871@progeny.tock>
 <1257779104-23884-7-git-send-email-jrnieder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 21:11:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7x3z-0000JA-6k
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 21:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758016AbZKJUL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 15:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757992AbZKJUL0
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 15:11:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757989AbZKJUL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 15:11:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6820D9A9D4;
	Tue, 10 Nov 2009 15:11:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=v6kTxL/jzpjgOL/mI7SJp+Mbj04=; b=A1rnTi8aWaF6ho3ArOXAizb
	8+vKv193Rm22H0D4cENz/4MdVrCN+vGm2NtOJDiLAVOVUaFr1n3eZY7E/etBowxZ
	hZnvLPqWyRkTz1Z68DvWbfQvpoxFB494+JxsE2Rm8cy09uvKTdILDncC79sa6Ve7
	WpbIcJ8NxclSGznPchj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=o5Zz/Xjv4b4/8GzepMacx2Hpj/QwMZKsdQaeUTA+aR6JAvGN/
	oowAHyV2oj5rGVsP4vUYKfcAzd05tUJQY37PHrFLmmieIcwn/e+ah2blCTCXUmmy
	FkdzFehyw6N0uuu7gfoAkAgC4Sz4Y+ORKPpSnkyAjxi/ylCSLfGH6wppiU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A0C49A9D3;
	Tue, 10 Nov 2009 15:11:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5256B9A9D1; Tue, 10 Nov 2009
 15:11:25 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3ACA257E-CE35-11DE-8336-BD45BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132589>

This deserves to go to maint, so I ejected it out of the series.

Thanks.
