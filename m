From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.txt: fix typo
Date: Mon, 10 Nov 2014 10:06:19 -0800
Message-ID: <xmqq7fz39bhg.fsf@gitster.dls.corp.google.com>
References: <5ABE5B46-7EE9-4748-8244-84981390AC2C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Nicolas Dermine <nicolas.dermine@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 19:06:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XntMD-0000tr-Mf
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 19:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbaKJSGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 13:06:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751247AbaKJSGY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 13:06:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD5521CAF3;
	Mon, 10 Nov 2014 13:06:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=wIgw6b
	+HMwLzlUpz6rxbX494OVRxVfoEuZj6Ei8w+pTnyjC9LtVbJFOx2uHxzD8UIis3OI
	4B+VsT1Qdfe+ui2Q6ng4QllljKT4l/J25qAj+z3YxNZP4zsZhc1yKYme7VUIxhCN
	t4KyqlnzIRDEKV/k84yy4nzmX2PEoEIsZxzD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LiRlLpbbpbqc6/t7VHYgrABbwEeulNWx
	08Xa5ZWMlSXG8pLNJ6gjC40S55UxsDeFwXGD4pdvV3XWV+uYttsQSBM2AlUdyRMg
	gEo+lqevqVJRZ80W5rtAr+Vxz+lD4zTBF7MCFQgeVrhZyzBrt/akiyWnfRR5Rgvg
	WbaD1JDxVbM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCA471CAF2;
	Mon, 10 Nov 2014 13:06:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B702C1CAEF;
	Mon, 10 Nov 2014 13:06:20 -0500 (EST)
In-Reply-To: <5ABE5B46-7EE9-4748-8244-84981390AC2C@gmail.com> (Nicolas
	Dermine's message of "Sun, 9 Nov 2014 17:19:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4643D21E-6904-11E4-85FB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
