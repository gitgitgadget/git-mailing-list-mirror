From: Junio C Hamano <gitster@pobox.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 17:54:08 -0800
Message-ID: <7vd4twe9mn.fsf@gitster.siamese.dyndns.org>
References: <200711252248.27904.jnareb@gmail.com>
	<20071127014804.GJ14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 02:54:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwpej-0007mz-GA
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 02:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbXK0ByP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 20:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbXK0ByP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 20:54:15 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52826 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbXK0ByO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 20:54:14 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5F7AA2F0;
	Mon, 26 Nov 2007 20:54:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E0F7C9A2CD;
	Mon, 26 Nov 2007 20:54:31 -0500 (EST)
In-Reply-To: <20071127014804.GJ14735@spearce.org> (Shawn O. Pearce's message
	of "Mon, 26 Nov 2007 20:48:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66157>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> All of the above is written with 20/20 hindsight and all that.
>
> Looking back (and knowing myself well) I think the only item I
> would have gotten right if I had written Git from scratch is the
> first one above (the tree entry ordering).  I probably would have
> done something equally "as bad" as what we have today for all of
> the others...

... not to mention countless others you would get wrong that you did not
list in the above, as the current git got them right ;-)
