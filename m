From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH GSoC 1/4] gitweb: Move static files into seperate
 subdirectory
Date: Fri, 28 May 2010 18:10:58 -0700
Message-ID: <7v7hmn5x7h.fsf@alter.siamese.dyndns.org>
References: <1275027952-5057-1-git-send-email-pavan.sss1991@gmail.com>
 <201005281856.27438.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	pasky@ucw.cz, jnareb@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat May 29 03:11:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIAa6-0005Zj-SK
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 03:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab0E2BLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 21:11:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab0E2BLL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 21:11:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CCB8B77BD;
	Fri, 28 May 2010 21:11:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=DritwqYd76Q/AX+VFAniQQ4LfLE=; b=r0sZbHxcq1ME7ucp7Cc9yuY
	xMJ7wft4u0s5H/fhLIY+DpkwxDYKFXlD4XJCf6/7oAvvIViGF8nSjTc8sr7iEYEB
	ZSGREwoe7+t1O2cUhvkRSJzYkbP7jdT/6QG6bUac3/JIEEsIrYUWAhImgZnFVDW2
	XctQ09GgiDcz+vuxLOk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=UCt4XNe+4BHm9dybBLvPpn10ZNL4hKqLvYIXKrxU2VKs39seG
	DtcTLl5j+10Bau9o+MOTN6su03GfT7PxdD98o05P5WaSMBHBdQzUNqiGmJTTWnh0
	oG2oJ3ptYRXzRzCWvv/BVfXS6uU5OjRWnuk6bnS58raeiScDkZ42FexgME=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1A53B77BB;
	Fri, 28 May 2010 21:11:05 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E296CB77B9; Fri, 28 May
 2010 21:10:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E7F4C8E-6ABF-11DF-91AA-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147946>

Christian Couder <chriscool@tuxfamily.org> writes:

> That's nice but you should probably have sent the patch series to Junio too 
> according to this part of the SubmittingPatches document:

Thanks; I usually look at all the mails (I do not necessarily _read_ them
all, though), and I am slowly catching up with the list traffic ;-)

Will take a look and apply.
