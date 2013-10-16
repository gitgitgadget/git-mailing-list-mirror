From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] symbolic-ref: trivial style fix
Date: Wed, 16 Oct 2013 14:38:35 -0700
Message-ID: <xmqqzjq86gmc.fsf@gitster.dls.corp.google.com>
References: <1379780993-4190-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq4n8ich89.fsf@gitster.dls.corp.google.com>
	<525e091764958_81a151de74aa@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 23:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWYnk-0007wq-4y
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807Ab3JPVij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:38:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468Ab3JPVii (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 17:38:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3875A4BD28;
	Wed, 16 Oct 2013 21:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=FQjZHJXz4FyR4QAaKot/dmIj0dY=; b=Bf1dTQm63c0Ep7dnhU/J
	9bpJMcP15hDvaxrACxPDZy3SuzOgstplu0X5yMhRiOOUp3AcHbwf/9AuSBRLINtJ
	BhEm3xzp0abXjpbu4yiYRGsyhiVD6pw6RppOYw5fhyBDLUzS4K2m/VkLR9+I59E5
	6Q99Sb+6yIroM90VJ0Nje+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=FeBbH+AbkoDI+vZLk/7bghEPiuCNzKXxZ5vhkD23IfohO8
	eFieVPGnQpJpfYzwuIw2rYjgU5VjSVXGBlYkRh7A5wuvQ4rIHeJSdrM4R5ISBa5o
	9+OFOUDltApkAJ2edIcit4ITHF9hYyjoPqtBsri89i328/eDNBTjvMhif0IUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29C3B4BD27;
	Wed, 16 Oct 2013 21:38:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71E6F4BD22;
	Wed, 16 Oct 2013 21:38:37 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 50D636CC-36AB-11E3-AB6E-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236264>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Saying this patch is from me is not really accurate, it's based on a patch by
> me, or it was reported by me, but it's not really from me.

OK, will reword.

Thanks.
