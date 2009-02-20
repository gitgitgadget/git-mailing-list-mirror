From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC v2 0/3] git checkout optimisation - part 3
Date: Fri, 20 Feb 2009 10:03:57 +0100
Organization: private
Message-ID: <86r61tiio2.fsf@broadpark.no>
References: <cover.1235071656.git.barvik@broadpark.no>
 <7vfxi9fqup.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 10:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaRK5-0006Gr-5i
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 10:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbZBTJEC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 04:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbZBTJEB
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 04:04:01 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:34419 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbZBTJD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 04:03:59 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFC001P2X6MD620@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Fri, 20 Feb 2009 10:03:58 +0100 (CET)
Received: from localhost ([84.48.79.78]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFC00JQ3X6L9480@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Fri, 20 Feb 2009 10:03:58 +0100 (CET)
In-reply-to: <7vfxi9fqup.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110823>

Junio C Hamano <gitster@pobox.com> writes:
> Hmm, have you noticed that the rest of the stuff are queued on 'next'?

  Yes, I have!  I was also glad to receive my first acked-by git-tag!!
  :-)
