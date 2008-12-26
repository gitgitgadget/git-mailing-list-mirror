From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFE: git-import-dsc should support http-links
Date: Thu, 25 Dec 2008 16:27:16 -0800
Message-ID: <7vk59n93x7.fsf@gitster.siamese.dyndns.org>
References: <gj06ks$ao9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Guido Guenther <agx@sigxcpu.org>
To: Rolf Leggewie <no2spam@nospam.arcornews.de>
X-From: git-owner@vger.kernel.org Fri Dec 26 01:29:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG0Zy-0004gI-9C
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 01:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbYLZA1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 19:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbYLZA1o
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 19:27:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbYLZA1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 19:27:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 798DB1B161;
	Thu, 25 Dec 2008 19:27:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0C7791B160; Thu,
 25 Dec 2008 19:27:36 -0500 (EST)
In-Reply-To: <gj06ks$ao9$1@ger.gmane.org> (Rolf Leggewie's message of "Thu,
 25 Dec 2008 15:51:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 01C1EF7A-D2E4-11DD-8F28-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103913>

Rolf Leggewie <no2spam@nospam.arcornews.de> writes:

> merry Christmas everyone.  I hope this is the right place for this, I
> looked around and it seemed to me it was, so here it goes.

Sorry, I have never heard of git-import-dsc and had to google for it, only
to find that it is one [*1*] of a set [*2*] of debian local tools somebody
I've never heard of (Cc'ed) on this list has written.

> It would be nice if the following just worked:
>
> "git-import-dsc
> http://ftp.de.debian.org/debian/pool/main/g/gnucash/gnucash_2.2.6-2.dsc"
> Regards
>
> Rolf

> PS: How about some kind of official bug tracker for git?

Even if there were such a thing, I do not think this report belongs to it.
I would imagine a better place would be here:

    http://bugs.debian.org/cgi-bin/pkgreport.cgi?package=git-buildpackage

[References]

*1* http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.man.git.import.dsc.html
*2* http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.man.git.buildpackage.html
