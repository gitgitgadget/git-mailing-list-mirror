From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unapplied patches reminder
Date: Sun, 18 Oct 2009 16:31:30 -0700
Message-ID: <7vhbtwi8j1.fsf@alter.siamese.dyndns.org>
References: <20091019052030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, bgustavsson@gmail.com,
	tgc@statsbiblioteket.dk, geofft@mit.edu, hvoigt@hvoigt.net,
	peff@peff.net, RKvinge@novell.com, crmafra@aei.mpg.de,
	Per.Strandh@q-matic.se, vietor@vxwo.org,
	rene.scharfe@lsrfire.ath.cx
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 01:32:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzfEj-0005uX-85
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 01:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572AbZJRXcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 19:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755533AbZJRXb7
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 19:31:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774AbZJRXb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 19:31:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A00D27CC40;
	Sun, 18 Oct 2009 19:32:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=fHDW6j/idVYhsijFR6ZJ7mp/K1g=; b=llH+n2YCfGcKyDceCiW/wwm
	Xt82mQ+2/hindNbshIQtcoRZnfJtbNzZT9o0RI13xEYCgckgyTUtR+xdpBgLk4Ii
	z271531tQRsLC4Cg5hhrJl8gEmo7CrzvkeVxs4cy+SY4GKGfYTLNIF3Xl8YyfrbD
	plh/NolI+C+U+12d7DiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Fl5YJs+DReDTRBcQlDVdbjzjAEnHCKKj26QfMB5ZQ1YU3py6v
	u6n9ZmoSu+o8kfQKR3cWDhpwdJrYH+7t/63vrUlYtlgTtuBJMqUP4UORV6TtnlHb
	e7zBEtT7OLz3JwP5T79p6k/5tfRKHlV4E0BnKXRZUfkXIj4AiK0nNzubtQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0214C7CC3B;
	Sun, 18 Oct 2009 19:31:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7EB087CC33; Sun, 18 Oct 2009
 19:31:32 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 682FEE58-BC3E-11DE-9D92-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130625>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, I saw these patches and thought what they try to do were 
> sensible, but I don't them in your tree. I didn't see much discussion 
> on most of them, either.
>
> Because I don't read C very well, I may have listed some patches 
> here that you may have discarded because the code was no good, and 
> if so I apologize for wasting your time, but I thought at least 
> some of them should be salvaged.

Thanks; very appreciated, and I wish there were more like you to help us
keep track things.

Will comment on individual patches separately.
