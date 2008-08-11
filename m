From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adjust for the new way of enabling the default
 post-update hook
Date: Mon, 11 Aug 2008 16:15:58 -0700
Message-ID: <7vbpzzuor5.fsf@gitster.siamese.dyndns.org>
References: <20080811223446.8342.37008.stgit@localhost>
 <7vfxpbuplr.fsf@gitster.siamese.dyndns.org>
 <20080811230540.GG10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 12 01:17:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSgdU-0007hi-IH
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbYHKXQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbYHKXQI
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:16:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbYHKXQH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:16:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 260CF5CD89;
	Mon, 11 Aug 2008 19:16:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EFF365CD86; Mon, 11 Aug 2008 19:16:00 -0400 (EDT)
In-Reply-To: <20080811230540.GG10151@machine.or.cz> (Petr Baudis's message of
 "Tue, 12 Aug 2008 01:05:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 78C1CD42-67FB-11DD-9627-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92021>

Petr Baudis <pasky@suse.cz> writes:

>> The rest of the patches look good, but have you actually made sure
>> AsciiDoc markups are correct (I am not complaining, just asking, as I
>> haven't)?
>
> I haven't - actually, for various technical reasons, I don't even have
> AsciiDoc installed on my notebook right now. I plan to get around
> to investigate the problem, but didn't yet and I didn't want to hold
> this off.

Thanks, I just wanted to know if I have to be extra careful about the
mark-up.
