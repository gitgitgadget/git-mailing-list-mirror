From: Junio C Hamano <gitster@pobox.com>
Subject: Re: remote#branch
Date: Mon, 29 Oct 2007 20:40:06 -0700
Message-ID: <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
References: <20071016021933.GH12156@machine.or.cz>
	<Pine.LNX.4.64.0710161139530.25221@racer.site>
	<20071016210904.GI26127@efreet.light.src>
	<Pine.LNX.4.64.0710162228560.25221@racer.site>
	<20071027204757.GA3058@efreet.light.src>
	<Pine.LNX.4.64.0710280000240.4362@racer.site>
	<20071029174000.GA4449@efreet.light.src>
	<alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
	<20071029214925.GH21133@thunk.org>
	<alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
	<20071030030104.GK21133@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 30 04:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imhxx-0007Px-Fs
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 04:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbXJ3DkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 23:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbXJ3DkU
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 23:40:20 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:45200 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbXJ3DkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 23:40:19 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 885E32EF;
	Mon, 29 Oct 2007 23:40:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DF4D68F280;
	Mon, 29 Oct 2007 23:40:31 -0400 (EDT)
In-Reply-To: <20071030030104.GK21133@thunk.org> (Theodore Tso's message of
	"Mon, 29 Oct 2007 23:01:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62653>

Theodore Tso <tytso@mit.edu> writes:

> It would probably also be a good idea to expurgate URL's from the
> documentations, because, well, they aren't URL's.  Git doesn't treat
> them like URL's, and you've said you aren't interested in changing git
> to treat them like URL's, and finally git:// isn't a registered URL
> scheme name with the IANA registration authority.  So let's not call
> them URL's, since they're clearly not.

Are you playing reverse psychology, encouraging us to switch to
RFC-conforming quoting?
