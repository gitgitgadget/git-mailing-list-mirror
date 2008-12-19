From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify git-format-patch --in-reply-to
Date: Fri, 19 Dec 2008 15:07:25 -0800
Message-ID: <7vhc4z7oia.fsf@gitster.siamese.dyndns.org>
References: <87k59wc73n.fsf@jidanni.org>
 <7vzlitho1o.fsf@gitster.siamese.dyndns.org>
 <20081220065135.6117@nanako3.lavabit.com>
 <20081219222209.GG21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, jidanni@jidanni.org,
	gitster@pobox.com, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 20 00:08:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDoSk-0007fs-G5
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 00:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbYLSXHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 18:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbYLSXHf
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 18:07:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbYLSXHe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 18:07:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 917AE89C2C;
	Fri, 19 Dec 2008 18:07:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5C7B289C29; Fri,
 19 Dec 2008 18:07:27 -0500 (EST)
In-Reply-To: <20081219222209.GG21154@genesis.frugalware.org> (Miklos Vajna's
 message of "Fri, 19 Dec 2008 23:22:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D18BEB88-CE21-11DD-8D79-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103596>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Sat, Dec 20, 2008 at 06:51:35AM +0900, Nanako Shiraishi <nanako3@lavabit.com> wrote:
>> I understand that "Signed-off-by" is about code ownership and thought
>> that the official history prefers to have a real name instead of a
>> pseudonym. Perhaps you would want to say "Dan Jacobson
>> <jidanni@jidanni.org>" or something similar?
>
> I don't think it's a requirement, see 2b36b14 for example. Though yes,
> in general it's considered childish to hide behind a nickname, instead
> of using your real name. (ESR has a section about this in the "hacker
> howto".)

An earlier mistake does not justify adding new ones.  Besides, I think
ALASCM once revealed his "real name" on the list.
