From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] updates to gitk, git-gui and git-svn for 2.8?
Date: Sun, 20 Mar 2016 18:05:24 -0700
Message-ID: <xmqqbn68od2j.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1qwaopd.fsf@gitster.mtv.corp.google.com>
	<20160319070424.GI27126@fergus.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Paul Mackerras <paulus@ozlabs.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 02:05:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahoHl-0005Wg-9H
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 02:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbcCUBF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 21:05:28 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750957AbcCUBF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 21:05:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B6A8D4F996;
	Sun, 20 Mar 2016 21:05:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Sqj/t9VewM4SPIXpWasYLd2B6Q=; b=tyBdNm
	3FSC7BxABwm7/nTFjoX/EUcwyy/6zcIHgy08Wv5hSrQlRY+tnbnAZ2ju8+p3vDr3
	7UND9ZypdxteDGpZylwNdYYBfS23PdTS9DEzW36RYsM0QZekBBVavR0CW3pYLuTM
	pPIq/DG6grHhKdUzgDXH7siNXDVmWpgu5l66A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z31NTTQbxX1f1j94oYJ+9ccwSMfZ4c8R
	ze4gEY6Cqan3F3LvfdDPNvvd8xiZP0za9ZTy1gEeV2cHCdjEWdzoqCAZ9QTBqosF
	3TVE87lQWobvgn4eSOGPTq4czi4bbiHAc4QPZgnHvoPu7A++iJ6+tmIRF2+Wr3q1
	+c36SyTEjH4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC9BD4F995;
	Sun, 20 Mar 2016 21:05:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2E3634F992;
	Sun, 20 Mar 2016 21:05:25 -0400 (EDT)
In-Reply-To: <20160319070424.GI27126@fergus.ozlabs.ibm.com> (Paul Mackerras's
	message of "Sat, 19 Mar 2016 18:04:24 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE73ADFE-EF00-11E5-B086-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289393>

Thanks, will do.
