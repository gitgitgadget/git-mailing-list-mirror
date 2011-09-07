From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git without morning coffee
Date: Wed, 07 Sep 2011 10:49:51 -0700
Message-ID: <7vy5y02qf4.fsf@alter.siamese.dyndns.org>
References: <4E6721E3.7000207@drmicha.warpmail.net>
 <7vehzs47we.fsf@alter.siamese.dyndns.org>
 <CAMOZ1BstyMteutmK7tst=3t9djavY9_4vBKJgdj7rhUnE1Wr7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:50:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1MG7-00051j-UJ
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab1IGRtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:49:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44723 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab1IGRty (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:49:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5D7A404C;
	Wed,  7 Sep 2011 13:49:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wfl6YQW87xEz9MRdAuBruMrwVX4=; b=FcJY7S
	baTOKxItMeyrRDTAyiyz7aKb+PQWqn5bjp7XDtjwmu+XoOuPR7xIwL3NbypPvk6a
	CGeMUArt6tDxu05yl1Sxc9XA3c/3ug6MyeLTN3MpJpxKH/sxat79FUGIeepgUvc+
	5BY2sCPYxASEXcjPHbLqmYClUMzokHmVQOm+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MupXbRQ27DB8PfJJp0GUoWt7n00GaWdM
	lQu+ghGwcakbiyxjyNWoXQ+0TmIgpqmBbiX0f+Gcv09slSKEX2aQwXdDHkjlGCi/
	qoT7eieEoxMS1m2aB3O3KOxNQ1B993eZZpZCj28YxzNIbreRXjyuWwZRd+JBgQAX
	W5LqZMh0iR0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC267404B;
	Wed,  7 Sep 2011 13:49:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29BE84049; Wed,  7 Sep 2011
 13:49:53 -0400 (EDT)
In-Reply-To: <CAMOZ1BstyMteutmK7tst=3t9djavY9_4vBKJgdj7rhUnE1Wr7w@mail.gmail.com> (Michael
 Witten's message of "Wed, 7 Sep 2011 17:23:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA71834C-D979-11E0-A901-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180890>

Michael Witten <mfwitten@gmail.com> writes:

> I think it would be great if at some point you could write a detailed
> tutorial of how you maintain git...

Is MaintNotes[*1*] taken together with Documentation/howto/maintain-git.txt
insufficient?

[Reference]
*1* http://git-blame.blogspot.com/p/note-from-maintainer.html
