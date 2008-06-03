From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 03 Jun 2008 00:53:26 -0700
Message-ID: <7vskvv2bux.fsf@gitster.siamese.dyndns.org>
References: <200806030314.03252.jnareb@gmail.com>
 <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
 <200806030932.03051.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 09:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3RMV-0006uD-Hp
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 09:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYFCHyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 03:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752792AbYFCHxv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 03:53:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbYFCHxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 03:53:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B124938AA;
	Tue,  3 Jun 2008 03:53:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E182138A9; Tue,  3 Jun 2008 03:53:34 -0400 (EDT)
In-Reply-To: <200806030932.03051.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue, 3 Jun 2008 09:32:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E673498-3142-11DD-A706-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83625>

Jakub Narebski <jnareb@gmail.com> writes:

> [*1*] I assume that this kind of merge is called 'octopus' because it
>       has more than two "legs" (parents), and not for example because
>       first such merge had 8 parents?

The first one ever was actually a pentapus, 211232b (Octopus merge of the
following five patches., 2005-05-05).

"gitk 211232b" was a beautiful sight back then, and it still is.  The
history was much simpler back then.
