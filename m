From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] tests: make comment match the code
Date: Tue, 16 Dec 2014 10:58:31 -0800
Message-ID: <xmqqk31rbew8.fsf@gitster.dls.corp.google.com>
References: <1418719205-13832-1-git-send-email-mail@eworm.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christian Hesse <mail@eworm.de>
X-From: git-owner@vger.kernel.org Tue Dec 16 19:58:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xKV-0002xb-4t
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 19:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbaLPS6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 13:58:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750941AbaLPS6f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 13:58:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D18F6282DE;
	Tue, 16 Dec 2014 13:58:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=JcDtdI
	MfBfHd4jG2qnyfxKYJj4rl8CX4K7sOFPCaDmd/JaomZyOqTlfuSWLM9O9omAZIw6
	dLHQ1GwxryX2AbS/dcvHnjHyfYbtPfZn5RCJ5ZWb4vSjIQoGI6ETc7RpsnHgMwxQ
	XssrLFCwPyk33PpNXsXNqCtYFRxKMfvk8pw1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T4R3hEBWd8OgU2vyFEccoUvJl8mVBEka
	1c4DR1FN+UxA3axbFutfXVVNW4O5pID1cunAkpbOQiJIoDmfojpB6CigcJlTeRVm
	AalZZsI2pbMUbefF2kEvO1gfh2Mvu6H5Qmcjjvm7KjZ7QYR6VzfGAhRYytA3O/rM
	2EhrVxsGc8M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5B21282DD;
	Tue, 16 Dec 2014 13:58:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CEE5282DB;
	Tue, 16 Dec 2014 13:58:35 -0500 (EST)
In-Reply-To: <1418719205-13832-1-git-send-email-mail@eworm.de> (Christian
	Hesse's message of "Tue, 16 Dec 2014 09:40:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8972002A-8555-11E4-BDC7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261449>

Thanks.
