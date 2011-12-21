From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.7.7.5
Date: Wed, 21 Dec 2011 11:10:09 -0800
Message-ID: <7vehvxhhbi.fsf@alter.siamese.dyndns.org>
References: <20111216105757.GA11174@elie.hsd1.il.comcast.net>
 <7viplckt2m.fsf@alter.siamese.dyndns.org>
 <201112211820.45447.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	schacon@gmail.com
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 20:10:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdRYR-0004ij-Fy
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 20:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431Ab1LUTKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 14:10:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754425Ab1LUTKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 14:10:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 478C25E5E;
	Wed, 21 Dec 2011 14:10:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g+/eD+ZA1iRrvMNUcHRSYcSzZFc=; b=i9Fq9z
	lf3cMPtrtEjTDJYRj1dUgKC5nzF76W4dkm/YhXLSLE/QPFa7iWgL7tvRnUd1ccIC
	0PFOfnzp+gGvPr/UmNhyAvvRsoBCCiGOxvLwXCqU91gTU4xiNwuIzTFiR6h9+y4+
	DRj1M8Wr5vQHsmdYCo1P0mq6/GQF7y0fdXqFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ap5ySaQQszcTKT+HIEKapZt7/ce9jyAW
	IYQ0/HEEUbealLWsyUN6fKUNgQEN3MrHYRLsa1XZxUN7abQt8kV5P2QmuFxhCO9O
	QF8kU3B/AuXVgwjeMLjVfRHvJ6SUJQRoDnYs0dqxT2DqRqZtigD87z8ig4FOXKIO
	0/GBOo+fCL0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D7D85E5D;
	Wed, 21 Dec 2011 14:10:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8B955E5B; Wed, 21 Dec 2011
 14:10:10 -0500 (EST)
In-Reply-To: <201112211820.45447.thomas.jarosch@intra2net.com> (Thomas
 Jarosch's message of "Wed, 21 Dec 2011 18:20:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 675C9004-2C07-11E1-BBFD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187581>

Thomas Jarosch <thomas.jarosch@intra2net.com> writes:

> May be Scott Chacon can provide you commit access to git-scm.com ;)
> If you are interested in this of course.
>
> For example wikipedia lists git-scm.com as website for git.
> (http://en.wikipedia.org/wiki/Git_%28software%29)

No, thanks.

They volunteered to keep the site up to date and useful to the user
community and they have been doing a good job at it, and that is why we
advertise git-scm.com as the official site. A minor bug like this which I
know they are perfectly capable of fixing at their site is not a
justifiable incident to trigger taking control and credit over from them.
