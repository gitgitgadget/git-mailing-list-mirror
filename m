From: Junio C Hamano <gitster@pobox.com>
Subject: Re: small misspellings fixes
Date: Wed, 19 Jun 2013 11:31:12 -0700
Message-ID: <7vzjumymtr.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.1306190733440.8850@citymarket.hu>
	<vpq7ghqmywf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Veres Lajos <vlajos@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 19 20:31:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpNA8-0003RG-0b
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 20:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934659Ab3FSSbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 14:31:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756776Ab3FSSbP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 14:31:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEF7A29058;
	Wed, 19 Jun 2013 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Us1oOYKromyyPBYphxWjYN/AjPY=; b=AUQpQZ
	GiXgmeBoJoME4Wy85dGB9JZSvKcaE3KDabmQEnS3Z+/eoUvhrB9Zvie1Btn7Umsg
	3XNgU4E98VuDMHSq1lZt900m1X9Uyk9IyO9BlxHmt3Cf2x+RozZvDOFbTqgzNBVA
	QFbg2MWdUT09zN++3aGISnMnwGV86cWprkUFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sy5+xOvyUzkHFMhIrsFIUls7IiPWMGr5
	4kaR1UoPwy6kyFUDCuMhpvwYOo2U+hOAdtqjM0VLsj9aFrkRm3/n6kcMD6riqPGP
	qaT0b6dpuf9Gk7bubAGPpjM+DfzDA9Vn/wM6YSr9YbHF5dlYTRCWI+BJqLJplWlT
	EEyFhdYJ3sg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9732929057;
	Wed, 19 Jun 2013 18:31:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 003EC29054;
	Wed, 19 Jun 2013 18:31:13 +0000 (UTC)
In-Reply-To: <vpq7ghqmywf.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	19 Jun 2013 07:51:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C0CD7B6-D90E-11E2-ADD4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228407>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Veres Lajos <vlajos@gmail.com> writes:
>
>> I am trying to convert this pull request:
>> https://github.com/git/git/pull/42
>> to a proper patch email
>
> Use "git format-patch" and/or "git send-email" to get the proper
> formatting.
>
>> (Sorry If I miss something about the process.)
>
> Yes, your patch doesn't have exactly the right format, and you should
> have Cc-ed Junio (see Documentation/SubmittingPatches in Git's source
> tree).
>
> Other than that, the content of the patch looks good (and actually, at
> least one of the typos is mine :-( ). Can you resend?

Repeating the subject in the body is unnecessary.

I'll pick it up from here and will fix up.  No need to resend.

Thanks.
