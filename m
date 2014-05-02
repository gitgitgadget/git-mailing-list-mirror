From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] CodingGuidelines: typofix
Date: Fri, 02 May 2014 11:31:10 -0700
Message-ID: <xmqqfvksav81.fsf@gitster.dls.corp.google.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
	<1398894312-30763-2-git-send-email-gitster@pobox.com>
	<87tx99zj31.fsf@fencepost.gnu.org>
	<xmqqoazhcrqg.fsf@gitster.dls.corp.google.com>
	<20140501212714.GB14441@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 20:31:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgIF0-0005rZ-QT
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 20:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbaEBSbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 14:31:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56117 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794AbaEBSbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 14:31:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 40BC81139D;
	Fri,  2 May 2014 14:31:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WpLKT3mBdcRp6EneUcHdx6eKdok=; b=QWT3PO
	tYcnTUS20qBE2Mkl5+ONxpsAm++wZfRuXi+COpolqO9E5P2GWFn/kRW0f8n4gEsy
	9KrA+JjqenJHWKHVMD+j9r8E43LRkRsL+OK6PrJ92KwBLt+87sBOlP1M88DmKv5a
	BVA5n2SPO1yPQlcGws1BWIpfyR1tiFnD/EoXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JWv0bvheiV419Qz8XQt6LPxpzbkEe6Lc
	tUf8lyoO9S0GohiMnB0rA1glSj0iGqgP3hysBtgjs+or7nls2W1ni3JlNCaeB95f
	/zv8uNjKMEbqJIxVoMIk3WH7UjDsNGD8Ubq/Wc7b3Cg8QovnCyHn+nfeFi8xyt2r
	CDyPE4OBRuU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33CAD1139C;
	Fri,  2 May 2014 14:31:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8297711398;
	Fri,  2 May 2014 14:31:12 -0400 (EDT)
In-Reply-To: <20140501212714.GB14441@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 1 May 2014 17:27:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F02089CC-D227-11E3-8661-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247951>

Jeff King <peff@peff.net> writes:

> On Thu, May 01, 2014 at 10:51:19AM -0700, Junio C Hamano wrote:
>
>> > If you want to fix something here, do s/judgement/judgment/ instead.
>> 
>> That too.
>
> FWIW, neither is outright wrong; it is an America/British variation, and
> apparently dictionaries disagree on which is preferred.

My reading of various "grammar" sites was that even though variation
exists[*1*], the form without 'e' is the traditionally preferred
form, and that is why I said "That too".

But let's follow this one:

http://www.google.com/trends/explore#q=judgement%20call%2C%20judgment%20call&cmpt=q

which seems to say that with 'e' is more common.


[Footnote]

*1* To Americans, the form with 'e' is abomination.  Wikipedia
claims that (1) without 'e' is in legal and (2) with 'e' in other
contexts in British (this particular one is a non-legal use), and
(3) both are equally acceptable in non-legal contexts in Austraria
and Canada.
