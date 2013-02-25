From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git 1.8.2 l10n round 3
Date: Mon, 25 Feb 2013 09:47:36 -0800
Message-ID: <7v4nh0z3nr.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHF1MAEcbhhf+PfawTzTxC06LFuZuccyeQUmtf8xXE8ig@mail.gmail.com>
 <CANYiYbHPtW0u80ojHt9xoADVS8S8mVkubb6dUDN_1uwkcTZTww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Tran Ngoc Quan <vnwildman@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 18:48:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA29j-0006xM-MX
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 18:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758662Ab3BYRrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 12:47:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab3BYRri (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 12:47:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4387CA2BD;
	Mon, 25 Feb 2013 12:47:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=uIN8Q+
	inM257jYHSMtImK0jtS+mXtScTT7v5xKVGyUf+cww/9nPsdS2BryFMcSqshxlfrd
	1m7+Z09KOFeCgv0nkQP4h9jL4cnSmAicU3uhiXqClLPXWj2ff8vVRe0M832ULw7i
	1ok/e606wCqpkso3NoFkFS8prpXt3sq8Vf1jg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SlInHQHwmNYq+4K6ZAYXRA/bCcuyfHWx
	+sdqh86qIUlVSF0FneyWOPhLdQRDeNdW8xOdUxOXerLSfFe1oB5MIO8cDwuwkgBk
	wAlgaT1lYIMcSYFWEhFnSEJmW0ynyCq3mZ40dWV/hgs3vi2vN9hT22PjO4/EWgrK
	mzCuPqqFIlc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3883BA2BC;
	Mon, 25 Feb 2013 12:47:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACFD1A2BB; Mon, 25 Feb 2013
 12:47:37 -0500 (EST)
In-Reply-To: <CANYiYbHPtW0u80ojHt9xoADVS8S8mVkubb6dUDN_1uwkcTZTww@mail.gmail.com> (Jiang
 Xin's message of "Mon, 25 Feb 2013 21:24:14 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7186F61C-7F73-11E2-ABAB-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217070>

Thanks.
