From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame --porcelain
Date: Sun, 20 Jul 2008 13:34:32 -0700
Message-ID: <7vzloc47mv.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0807201328i41aa7d09jf9a1c4dc6f60a367@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sun Jul 20 22:35:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKfd2-0000CV-Ix
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 22:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbYGTUek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 16:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbYGTUej
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 16:34:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbYGTUei (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 16:34:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 67C8035340;
	Sun, 20 Jul 2008 16:34:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E07353461F; Sun, 20 Jul 2008 16:34:34 -0400 (EDT)
In-Reply-To: <bd6139dc0807201328i41aa7d09jf9a1c4dc6f60a367@mail.gmail.com>
 (Sverre Rabbelier's message of "Sun, 20 Jul 2008 22:28:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 45536130-569B-11DD-8575-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89228>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> Is it called '--porcelain' because it is

to help porcelain writers.
