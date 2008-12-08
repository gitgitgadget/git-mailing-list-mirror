From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Starting translation for Norwegian
Date: Mon, 08 Dec 2008 08:50:47 -0800
Message-ID: <7vvdtu7grc.fsf@gitster.siamese.dyndns.org>
References: <20081203225411.GA12563@frsk.net>
 <20081208163103.GF31551@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Skolmli <fredrik@frsk.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 08 17:52:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9jLT-0006xM-4B
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 17:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbYLHQvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 11:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbYLHQvG
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 11:51:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbYLHQvF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 11:51:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 03EDD85A01;
	Mon,  8 Dec 2008 11:51:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 80298859FF; Mon,
  8 Dec 2008 11:50:56 -0500 (EST)
In-Reply-To: <20081208163103.GF31551@spearce.org> (Shawn O. Pearce's message
 of "Mon, 8 Dec 2008 08:31:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 65F7867A-C548-11DD-A54D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102557>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> If there are any issues with character encoding etc and you'd like it as an
>> attachment, please let me know.
>
> Can you resend as an attachment?  The email encoding is listed as
> iso-8859-1 but the file content looks to be UTF-8.  msgfmt doesn't
> like it after the patch is applied.

Hmm, that is interesting.

If the first non-ASCII character in the resulting file between "Bokm" and
"l" should look like an angstrom, I think the copy I received was fine.

Even though "Subject" says gitk but it is not about git-gui, though ;-)
