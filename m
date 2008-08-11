From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule - Add 'foreach' subcommand
Date: Mon, 11 Aug 2008 13:40:32 -0700
Message-ID: <7vhc9rwain.fsf@gitster.siamese.dyndns.org>
References: <7vsktczebg.fsf@gitster.siamese.dyndns.org>
 <1218409804-1556-1-git-send-email-mlevedahl@gmail.com>
 <20080811102344.GG32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, johan@herland.net
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:41:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSeD1-0000X6-MS
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 22:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbYHKUkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 16:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbYHKUkl
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 16:40:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbYHKUkk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 16:40:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C292556B9;
	Mon, 11 Aug 2008 16:40:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 69C29556B8; Mon, 11 Aug 2008 16:40:34 -0400 (EDT)
In-Reply-To: <20080811102344.GG32184@machine.or.cz> (Petr Baudis's message of
 "Mon, 11 Aug 2008 12:23:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2CC506C-67E5-11DD-A08B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91995>

Petr Baudis <pasky@suse.cz> writes:

>   in principle, this looks pretty sensible.
> ...
> I think "evaluates" is a better word here, too.

I think your refinements all make sense.  Thanks for commenting.
