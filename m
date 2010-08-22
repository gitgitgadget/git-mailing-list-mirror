From: Junio C Hamano <gitster@pobox.com>
Subject: Re: user-manual.html invalid HTML
Date: Sun, 22 Aug 2010 00:23:16 -0700
Message-ID: <7vvd735cwr.fsf@alter.siamese.dyndns.org>
References: <20081212023003.GD23128@sigill.intra.peff.net>
 <87hc5ahzy8.fsf@jidanni.org> <20100820050401.GC25013@burratino>
 <20100821062122.GA28735@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, jidanni@jidanni.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 22 09:27:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On4xp-0004hz-0d
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 09:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab0HVHX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 03:23:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab0HVHX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 03:23:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FEE2CD856;
	Sun, 22 Aug 2010 03:23:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=4OkQm2UlSTGyewngTrzwF55BZbo=; b=ptJRheryKAxDkFdW4BtTFPl
	tE1RyZp8Cgjb2/mY/jnRP6jbaD9jywwmvaRFloR4YEJkvP/CvcK1p7WMM5BZHghT
	N1P71LX7Ljh7J8mFvA5DnF0fJtTZSIJBORmaXhc1rdvW246wEfV978CbazB/fPT7
	20zTYMCLb+1oF0EWkeYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=PmG6m2VDc3SWpqHfDDPMaSVse1mGPd2TcTKFLa2DELRkGwZEE
	5t3Hpb+/CtAPZRt6o5zRQvYWROAJ33auEagNLDXpGw7XjYYYuomOfBoA1Vy13AUU
	FXvtpQAHTpQRLf8G81hhhNfigLvrSea36eXYYpNzPw2PcEDgfgsyl2pVac=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FBABCD852;
	Sun, 22 Aug 2010 03:23:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CDBBCD84E; Sun, 22 Aug
 2010 03:23:17 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 252F4546-ADBE-11DF-99A2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154173>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] docs: fix Makefile dependency for user manual

Thanks.
