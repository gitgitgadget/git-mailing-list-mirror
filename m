From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer
Date: Fri, 06 Nov 2015 09:38:15 -0800
Message-ID: <xmqq1tc33u60.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8qs3upt.fsf@gitster.mtv.corp.google.com>
	<CAAF+z6Ea6CnDLgOsasUtJeYRVhHs6y+Tq3SdBy4JtDhNtoMH5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Xue Fuqiao <xfq.free@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 18:38:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zukxy-0000PV-KH
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 18:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966078AbbKFRiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 12:38:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755836AbbKFRiR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 12:38:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C965627FD4;
	Fri,  6 Nov 2015 12:38:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y+NceM53E0CCQ2bkF799HOKdE38=; b=iB6FBb
	r8B+0M/vV0RCX/ltUsZ+ny6hnRUtBO5oQ67gnO1AcHF3m9WNXjKI88vzKFFYghup
	ZWjflpOhtpuTC0Lup14zM7mLcdtcfzv53lCnRQrAnB3I2f8cU+c7r6q4/4jLOwOE
	ehGjtaLZM+UnKzvaBxVbF/8Q3xS8GE0cFopuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A8Cj9pVtoA8vqQIuDuuyF2hQVrSigHGj
	aiNAJyaBAOyO7IJvImaQvE2PCK7Wkmz0d6bKwJEH3eN8HghBDGo03DNpxgLI9aoQ
	DeyxsNKhyig2x7IO2f7gJ2RdROd3znWcMLKtGgvlHGVg6M+4oYTxZzvQwtPwvm0j
	apmh7Y/lqIA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C19F127FD3;
	Fri,  6 Nov 2015 12:38:16 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3567D27FD2;
	Fri,  6 Nov 2015 12:38:16 -0500 (EST)
In-Reply-To: <CAAF+z6Ea6CnDLgOsasUtJeYRVhHs6y+Tq3SdBy4JtDhNtoMH5Q@mail.gmail.com>
	(Xue Fuqiao's message of "Fri, 6 Nov 2015 18:50:31 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 295510E4-84AD-11E5-91A6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280990>

Thanks.  I've known about the URL moving to marc.info for a long
time, and I am kind of surprised that I had this stale one left
un-updated for so long.

Fixed.
