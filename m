From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make 'git show' more useful
Date: Mon, 13 Jul 2009 15:11:16 -0700
Message-ID: <7vtz1gi67v.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0907131425490.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 00:25:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQTxY-00040e-2z
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 00:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbZGMWZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 18:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbZGMWZK
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 18:25:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbZGMWZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 18:25:10 -0400
X-Greylist: delayed 826 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2009 18:25:10 EDT
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA9E438B1;
	Mon, 13 Jul 2009 18:11:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D73F038B0; Mon, 13 Jul 2009
 18:11:17 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907131425490.13838@localhost.localdomain>
 (Linus Torvalds's message of "Mon\, 13 Jul 2009 14\:41\:12 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1861861A-6FFA-11DE-80AD-9AE02FB70C38-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123207>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> For some reason, I ended up doing
>
> 	git show HEAD~5..
>
> as an odd way of asking for a log.

Heh, I like that already.  Thanks ;-)
