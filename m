From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Wed, 01 Dec 2010 11:30:23 -0800
Message-ID: <7vzkspuw8g.fsf@alter.siamese.dyndns.org>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
 <20101201165043.GF26120@burratino> <87r5e1v2g8.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 20:31:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsOT-00031p-1f
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756688Ab0LATaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:30:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683Ab0LATac (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:30:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C3D329ED;
	Wed,  1 Dec 2010 14:30:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DoCY3yyFgpzTHOVdjjzQwGFN3/w=; b=d5S+N3
	dAClOwcFhWt7WvJQXM6CEl887RXbrnaTblOxuEk0OO6wlB15SvKygmkazc3jMmmR
	C/u8RMf1BA+47ZBW7JZ909URkAPxfKU1KoNAts/C9ZjN7rMj3gll+aNjsSBpwd3x
	N2X/lkYjafPDgd5xJFaVKLEx7ymlk3+1wBdmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l9fNl683K5/0YWxbLfBfUpndbuH3+Ond
	/zNFBkHCEcs6yPfIDKHymhlwxdUoUg9tFggni3m9HsYwXA2wkblLcCDJByhudm+z
	569RTP7MKeMGiwoa3eyVTQbfbm8lDdyiXbW/PsldOP0LKxwZ1/RGUz6kdO91LOrW
	st0vh/KWtLg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F1C0D29EC;
	Wed,  1 Dec 2010 14:30:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 052B229EA; Wed,  1 Dec 2010
 14:30:43 -0500 (EST)
In-Reply-To: <87r5e1v2g8.fsf@picasso.cante.net> (Jari Aalto's message of
 "Wed\, 01 Dec 2010 19\:16\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F19ACF0-FD81-11DF-B9BE-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162579>

Jari Aalto <jari.aalto@cante.net> writes:

>> why would I want sorted option lists in all manpages?
>
> Does that really need an answer?

Yes.

> You read from top to bottom, therefore
> A-Z.

I used to think that back when I referred to printed documentation more
often than online, but not anymore.  Alphabetical ordering is somewhat
last century; the documentation is often more useful if the options are
grouped together by features and concepts they relate to.
