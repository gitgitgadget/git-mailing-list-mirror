From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change C99 comments to old-style C comments
Date: Fri, 04 Jun 2010 07:44:43 -0700
Message-ID: <7vy6eu502s.fsf@alter.siamese.dyndns.org>
References: <4C08C81B.3000404@spacetec.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tor Arntsen" <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Jun 04 16:44:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKY8m-0000ln-7y
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 16:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588Ab0FDOow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 10:44:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab0FDOov (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 10:44:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C5592B99DE;
	Fri,  4 Jun 2010 10:44:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Afsd/a
	r++ChUSzVwMNs60ThFpqJ6Aer9Esyl0qnkYvA5Ek/mejnS/Wml1fjJhBf5yFG7cV
	jHX8vsHtpaj+IOeDOB5n2J2UIvokktGbSq9B1MUPK79nsOfrZfD38yFXtOm8r8MY
	wnPWmj2eJq0iVjbs0c6nfJ+b4z5FAuQsaOjmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JITsRJ1vkyIxxDCdbBLdYYX37gZVt+ds
	JIv73jsrXUUPjB7jF3WYPbyL8PzIHTS/jX7FnxXKsrz9+d26Cj/ZSPLmaQwPAcI9
	Li9EYA6j8sq5ljd0xa19pcXCfJccl1AcFvBIGOrgPh8Qs9604q2DBmAAZQLw2yAD
	La8Mnn5tLok=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0B0BB99DC;
	Fri,  4 Jun 2010 10:44:47 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D7BBB99DA; Fri,  4 Jun
 2010 10:44:44 -0400 (EDT)
In-Reply-To: <4C08C81B.3000404@spacetec.no> (Tor Arntsen's message of "Fri\,
 04 Jun 2010 11\:32\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B8FF8494-6FE7-11DF-B649-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148422>

Thanks.
