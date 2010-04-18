From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Documentation/remote-helpers: Rewrite description
Date: Sun, 18 Apr 2010 11:31:40 -0700
Message-ID: <7vochgwr1v.fsf@alter.siamese.dyndns.org>
References: <1271551934-sup-1118@kytes> <20100418022900.GA1669@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:32:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ZHt-0000Ss-Vc
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757336Ab0DRScE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:32:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51709 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab0DRScB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 14:32:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 141C9AC6A6;
	Sun, 18 Apr 2010 14:32:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rcRP26+txY+9uoGe9VteiR3C6Kk=; b=ZzpRNQ
	ZOUbT/N7LxbW/rxUDYgk7M0yv3NupAYDu1Zv4kcOndV97RE24wgJEbToiohh1guz
	X5INsBwTu4ydGkYRpEsXzIka8yiLadENx0e3yW+AUrJAx1eGSM9TE4NUYev2yo6I
	h1UDqpJlHSPEYBCWNaKeffmyNQ8j3458a6VxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SoDj0eTo60bq8E+fDX/9w5poHnOafXzL
	eCNquIMhKJdVFo6ky+g7jiYauZPdxPuxpfqHQwaJ0/uz+W1X/BUFdIVZEeZur57r
	e0urZKLTddd3KKuhgK7Yd/CEtQQSRPc8J//aTuO4i4+5Mj+pAgVTbVflhyq13NXD
	VsAcFGuKIo4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A998AC6A5;
	Sun, 18 Apr 2010 14:31:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58026AC6A2; Sun, 18 Apr
 2010 14:31:42 -0400 (EDT)
In-Reply-To: <20100418022900.GA1669@progeny.tock> (Jonathan Nieder's message
 of "Sat\, 17 Apr 2010 21\:29\:00 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A804A1E0-4B18-11DF-BC31-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145230>

Jonathan Nieder <jrnieder@gmail.com> writes:

> ...
> With the above changes (or whatever subset you think is suitable),
>
>   Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I think this is much easier to read.  If it is Ok with
Ramkumar, I'd squash this into the first one in the series.

Thanks.
