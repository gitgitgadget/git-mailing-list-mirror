From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Include rev-list options in git-log manpage.
Date: Fri, 18 Jan 2008 15:12:21 -0800
Message-ID: <7v7ii6buei.fsf@gitster.siamese.dyndns.org>
References: <20080117214425.GP29972@genesis.frugalware.org>
	<7vejcfiop4.fsf@gitster.siamese.dyndns.org>
	<20080118161714.GS29972@genesis.frugalware.org>
	<4790D5B7.2000508@viscovery.net>
	<20080118171827.GV29972@genesis.frugalware.org>
	<7v8x2mewtt.fsf@gitster.siamese.dyndns.org>
	<20080118225026.GX29972@genesis.frugalware.org>
	<20080118225857.GY29972@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 00:13:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG0Of-0008CL-O4
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 00:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758747AbYARXMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 18:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758545AbYARXMg
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 18:12:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757942AbYARXMf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 18:12:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B2A06E51;
	Fri, 18 Jan 2008 18:12:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CB816E4E;
	Fri, 18 Jan 2008 18:12:28 -0500 (EST)
In-Reply-To: <20080118225857.GY29972@genesis.frugalware.org> (Miklos Vajna's
	message of "Fri, 18 Jan 2008 23:58:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71074>

Miklos Vajna <vmiklos@frugalware.org> writes:

>> Fixed.
>
> My bad, the previous version introduced two typos (ref-list instead of
> rev-list). This one should be OK.

Now, this moves option descriptions of git-log around for no
good reason, other than that it was more convenient in the
source.

Which is not a very good excuse in general, but I do not think
the original ordering was carefully designed to be optimal for
the readers either, so let's take it.

Thanks.
