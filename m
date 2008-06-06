From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-clone still broken wrt. unpacking working tree with http
 transport
Date: Fri, 06 Jun 2008 16:30:18 -0700
Message-ID: <7vve0mqgz9.fsf@gitster.siamese.dyndns.org>
References: <0F5C1FC7-258E-44A4-9FE6-AB6696D0B5BE@rapleaf.com>
 <20080606061428.GF18257@sigill.intra.peff.net>
 <32A340A4-BB0C-4D0E-9B8D-A4FCEA4B24D1@rapleaf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@rapleaf.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:31:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4lP1-0002w6-FF
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758220AbYFFXa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758125AbYFFXa3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:30:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758115AbYFFXa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:30:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B2DFF2E39;
	Fri,  6 Jun 2008 19:30:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1ED932E38; Fri,  6 Jun 2008 19:30:21 -0400 (EDT)
In-Reply-To: <32A340A4-BB0C-4D0E-9B8D-A4FCEA4B24D1@rapleaf.com> (Kevin
 Ballard's message of "Fri, 6 Jun 2008 16:28:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A704B5E-3420-11DD-AF57-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84144>

Kevin Ballard <kevin@rapleaf.com> writes:

> No I didn't. I guess it's just bad luck that 541fc218 was committed a
> few hours before I reported the issue ;) I generally git-pull in the
> morning, so I pulled before that got committed.
>
> Actually, I ran into it last week but forgot to mention it then.

That's Ok.  I tried this locally and it seems to work ;-)
