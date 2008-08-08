From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: use $TEST_DIRECTORY to refer to the t/ directory
Date: Fri, 08 Aug 2008 03:40:43 -0700
Message-ID: <7vmyjndc2c.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <489BF95F.1070000@lsrfire.ath.cx> <7vprojgbbu.fsf@gitster.siamese.dyndns.org>
 <7vod43etuw.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808081232210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 12:42:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRPPu-0007Gg-S0
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 12:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbYHHKkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 06:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbYHHKkw
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 06:40:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbYHHKkw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 06:40:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B93850C99;
	Fri,  8 Aug 2008 06:40:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A602450C98; Fri,  8 Aug 2008 06:40:46 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808081232210.9611@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Fri, 8 Aug 2008 12:35:12 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 77F59C94-6536-11DD-B6DB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91653>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Frankly, I do not have the time.  It is not only about looking what you 
> changed, but also what you did not change.

That's Ok.  You are not (and you shouldn't be) the only person who is
capable of reviewing and helping the development process ;-)

Hint, hint...
