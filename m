From: Junio C Hamano <gitster@pobox.com>
Subject: Re: State of ab/send-email-perl in next
Date: Fri, 01 Oct 2010 12:07:53 -0700
Message-ID: <7v39sphgty.fsf@alter.siamese.dyndns.org>
References: <20101001161213.GA26521@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 21:08:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1kxm-0005yg-5Z
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 21:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285Ab0JATID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 15:08:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0JATIC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 15:08:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A8AA3D91BE;
	Fri,  1 Oct 2010 15:08:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yHHiVKrRpxOAtM2+YZQB55TTu3c=; b=U0F+od
	Oz6RmZYgd//z0CElvuK3T+9nQO1VIC2BXVzdk3pjrtwWssLT0VQvfsgmEVcZrYdV
	xUlVIDEwBkS7oKFnvGVvy/UVuWvutDdLRB9/UBm/qWzJiayiYgoi4TdmFvTVuqmQ
	eokRgh5oPoZTDw3QV+G6vs0PTsGCDZBmV4eaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oBRAGTtxkibrpEnN8hEhUtMwyRr51cun
	q89LzrLU4mrTqjc8oaPv4Vm7bPBxSxAVuuahD/q3kMpsQNiU8Mf1xmLO10KwwSbh
	4hJpLxrjO2hwuhQu1CoWB+suSLisIcGmKmVRDKyuyamg1jnUIG4Xi5PWl3hFxeL/
	pJmQbG2HmNg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7677CD91B8;
	Fri,  1 Oct 2010 15:07:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BFAAD91B7; Fri,  1 Oct
 2010 15:07:55 -0400 (EDT)
In-Reply-To: <20101001161213.GA26521@kytes> (Ramkumar Ramachandra's message
 of "Fri\, 1 Oct 2010 21\:42\:16 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3432E020-CD8F-11DF-ABC8-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157774>

Hmph, thanks for noticing.
