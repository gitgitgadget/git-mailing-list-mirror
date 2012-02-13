From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bulgarian translation of git
Date: Mon, 13 Feb 2012 10:52:16 -0800
Message-ID: <7vehtyftwf.fsf@alter.siamese.dyndns.org>
References: <75009f1d7c4aba4d62bb226ab122932c@192.168.122.10>
 <CANYiYbGr3zN-kJwq_MCnttNZP6Cc0aj-fsZjd4V=4z+BA5TvUw@mail.gmail.com>
 <7vy5s7idxb.fsf@alter.siamese.dyndns.org> <20120213133957.GA4838@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Alexander Shopov
	 =?iso-2022-jp?B?KBskQichJ10nVidcJ2MnUSdfJ1UnbCdiGyhC?=
	 =?iso-2022-jp?B?IBskQic6J2AnYSdgJ1MbKEIp?= <lists@kambanaria.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 19:52:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx10h-0008NU-EO
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 19:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565Ab2BMSwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 13:52:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755801Ab2BMSwS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 13:52:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC7E47162;
	Mon, 13 Feb 2012 13:52:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MTy8udBQdKHoJd7l6tBi5IVRbs0=; b=n35e05
	TT2d9GS/vtesBghFTAA6cFmj6D9PHL3lNkw5eyg/WDGoRAvOBtsor+pV7ZEvH1jY
	BrnLv8cZ5tQPvoCaQlMr4OCl9Xt7eXbzy/GCMroi4pigLE6Ebd6a1DyiJhBrSskc
	JN7J1fdIuG6WpqiQ9hnRwWfHQWGX+eYwjGOt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f0vIMfgOrukVAJcIWcjujDjofANZKbaA
	7eY5s/m5obrqUmXvjK3iap/ndRlQX26UfhJsC5Ep6k94fSmtozibuxXgG2ZRd7XG
	fc0eYnARD2ieBa/kSPzwPAwzTQKqPgIec0dfAb6GMGq5lF2lPzwCp5bIBKXQCrWx
	+r0h/AnsbH4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2F617161;
	Mon, 13 Feb 2012 13:52:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 778267160; Mon, 13 Feb 2012
 13:52:17 -0500 (EST)
In-Reply-To: <20120213133957.GA4838@burratino> (Jonathan Nieder's message of
 "Mon, 13 Feb 2012 08:00:36 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9E97DDA-5673-11E1-A71A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190647>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hopefully that would make it easier for translators to keep both
> tracks well maintained at the same time.

I somehow think it is not such a big deal if l10n messages are not
maintained for maintenance tracks at all, actually, given that our cycles
for the master track have been 8-10 weeks long, which is not a long time
to wait, compared to 5 years people survived without any ;-).
