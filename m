From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] fixup! Documentation: avoid poor-man's small caps
Date: Fri, 01 Feb 2013 10:44:52 -0800
Message-ID: <7vvcaban6j.fsf@alter.siamese.dyndns.org>
References: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
 <7vzjzodfp1.fsf@alter.siamese.dyndns.org>
 <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
 <544568068.1090092.1359742136040.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 19:45:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Lbx-0002kk-NO
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab3BASo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:44:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50305 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756669Ab3BASoz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 13:44:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC659C79B;
	Fri,  1 Feb 2013 13:44:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O6VcnuinyikLAp2kGLyvcawcAp0=; b=Cgllci
	fYHev7grBa8s/6csq3to3fiLGnI6NIT4k1xhPHzOEszNE7CGohPiPufxSHG4mbza
	Vd5NMUJgVK9mXK99zzwW+yzzoeL6xbE9smgBIglOphbzB62lRX2vc7UZWb1Vjk+o
	hZo1ZKm58F82mMQpKtc+I9p6IbyJAuEAUONSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IeWvn+Rr3b9hu9TPU+HPLwZQXWyAuKW5
	CXsolwcb/MaBc1nm1FZYg18OpG7AdSW0Vn1KF6iaxXwn729mogGJgHHijKqxFH2E
	pC5bN3rpCcIQFbJ6cOgRZdhyr3UvTlnIDTTdf0VE1Uy7hqmIUst/RXsbkza9cBze
	yeUUwV1Xu7I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0B4FC79A;
	Fri,  1 Feb 2013 13:44:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33660C799; Fri,  1 Feb 2013
 13:44:54 -0500 (EST)
In-Reply-To: <544568068.1090092.1359742136040.JavaMail.ngmail@webmail18.arcor-online.net>
 (Thomas Ackermann's message of "Fri, 1 Feb 2013 19:08:56 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77ED4E7A-6C9F-11E2-AC28-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215249>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---

I think this deserves to be a separate patch in the series, that
says "StGit is the right spelling of the system, not StGIT",
referring to https://gna.org/projects/stgit/ or somewhere, in the
log message.

Will massage the above in; no need to resend.

Thanks.

>  Documentation/git-tools.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
> index 338986a..ad8b823 100644
> --- a/Documentation/git-tools.txt
> +++ b/Documentation/git-tools.txt
> @@ -29,7 +29,7 @@ Alternative/Augmentative Porcelains
>     - *pg* (http://www.spearce.org/category/projects/scm/pg/)
>  
>     pg is a shell script wrapper around Git to help the user manage a set of
> -   patches to files. pg is somewhat like quilt or StGIT, but it does have a
> +   patches to files. pg is somewhat like quilt or StGit, but it does have a
>     slightly different feature set.
>  
>  
> @@ -60,7 +60,7 @@ History Viewers
>  
>     - *qgit* (http://digilander.libero.it/mcostalba/)
>  
> -   QGit is a git/StGIT GUI viewer built on Qt/C++. QGit could be used
> +   QGit is a git/StGit GUI viewer built on Qt/C++. QGit could be used
>     to browse history and directory tree, view annotated files, commit
>     changes cherry picking single files or applying patches.
>     Currently it is the fastest and most feature rich among the Git
