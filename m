From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL git-svn] various git svn updates
Date: Tue, 21 Feb 2012 18:18:46 -0800
Message-ID: <7vfwe3ehkp.fsf@alter.siamese.dyndns.org>
References: <20120222003857.GA1212@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Walter <stevenrwalter@gmail.com>,
	Steven Walter <swalter@lexmark.com>,
	Wei-Yin Chen <chen.weiyin@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederic Heitzmann <frederic.heitzmann@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Feb 22 03:18:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S01nC-0001i1-5w
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 03:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab2BVCSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 21:18:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63990 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab2BVCSs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 21:18:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70D1D7714;
	Tue, 21 Feb 2012 21:18:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HlezTl6k5KB+4b2sjqmMwFDKvSU=; b=dMuqHf
	yRpBxwU7Dy61Qd0zz2vhpOp6lKEjEZ5j59n+BKQ4eFSkRz23aIhPNA2IENDmPbid
	mGPiCazoozvdLsaV+qr3vrDQaF0R/bBa0dtgQQVRYPo7VNNvK0vNSM3kRwPn7WqW
	ifVseb4SQKAXfkwkAoj/dxW/HAFMYNKV6BBMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rUj2nwIGFeV51+MK+/YKlxOCdq37k0dg
	o76x6KGbE76aRplhSOOn0AEEYRn1x0pVzDyux1U+NYLJTgkCtdsHnuZwKGn4Api5
	/DhB+6gePt8eKCCEr2pPYjI1Ta6WymImhOIaIILgnxfu+vKerrW5EnZ8nko0inMd
	VGVFqL1IysQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68E217713;
	Tue, 21 Feb 2012 21:18:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F16697711; Tue, 21 Feb 2012
 21:18:47 -0500 (EST)
In-Reply-To: <20120222003857.GA1212@dcvr.yhbt.net> (Eric Wong's message of
 "Wed, 22 Feb 2012 00:38:57 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D9952FA-5CFB-11E1-B32A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191223>

Eric Wong <normalperson@yhbt.net> writes:

> The following changes since commit b3a769dc355b32c95783dc07f59e4dfebdd8bdc7:
>
>   Update draft release notes to 1.7.10 (2012-02-20 00:29:40 -0800)
>
> are available in the git repository at:
>
>   git://bogomips.org/git-svn master
>
> for you to fetch changes up to 379862ec5a413e636d977a6ea3d618f0b3eafceb:
>
>   git-svn.perl: fix a false-positive in the "already exists" test (2012-02-21 21:37:31 +0000)

Thanks.

You didn't seem to sign off any of these changes yourself, but as I've
already pulled them, so it is a bit too late X-<.

Also there was one funny bit in the updates to t9100 I asked in a separate
message.
