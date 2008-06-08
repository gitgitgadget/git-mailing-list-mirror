From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-remote.txt: remove description for
 useless -n option
Date: Sun, 08 Jun 2008 13:27:43 -0700
Message-ID: <7v63sjk6yo.fsf@gitster.siamese.dyndns.org>
References: <484B2DD3.8050307@free.fr>
 <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Olivier Marin <dkr@freesurf.fr>
To: dkr+ml.git@free.fr
X-From: git-owner@vger.kernel.org Sun Jun 08 22:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5RVp-0005AW-Lk
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 22:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbYFHU2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 16:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbYFHU2G
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 16:28:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322AbYFHU17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 16:27:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 52285355F;
	Sun,  8 Jun 2008 16:27:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CC18F355E; Sun,  8 Jun 2008 16:27:50 -0400 (EDT)
In-Reply-To: <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr>
 (dkr+ml.git@free.fr's message of "Sun, 8 Jun 2008 14:22:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 605200F4-3599-11DD-B4D2-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84314>

dkr+ml.git@free.fr writes:

> From: Olivier Marin <dkr@freesurf.fr>
>
> This option comes from the original git-remote.perl script and is not
> used nor needed in the current builtin.

Is this something we would want to document as a new feature, or just a
regression that makes the existing feature unusable when disconnected from
the network that needs to be fixed in the code?
