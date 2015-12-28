From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual: remove temporary branch entry from todo list
Date: Mon, 28 Dec 2015 13:44:58 -0800
Message-ID: <xmqqpoxqjlid.fsf@gitster.mtv.corp.google.com>
References: <1450918023-30309-1-git-send-email-ischis2@cox.net>
	<3065044.ki4VpYSZvR@thunderbird> <4958087.8Wy1HxgErt@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Stephen & Linda Smith <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 28 22:45:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDfbS-0007O3-N7
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 22:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbbL1VpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 16:45:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752469AbbL1VpO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 16:45:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF44037085;
	Mon, 28 Dec 2015 16:45:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nnUtvzJVROIBtRnAgwIZcgKtKfs=; b=b/qkHu
	Jnc4VCpeKpwNRGYk7t0E5WiBB6wma3n3UHWwMQF+6Bz5Tm3Fr9aPawBujkfaJhik
	9cB+RYrUUN9DcOYC518a0uC8wltVDmjY0HusOwVmSljlwi8coF4SVixawOhhd8pr
	Qf7gpotrgot6SQht4199TWWSIOll6wAIfz4jQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OWB9foxUtVNQGBwbl9sI8zwsaIi5X8sT
	UrdIA4OA08Qo3jnMhvanRyt/t1GmoOT5L2I9UsbYnkYyqpiS/PGd11yUiS4O/IUR
	NhSRdMDiiw+d6OYiMXaSWlrKXg3J/u6GBIzsLvDxGSGLV+5BV+YqVsASCmce8y/g
	KA0bmTcF1Rs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB99037084;
	Mon, 28 Dec 2015 16:45:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6519C37083;
	Mon, 28 Dec 2015 16:45:12 -0500 (EST)
In-Reply-To: <4958087.8Wy1HxgErt@thunderbird> (Stephen & Linda Smith's message
	of "Mon, 28 Dec 2015 11:41:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45F3B4C6-ADAC-11E5-9192-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283050>

Stephen & Linda Smith <ischis2@cox.net> writes:

> I will rework the patch using the above analysis in the commit message.   Of
> course I will rewrite for readability.

Thanks.  Will apply.
