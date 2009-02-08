From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.2-rc0
Date: Sun, 08 Feb 2009 01:43:58 -0800
Message-ID: <7vvdrlz2jl.fsf@gitster.siamese.dyndns.org>
References: <7vvdrlsyjm.fsf@gitster.siamese.dyndns.org>
 <vpqprhte3rs.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Feb 08 10:45:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6EK-0003pR-3r
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 10:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbZBHJoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 04:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbZBHJoH
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 04:44:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbZBHJoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 04:44:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4541597395;
	Sun,  8 Feb 2009 04:44:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EA79497391; Sun,
  8 Feb 2009 04:44:00 -0500 (EST)
In-Reply-To: <vpqprhte3rs.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun, 08 Feb 2009 09:23:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 06295874-F5C5-11DD-AE29-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108937>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> GIT v1.6.2 Release Notes (draft)
>> ================================
>>
>> With the next major release, "git push" into a branch that is
>> currently checked out will be refused by default.  You can choose
>> what should happen upon such a push by setting the configuration
>> variable receive.denyCurrentBranch in the receiving repository.
>
> Perhaps this paragraph should tell _why_ this is a dangerous
> operation.

I considered it, but that is not what Release Notes is about.  It should
be a table-of-contents of the highlights in the new release.  Interested
parties can look at the documentation for gory details.
