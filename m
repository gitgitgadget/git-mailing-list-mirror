From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Incorrect v1.7.10.4 tag on github?
Date: Mon, 02 Jul 2012 14:58:48 -0700
Message-ID: <7vy5n1ygdj.fsf@alter.siamese.dyndns.org>
References: <77A5E1CD-836A-4747-9E62-42C25C0D8B7D@sfu.ca>
 <20120615182534.GB14843@sigill.intra.peff.net>
 <7vvcis9ylx.fsf@alter.siamese.dyndns.org>
 <CAPBPrnspD3uC6_wd7nqMUVgHSt4Frwy8UaYL6fU73kJKX6=XWQ@mail.gmail.com>
 <7v7gulzxme.fsf@alter.siamese.dyndns.org>
 <CAP2yMaLy3sBwybMH2LYs9Sg0AigZ-_tAx4SbHOrwr3T6GfLSaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Johnson <computerdruid@gmail.com>, Jeff King <peff@peff.net>,
	Graham Ballantyne <grahamb@sfu.ca>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:58:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sloe0-0007MO-6u
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 23:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549Ab2GBV6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 17:58:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755629Ab2GBV6v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 17:58:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B87B48822;
	Mon,  2 Jul 2012 17:58:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PGz10FZYm/ZSckvGtFhLMpHE+xg=; b=X2/ktJ
	6+tkRPvvNtxllizaw/kieLkppYNDSsqJ36KidsRyyY2H8mDoz9+ODddPT8EEwBU1
	yROVMaqvcwD6zGE6aIKv0jM/0/Sc5LRhemJcFdgCUH+OTbgWPp2E3lprJB/teLJE
	OFeEJ9OoS4lCQIUUAjP/Hpi+qzhc55EqauxKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=obMRyojQGICwb9/pj7jUil4Tap3nKS9b
	W1YtNCWo/WuvSPQgKSnmDZofPiML+FuQGApXkLWIfd20wSSFrz3/JjTO7kLp0snJ
	J0a+r6i8Ni3nc5Uojm8o3xrhyLBPB7imllXCct60vcHECLdnV9oMW+Y6MtQoSTeB
	fkxfuFUoHgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEAD48821;
	Mon,  2 Jul 2012 17:58:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44CA68820; Mon,  2 Jul 2012
 17:58:50 -0400 (EDT)
In-Reply-To: <CAP2yMaLy3sBwybMH2LYs9Sg0AigZ-_tAx4SbHOrwr3T6GfLSaw@mail.gmail.com> (Scott
 Chacon's message of "Mon, 2 Jul 2012 14:11:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B2AF2E8-C491-11E1-9422-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200866>

Scott Chacon <schacon@gmail.com> writes:

> Thanks for letting me know - I didn't realize that the built tarballs
> were different from the tagged commit trees.  I will update the links.

Thanks.
