From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] GIT, Git, git
Date: Mon, 21 Jan 2013 11:56:01 -0800
Message-ID: <7vobgifgz2.fsf@alter.siamese.dyndns.org>
References: <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:56:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxNTo-0006xh-Q3
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab3AUT4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:56:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704Ab3AUT4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 14:56:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E15A9CEB0;
	Mon, 21 Jan 2013 14:56:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7aRnikzZlos0iJfpNwTH9BBKNcw=; b=ff6cEU
	SdMsGAe5o8PyNtSGC3VxdMX2cMIkfBJg4ZH+881Imilw8Pg6M9dw6Aj3xG3NrYij
	ZcyP88Y6exrWYbB+LgpI4PMOzl8n7jl9mmnsh6j0QE1n3f9k5CwCFPCjIBo1nYp8
	R29qlYLR/DTYl6XEGrfbGBMcoxUuFG5dc9zPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QZcvfcNc6XSXfpQM2gmm4Tp7GwqFjC/L
	/EJIeDLDxHJGtmnDe2tPZiWX5SPxmFbj6A9Wyy9wfmQVGnbONFfLMTiC1u36nibW
	RnBaUSDb/sIfHptT0Lp5nCJigdKZYhlATrD0tN2z3bDJAIcDtDsfLK5GGdNzJkKg
	gO/G4rWUqYc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D34C8CEAF;
	Mon, 21 Jan 2013 14:56:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64DF3CEAE; Mon, 21 Jan 2013
 14:56:03 -0500 (EST)
In-Reply-To: <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 (Thomas Ackermann's message of "Mon, 21 Jan 2013 19:36:15 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9606DDF2-6404-11E2-B6AB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214156>

Thomas Ackermann <th.acker@arcor.de> writes:

> Git changed its 'official' system name from 'GIT' to 'Git' in v1.6.5.3
> (as can be seen in the corresponding release note where 'GIT' was 
> changed to 'Git' in the header line).

Didn't I already say that we never changed the name?  The same
description seems to appear in [1/6] as well.
