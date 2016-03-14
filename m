From: Junio C Hamano <gitster@pobox.com>
Subject: [Q] updates to gitk, git-gui and git-svn for 2.8?
Date: Mon, 14 Mar 2016 11:39:42 -0700
Message-ID: <xmqqd1qwaopd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Mar 14 19:39:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afXPC-0005yN-Al
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 19:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbcCNSjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 14:39:46 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752118AbcCNSjp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 14:39:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83A404BDD3;
	Mon, 14 Mar 2016 14:39:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=U
	2M2NDsZL6qRRxVGQ6ri9lJRCqU=; b=ZJf/OJ2Tv256QfmLegi/Pcvu1BIC3/E8f
	EzCZlQYUiJwTK/jPtkzAN/tRsrvb6hiJW+q4Cq8JFC+RVPzbwB0AX7KtF8l9vlf/
	Q2qYF7LtkxjJyoF3yasq4daHkD39QKgJWbrlAMfR/zO9V4ie1RDlsFoXVQm8eaac
	2iNTu6mU2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=NO9MYTU3353nl0EoUM/EKrWuZLZApy3cWDNjKIBdzZyGPzvaV5n16/cQ
	XaSAsz/whviWXGI0P5M36tHHS641NpEXUoJdJpiyLfFm6IsXnu3JRc+sdYwYdpWO
	YCS3vwt/khjLbycJEEyEf0/9Rhg7hjJW1zUZetVVMFzx0sZ+Vok=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 792764BDD2;
	Mon, 14 Mar 2016 14:39:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DC6D64BDD1;
	Mon, 14 Mar 2016 14:39:43 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1EA720CA-EA14-11E5-A196-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288800>

If there are pending updates for the upcoming release, please let me
know and tell me what to pull.

Thanks.
