From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Consensus on "Git"
Date: Wed, 11 Nov 2009 01:06:44 -0800
Message-ID: <7v8wedv3a3.fsf@alter.siamese.dyndns.org>
References: <ee77f5c20911110032r65a60653sfeef34e3de07d17e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 10:07:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N89AM-0000t6-8E
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 10:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbZKKJGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 04:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbZKKJGu
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 04:06:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbZKKJGt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 04:06:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E12917CC81;
	Wed, 11 Nov 2009 04:06:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cnswaszNsA1GBA4XIGjq3zwIIW4=; b=yV59J7
	cjkgukge3RjepmyNba/r2MwZzYm9QzdPZQse/THEj6EDX/TOH+5S3E7HtGKJK3Mg
	oktN5BicNPAHA6VrY/oxeWOeUuV100/vh8bU8/ZcyJ5fi9nFd04QRYVMHd9/WR40
	9gGvl5PUNGhLfgCMkSIyIY4fkjTXVHSSvv69U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qQ6ghG2OKmo5YA4+YbXs4DjUNw1N4ovt
	kti4o6+xx6wgYRwDZH+u8om/jUuDrYbvvz2n745V/ra92C/UTsLzPe4U5jCG2V6U
	+K+QMXvyO7CqP/Q5jVY53/IWP5/1RpfeAvi/+vmTorUs0pMzkpoMNkzhbzlkIzBl
	IBVvKCX4baY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C28227CC80;
	Wed, 11 Nov 2009 04:06:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8190C7CC7F; Wed, 11 Nov
 2009 04:06:46 -0500 (EST)
In-Reply-To: <ee77f5c20911110032r65a60653sfeef34e3de07d17e@mail.gmail.com>
 (David Symonds's message of "Wed\, 11 Nov 2009 19\:32\:30 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C5D2370-CEA1-11DE-88DF-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132628>

David Symonds <dsymonds@gmail.com> writes:

> Is there consensus on "Git" being the standard capitalisation, versus
> "GIT"?

I am not a consensus, but from day 1, Linus talked about "git" (all
lowercase) and "Git" was used only when it came at the beginning of a
sentence (an usual English capitalization rule) or in a section or book
title where all words (except prepositions such as "in", "on") are
capitalized, and I try to mimick it myself for consistency.

As a corollary, unless I spell all the other words in capital to SHOUT, I
never write GIT.
