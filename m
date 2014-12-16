From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5400: remove dead code
Date: Tue, 16 Dec 2014 10:58:37 -0800
Message-ID: <xmqqfvcfbew2.fsf@gitster.dls.corp.google.com>
References: <1418702287-13771-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 19:58:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xKV-0002xb-T1
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 19:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbaLPS6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 13:58:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751030AbaLPS6j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 13:58:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDD97282E8;
	Tue, 16 Dec 2014 13:58:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=O6+qa8
	ijDndU3DeRrCY3035pd4hEgYJdz2GY+YWEo9E0UTAkcjorj1S2KYuMvT71jxFWo9
	Y0aTuiO07ILuAoVAQFpuu4Hl0geUcacgvaqX7amMm4mOuBiKScrJxVAE/kRoh6D5
	1rbVAeWh0P67lURo9+rakgwuF9gsb8thDqp8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ghX1UugjhqHEZa8k8oiyGYquz6HweELX
	KLhHHoP9DpfiWqTDC19qH+j5W3O9m9fTQkmdLPDSV0VcuqSJE7GoRmZULwnRDrt8
	SlazFtiX7Lm/gveH+9PVpBIPSLUUUcEpJ3lxY4pknv6psGkj95JxMpCIcihYFh7G
	5YaXp4Wm5kY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4434282E7;
	Tue, 16 Dec 2014 13:58:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 480D6282E6;
	Tue, 16 Dec 2014 13:58:40 -0500 (EST)
In-Reply-To: <1418702287-13771-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 15 Dec 2014 19:58:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C74F30E-8555-11E4-AF40-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261450>

Thanks.
