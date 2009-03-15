From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git checkout: one bugfix and one cosmetic change
Date: Sun, 15 Mar 2009 11:21:15 -0700
Message-ID: <7vab7m8x5w.fsf@gitster.siamese.dyndns.org>
References: <cover.1237115791.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sun Mar 15 19:26:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Liv2b-0007OB-GO
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 19:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbZCOSVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 14:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbZCOSVZ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 14:21:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbZCOSVY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 14:21:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C09C26BF2;
	Sun, 15 Mar 2009 14:21:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 16B796BEF; Sun,
 15 Mar 2009 14:21:16 -0400 (EDT)
In-Reply-To: <cover.1237115791.git.barvik@broadpark.no> (Kjetil Barvik's
 message of "Sun, 15 Mar 2009 12:38:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 15487BF2-118E-11DE-8633-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113291>

Kjetil Barvik <barvik@broadpark.no> writes:

> Just one small bugfix patch, and one small cosmetic change.
>
> By the way, I wonder how often the list of 'Primary Authors' and
> 'Contributors' on the webpage http://git-scm.com/about is updated.
> Should'nt it be updated when a new release, like v1.6.2, is made?

Thanks for noticing.  Though git-scm.com is not under my control, the site
is considered the official git homepage these days, and I am glad to see
improvements to its contents discussed here.  I do not see Scott very
often on this list these days, so I am CC'ing him.
