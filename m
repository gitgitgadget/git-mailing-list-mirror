From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] parse_commit_buffer: don't parse invalid commits
Date: Sun, 13 Jan 2008 15:23:04 -0800
Message-ID: <7vzlv9nwdj.fsf@gitster.siamese.dyndns.org>
References: <12002478702664-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Jan 14 00:23:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JECBC-0005wE-4g
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 00:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbYAMXXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 18:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbYAMXXV
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 18:23:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651AbYAMXXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 18:23:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B471C3EFB;
	Sun, 13 Jan 2008 18:23:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6007B3EFA;
	Sun, 13 Jan 2008 18:23:17 -0500 (EST)
In-Reply-To: <12002478702664-git-send-email-mkoegler@auto.tuwien.ac.at>
	(Martin Koegler's message of "Sun, 13 Jan 2008 19:11:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70423>

I think I saw this patch and vaguely recall commenting on it,
but your message is not very helpful locating the previous
thread to see what kind of improvements are made to this new
round.
