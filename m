From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix incorrect wording in git-merge.txt.
Date: Mon, 03 Mar 2008 09:27:29 -0800
Message-ID: <7v63w3iupq.fsf@gitster.siamese.dyndns.org>
References: <1204564483-5260-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:29:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWETm-0008Ui-Ou
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 18:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761947AbYCCR1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 12:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761358AbYCCR1s
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 12:27:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757826AbYCCR1o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 12:27:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E93041FA1;
	Mon,  3 Mar 2008 12:27:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 599041FA0; Mon,  3 Mar 2008 12:27:33 -0500 (EST)
In-Reply-To: <1204564483-5260-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon, 3 Mar 2008 18:14:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75955>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> A merge is not necessarily with a remote branch, it can be with any
> commit object.

Thanks.  Sign-off, and perhaps mention other people who helped refine the
wording in the discussion?
