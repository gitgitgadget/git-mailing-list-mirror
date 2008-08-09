From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Fix multi-glob assertion in git-svn
Date: Sat, 09 Aug 2008 00:48:38 -0700
Message-ID: <7vskte8w89.fsf@gitster.siamese.dyndns.org>
References: <20080808084025.GA8718@untitled>
 <1218184918-9135-1-git-send-email-normalperson@yhbt.net>
 <7vk5erete1.fsf@gitster.siamese.dyndns.org> <20080809072806.GA20504@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marcus Griep <marcus@griep.us>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Aug 09 09:49:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRjCv-0000Az-Hu
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 09:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbYHIHsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 03:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753576AbYHIHsp
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 03:48:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbYHIHsp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 03:48:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 360B8511EF;
	Sat,  9 Aug 2008 03:48:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 54AD6511EE; Sat,  9 Aug 2008 03:48:40 -0400 (EDT)
In-Reply-To: <20080809072806.GA20504@untitled> (Eric Wong's message of "Sat,
 9 Aug 2008 00:28:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9758DEC8-65E7-11DD-AD96-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91749>

Eric Wong <normalperson@yhbt.net> writes:

> Shall I make those changes and resubmit or are they simple enough
> for you to do?

I've already queued them with fixups.  Thanks.
