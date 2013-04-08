From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] remote-bzr: generic updates
Date: Mon, 08 Apr 2013 11:26:43 -0700
Message-ID: <7v1uakyj30.fsf@alter.siamese.dyndns.org>
References: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 20:26:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGmH-0007zO-JK
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935554Ab3DHS0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:26:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41639 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935544Ab3DHS0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:26:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71E8A1346C;
	Mon,  8 Apr 2013 18:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=64ue2GrOOPK+3NfFKz4exbfns5k=; b=rKskMk
	djZ9BOVH7YQ/K1guEOIb7O7p65tQe/r1bPezQ2dLo6pshl3216o3IJI6bm5M8iRi
	xvXsTN2chsmFH4Y2MfIOiAVsjIh+jNw5nEHXQBehV1HHD3RY5A+0hab0SNnaKk2R
	EyzPYCqZryUTnJPuuWx55wVm0y+KpVHzkUUCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I3W3aGANmCqLaPjmlJq0Ogg4t9E3yZ5e
	S93jzxzFROW9Af40Pcpkd97Lx72VJX6AFkj9fOkBu8zkaiTekMJ1c2pIXRk04wkJ
	zmjyNBHjpMCkhWFLfUEgmXwybQMfazMqv2h6cEg+N2dcKv7U5eMD6pQtqYs4CEJ+
	xCqzf2tcmf8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69A311346B;
	Mon,  8 Apr 2013 18:26:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C050313467; Mon,  8 Apr
 2013 18:26:44 +0000 (UTC)
In-Reply-To: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Mon, 8 Apr 2013 12:27:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDD825A8-A079-11E2-B0AC-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220483>

Oops.  The previous round is already now part of 'master'.
