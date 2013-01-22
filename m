From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] Change 'git' to 'Git' whenever the whole system
 is referred to #1
Date: Mon, 21 Jan 2013 16:41:08 -0800
Message-ID: <7vbocidp7f.fsf@alter.siamese.dyndns.org>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <1430594044.632790.1358795873467.JavaMail.ngmail@webmail20.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Jan 22 01:41:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxRvg-0002hx-F7
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 01:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab3AVAlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 19:41:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687Ab3AVAlL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 19:41:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8ED6CE4D;
	Mon, 21 Jan 2013 19:41:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hNpaAH69E4WqNitwu3sRSrliuxg=; b=hM0Ifj
	bkp3sHra5rppYmoFH+BTgQikXJ0NTQ0U98PmJ16cfWzUsP480TsU0beJTBp7oIdG
	JMIiM3/bJT0mtINcwux484dkjggNqyQtwK2mhgS5YTXTGYNX7qXzCUnxOpZWurgL
	1UkXSsgYATlfJn7GrhGGLIZq1bT5j3emRQdds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nP/B6gvIK6Bf1uI5iTRbHR72TlqO03XE
	G1qowIWsSpoSCJ1JmnKZq6m8o76o/W4qVb510jcpYMZA8sMA/AQHdWJdXDhUTEaF
	Tr7wLddEf0LbmRJjcp7x0/Jdo7LgRcsROh7BJdEChkZLwLMFe6QhXX97CKCOtqJo
	Npc5VTCk0Cw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBC63CE4C;
	Mon, 21 Jan 2013 19:41:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FA00CE49; Mon, 21 Jan 2013
 19:41:10 -0500 (EST)
In-Reply-To: <1430594044.632790.1358795873467.JavaMail.ngmail@webmail20.arcor-online.net>
 (Thomas Ackermann's message of "Mon, 21 Jan 2013 20:17:53 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A809D58-642C-11E2-896C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214182>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>

Forgot --stat?

It helps to check the integrity of patch application and also helps
anticipating possible interaction with other topics in flight.
Please don't omit it.
