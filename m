From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2009, #02; Mon, 07)
Date: Mon, 07 Sep 2009 23:48:54 -0700
Message-ID: <7vws4agcdl.fsf@alter.siamese.dyndns.org>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
 <20090908153109.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 08:49:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkuVo-0007kW-6P
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 08:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbZIHGs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 02:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753261AbZIHGs6
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 02:48:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbZIHGs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 02:48:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B8652A005;
	Tue,  8 Sep 2009 02:49:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8cgjRmHY8if7z0dhtHefWtMViik=; b=s+ZR8CxRdTz8iUSDiVydLat
	ET3FVzq+j4SjsxAYFBFj5Ttu+sxvTujLfGVzst5Pbyq+tXPIPyifybbJYJ2Ap74J
	cjQSIGwdPPfqz1qKcx32+dfBAs4j88dPWQpBjbLCxOXuFqJrEBv1S+h2gTXD6xl3
	KjA/9FuYFZ0LM7l94PXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=sSfZYZXAAJGOGF6NNFztPAbDDfmRduOcbM7EzuwUKizNooP0f
	BLjXhMA9McdBloOlUjgnlxzGkRkMZ7vKLQ391pOR5uvpPa0r1cXM8pU82NJTIgJ5
	IhrpSQD3NSM/N8Wes6EXtSMWMzlxlIPf2FLMOPoIFQ25vf5La7zRDtNFDI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F0002A004;
	Tue,  8 Sep 2009 02:48:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 935332A003; Tue,  8 Sep
 2009 02:48:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AFA143CE-9C43-11DE-849F-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127976>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> ... I'm also hoping to tag the real 1.6.5 before I vanish for
>> about a week and half later in the month....
>
> Are you coming to Japan to promote your book, perhaps giving autographs at bookstores?

It will come out around 19th if things go as planned, but I'll be arriving
the week after that so I'll be too late for that kind of thing.

Besides, who would want an autographed copy of a technical book?

I should start asking the usual suspect to take things over while I'm
offline...
