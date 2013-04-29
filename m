From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] [RESEND] Minor additions to git-completion.bash
Date: Mon, 29 Apr 2013 09:58:12 -0700
Message-ID: <7vr4htjmu3.fsf@alter.siamese.dyndns.org>
References: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
	<CALkWK0koi9UwN9uRUci3ictpMy_T5TMey_t9fNNM4HpBvqEG0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 18:58:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWrP9-0000iA-VS
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 18:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519Ab3D2Q6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 12:58:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757349Ab3D2Q6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 12:58:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A1DC1ACCC;
	Mon, 29 Apr 2013 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eIoNje0aiF+i7t/1VgVTL8uJMls=; b=eI8P1b
	M/wmiZtAq/WkvP/TGd/FJYIqovpGiRrqAYCkzaZew++xnCTf9rhMZkLnY0LK1Zqz
	x+nGB7Z2cBaKD2GlIo7o3gOEoRHN+xx+bMPgTTu2bneQiA3PUHSsL7zvbYiyRKCq
	eIB7lP+So8GvT9pdG8UzT9dTqgAKEuXfrENNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aGGiqNvrK7Ucu9ckXucsqNN6TUNxu1FO
	s9GNOJKk+t9J/FhUPMX8l+9geIHZq4rcjrNl+ZzIwlhuB/MjbTQBgECY2kdftj4j
	OLsroXFZN+maWtBXGjLauEyaKs8w5Jc8b9q/+62Nu+zusvQYEoYTg6jb+VcpsLzK
	HOEl5l2fFUk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F4471ACCA;
	Mon, 29 Apr 2013 16:58:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EABA21ACC3;
	Mon, 29 Apr 2013 16:58:13 +0000 (UTC)
In-Reply-To: <CALkWK0koi9UwN9uRUci3ictpMy_T5TMey_t9fNNM4HpBvqEG0A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 29 Apr 2013 18:20:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB0510DA-B0ED-11E2-A30A-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222814>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> [Corrected Felipe's email id; sorry, I'm having a bad day]

They all look trivial enough, so I'll directly apply to the
integration branches.

Thanks.
