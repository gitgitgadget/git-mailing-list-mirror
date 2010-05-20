From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Various fixes for Windows
Date: Thu, 20 May 2010 16:13:23 -0700
Message-ID: <7v7hmy6ub0.fsf@alter.siamese.dyndns.org>
References: <cover.1274380838.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri May 21 01:13:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFEvu-0005T4-E7
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 01:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209Ab0ETXNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 19:13:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab0ETXNg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 19:13:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 996BEB452F;
	Thu, 20 May 2010 19:13:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=cpBIET
	fcd8/X1OGTqezTkvJPgcBMlTBeajp0lQGdh4z1bLeLJkeucaAB+Xa+WZHrw9d8G4
	tbsrwUJvNVOg0Qyy+QQYxiJAK4ft20Wt3hYQHLm23MXdNLBIH6UJIqttzYQvYSaz
	isaOAnYBzcqHrBbP5F07KGclJD1YsIQucdXJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eeaQ0jPTSFf8ZNTKWC9xL3FVlaxhgQXt
	Qq/vIvp09XIc1KaQUNZ5NG6u14B47frHny9sqv0nre/WqKAUoVGw4mjMyG9V5PUg
	COVK+WBuxWoW/aCGn6HLNB4HFCCrcu6oyncupBmOyRGlwfvGdIWCsU8SAQrv9ZEp
	OiCGEoHydCs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 309A3B452D;
	Thu, 20 May 2010 19:13:30 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54D55B4523; Thu, 20 May
 2010 19:13:25 -0400 (EDT)
In-Reply-To: <cover.1274380838.git.j6t@kdbg.org> (Johannes Sixt's message of
 "Thu\, 20 May 2010 20\:57\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4DA57C4A-6465-11DF-A4F5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147419>

Thanks.
