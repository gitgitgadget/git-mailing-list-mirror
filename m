From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Docs gitk: Explicitly mention -d, --date-order option
Date: Fri, 18 Apr 2008 23:58:22 -0700
Message-ID: <7v1w52ib5d.fsf@gitster.siamese.dyndns.org>
References: <1f748ec60804180616i311571eftbabcd3133ff83302@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Clifford Caoile" <piyo@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Apr 19 17:44:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jn72c-0007gX-9j
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 08:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbYDSG6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 02:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbYDSG6d
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 02:58:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbYDSG6c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 02:58:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D8BC2509;
	Sat, 19 Apr 2008 02:58:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BC4572506; Sat, 19 Apr 2008 02:58:25 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79892>

"Clifford Caoile" <piyo@users.sourceforge.net> writes:

> Git Mailing List, Git Maintainer:

Heh, my name is not "Git Maintainer" ;-)

> Regarding the documentation patch "[PATCH] Docs gitk: Explicitly
> mention -d, --date-order option" [1] (2008-04-12), it has not been
> accepted. Is there problem with this patch?
>
> References:
> [1] http://marc.info/?l=git&m=120799377618677&w=2

There isn't anything _wrong_ with the patch per se, but the current
documentation refers you to rev-list page and limits itself to the most
often used options.

I was waiting to see that many people jumping up and down saying that the
omission of --date-order from the "most often used" set was a grave bug
before applying it.  It hasn't happened.
