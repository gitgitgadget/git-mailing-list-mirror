From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: Add explicit license detail, with change
 from GPLv2 to GPLv2+.
Date: Sat, 20 Feb 2010 13:28:30 -0800
Message-ID: <7vaav3bnr5.fsf@alter.siamese.dyndns.org>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
 <87hbpwpoko.fsf@yoom.home.cworth.org>
 <5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com>
 <201002081614.24284.sojkam1@fel.cvut.cz>
 <871vgr78lr.fsf@yoom.home.cworth.org> <87iqa2y0gz.fsf@steelpick.localdomain>
 <87r5oqe7mi.fsf@yoom.home.cworth.org> <871vgmki4f.fsf@steelpick.localdomain>
 <7vaav8hpfo.fsf@alter.siamese.dyndns.org>
 <87tytdiqob.fsf@steelpick.localdomain>
 <alpine.DEB.1.00.1002191138280.20986@pacific.mpi-cbg.de>
 <873a0xhwxs.fsf@yoom.home.cworth.org>
 <alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
 <87eikfhec1.fsf@yoom.home.cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michal Sojka <sojkam1@fel.cvut.cz>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	notmuch@notmuchmail.org, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 23:13:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Niwsj-0000nb-8f
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 22:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070Ab0BTV2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 16:28:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453Ab0BTV2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 16:28:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1590E9B7E4;
	Sat, 20 Feb 2010 16:28:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yrkDJFdaluEs5LjDWbglkntQBsU=; b=JTKef9
	5o1HvISYhW3VjK8w4krvi27U0oKhbO4lb6XSKzLOWpnatnp1eNjgLRRr88DpZD9t
	/Il9kagFik5mV14qsa13+TSpN/UOxK5YRAnfGzw4JMbeEm5EII9Yinunn48s+c/F
	IaIUGLH+kbunEXsDcNZHYe4Zy4reZhOU5dYaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vzNlBeX4/PSrdN/W4ihrBpUGvAoQrNJJ
	rfhpt8grsbk69vHNfPAvhn2I7O0B/T4JcnfV+g/hC8xbAjfDPqw2DZ30Ac3YSmig
	7okwpaggd2/QzKDhPb8b5FV1i4TOwGIy2KS89rPk8rI7EESSoAkerI2FzgyTPRs1
	jNftwycprCI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FF679B7E1;
	Sat, 20 Feb 2010 16:28:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 222189B7E0; Sat, 20 Feb
 2010 16:28:32 -0500 (EST)
In-Reply-To: <87eikfhec1.fsf@yoom.home.cworth.org> (Carl Worth's message of
 "Sat\, 20 Feb 2010 11\:55\:26 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA8B9EA8-1E66-11DF-A57F-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140558>

Carl Worth <cworth@cworth.org> writes:

> This file has had no explicit license information noted in it, but
> has clearly been created and modified according to the terms of GPLv2
> as with the rest of the git code base.
>
> The purpose of relicensing is to allow other GPLv3+ projects (in
> particular, the notmuch project: http://notmuchmail.org) to use this
> same test-suite structure (and to contribute changes back as well).

Please drop the parentheses around the last phrase (but not the last
phrase itself).

> The request for relicensing was presented to the git community in:
>
> 	Message-ID: <871vgmki4f.fsf@steelpick.localdomain>


Message-ID alone is not a good way to help people locate the request.
Please at least mention what mailing list the message was sent to; better
yet, do so like this:

  http://thread.gmane.org/gmane.mail.notmuch.general/1389/focus=140156

so that people can see the consent from the primary author (that is where
the focus is), the original request (that can be seen by looking at its
immediate parent), and messages with consent from other contributors, all
in one place.

> and explicitly agreed to by Junio C Hamano, Sverre Rabbelier, Johannes
> Schindelin, Pierre Habouzit, and Johannes Sixt.
> ---

And a sign-off ;-).

Thanks.
