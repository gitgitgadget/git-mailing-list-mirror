From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git as an sfc member project
Date: Fri, 22 Oct 2010 16:26:41 -0700
Message-ID: <7vd3r1kdvy.fsf@alter.siamese.dyndns.org>
References: <20101022183027.GA12124@sigill.intra.peff.net>
 <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
 <7vocalkf53.fsf@alter.siamese.dyndns.org>
 <20101022231820.GB25520@sigill.intra.peff.net>
 <S3I346LWUOykFBiCrFLgbfYptyYvHyj1Jcdo6EHe-2fWosEUh4Va3g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Oct 23 01:27:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9R0l-0002AV-Lw
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 01:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab0JVX0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 19:26:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab0JVX0x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 19:26:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 744BDE0D1B;
	Fri, 22 Oct 2010 19:26:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Eocmxqsqldfkwg4aQlycRKD5A8=; b=NBWPSF
	f9aui4y/zfCujeD3tG4zKG/4mCJhshmPkodTkfYCIQKwYw+ufu7VhgZBBLYhEfGS
	J39JVKGkdx00d+qifZAeYQe6EqB9ZZRvhv8wJOFiQWr4+pP21vlM4KeiU+z/0Zwh
	MmPNPyQ5RfZi3zSCnj3TUZX+eF6chmpCkyyR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OrLwYVzwIiw4QNe2At2P7B1iDwH7mptY
	42MKFPNjl2E2FYK5u8IJGBqeY84dB4s5igBQE6quBPPC3HDcL5+Ui6tZp6aPopPd
	LCbUpvdbj7pDuw/x+F2czOBtrhxS5st5z55w3oiDy1dDu9PoCDuM+Cf9dqAtw9iK
	yLa7IFfe5q8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 24CE4E0D1A;
	Fri, 22 Oct 2010 19:26:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37F77E0D16; Fri, 22 Oct
 2010 19:26:43 -0400 (EDT)
In-Reply-To: <S3I346LWUOykFBiCrFLgbfYptyYvHyj1Jcdo6EHe-2fWosEUh4Va3g@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\, 22 Oct 2010 18\:21\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7E4A5D2-DE33-11DF-89AF-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159765>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> ...  I think Junio's number are
> all doubled.

Yeah, I think you are right.
