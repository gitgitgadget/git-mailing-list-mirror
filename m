From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-email: add some short options and update documentation
Date: Mon, 13 Dec 2010 13:47:48 -0800
Message-ID: <7vtyihxs3f.fsf@alter.siamese.dyndns.org>
References: <1291869878-19645-1-git-send-email-asedeno@mit.edu>
 <1292006656-1264-1-git-send-email-asedeno@mit.edu> <4D067E19.1060904@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 13 22:48:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSGFb-0007IX-LG
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 22:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757600Ab0LMVsB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 16:48:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757463Ab0LMVsA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 16:48:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A42C3030;
	Mon, 13 Dec 2010 16:48:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PU8Yl0kqIclO
	cTNxwLLitZUkNOE=; b=qkesqeNhERJJ2ThW5Affy/+uN2hNoJXMNUbgaEuwBj/P
	5TjlYVYXw2ZxoVLN/onClzHgV3L1slZ2dkzzv8zPZQ7HUZrLn1faB6N1yj6ZWkDX
	NqiAXsnqPIurf5MthFKC0A/wNpP+BDBRBAJYbh5sOxxXwmSfK+JtoslkjZyPg10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MCkTLG
	ykdU3HP/tewDJ2/5fPmZT5GIlTAPbWDaoUfYdSFybr0gmtRku9acDBsQsoMaeHjX
	16rtwbKmL4QALI1Ryr2WG63fn2mVMIqv93t5ZdM8dz1bEAJKMuvw1GKDaWwT9z5e
	oIRqJzwFxKBNln5pCNfMCeLDGg930Z34QQsUU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 469EE302B;
	Mon, 13 Dec 2010 16:48:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A41A3025; Mon, 13 Dec 2010
 16:48:15 -0500 (EST)
In-Reply-To: <4D067E19.1060904@mit.edu> ("Alejandro R. =?utf-8?Q?Sede?=
 =?utf-8?Q?=C3=B1o=22's?= message of "Mon\, 13 Dec 2010 15\:12\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B3F7E434-0702-11E0-9074-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163597>

"Alejandro R. Sede=C3=B1o" <asedeno@mit.edu> writes:

>> [PATCH 2/2] git-send-email: Add some short options
>
> Any more comments on this?

Not from me, other than that I am not overly interested myself.
