From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/13] contrib/subtree: Remove Test Number Comments
Date: Mon, 04 Feb 2013 20:39:36 -0800
Message-ID: <7va9rjxtkn.fsf@alter.siamese.dyndns.org>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
 <1360037173-23291-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Nylen <jnylen@gmail.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun \"" <apenwarr@gmail.com>,
	Jakub Suder <jakub.suder@gmail.com>,
	John Yani <vanuan@gmail.com>,
	"David A. Greene <greened@obbligato.org>"@b-sasl-quonix.pobox.com
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 05:40:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2aKC-0002nf-S8
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 05:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307Ab3BEEjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 23:39:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753882Ab3BEEjl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 23:39:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 559C5CABB;
	Mon,  4 Feb 2013 23:39:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=quedJi5RMe5OQXblXwU79IpCYME=; b=CjolfHmr2NhGetCYB3zM
	p8FtjCbR2tVT6+Al/WgqULH9s68pH0U3L0LDDKfDyjA6GZxz0fYL3/awdij7eWk7
	+7F9Lwou8XrzhSC5h0kYiguOInQL1HOO5cAmf88foUY2oXlZESWBLlcfo27qtV7O
	pqD79c7196pVMdjpki1UukA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ty6XeEI54yLIm/Ov4nC+28Q73IBnDo7andHrOtI8LUmsFv
	zloJ5caDYNePIJwCI4Nhq5bXojk/kB5Ti8rWTwGDmnhsLrTyO97if9tNtX22Euo0
	Iycfqptu/jIYOXjRZiEFCXVooJgbsiLsMAS8ZwXuupyAum2zZ1pwgXabRI2Jw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48E13CABA;
	Mon,  4 Feb 2013 23:39:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DBF5CAB8; Mon,  4 Feb 2013
 23:39:40 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0DC8A9E8-6F4E-11E2-B1F3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215456>

Thanks.

This is minor but I'd prefer to see that Subject lines Not To Do
Title Case (please see "git log --oneline --no-merges -20 master"
and imitate them for uniformity).

I'll tweak them while queuing so this alone is not a reason for
having to resend.

Thanks.
