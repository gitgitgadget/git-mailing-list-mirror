From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] squash! bash-completion: add support for git-log --merges= and log.merges
Date: Tue, 21 Apr 2015 10:42:14 -0700
Message-ID: <xmqqwq15gyyx.fsf@gitster.dls.corp.google.com>
References: <1428938968-19013-5-git-send-email-koosha@posteo.de>
	<1429620684-7760-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Koosha Khajehmoogahi <koosha@posteo.de>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:42:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkcBi-0003Qq-9j
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 19:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbbDURmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 13:42:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752342AbbDURmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 13:42:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB5814AC5E;
	Tue, 21 Apr 2015 13:42:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=oYUNz9
	52ApSCka+nki/7IKyCVQ2JSP8GsPp3D6Bk2/HzcOoHR3vFUC6jU4CUM2/TY1eo8n
	ZJ6eOE4wLop41WQAxBMxhOj36iMlxSO8WNEutbmzgkW4fZEhzrYPYDYrSADYye/F
	Nj4V8GtGZPKvJ7/sZo6D7iLBO42OozC67iQAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WqzQGx5xoVtTYZrhmtQKLEpYzd2cjfn+
	PrJudnGDTqsh097LPBR0TNzTMe6a+9L0qfce64x33ZFlzTbo6bDrgZcwQ1TyZ3H1
	H/89n9i6bJ45jup1Vzpqk7NBeRnHsVELSZlARPqG4J6UiwKdnqwav7QUvOjX9GtN
	hzxdNAuW73s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4B394AC5D;
	Tue, 21 Apr 2015 13:42:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4092E4AC5B;
	Tue, 21 Apr 2015 13:42:15 -0400 (EDT)
In-Reply-To: <1429620684-7760-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Tue, 21 Apr 2015 14:51:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BF9D735E-E84D-11E4-B1AD-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267541>

Thanks.
