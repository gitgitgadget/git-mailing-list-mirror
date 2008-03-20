From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve description of git filter-branch.
Date: Thu, 20 Mar 2008 09:42:29 -0700
Message-ID: <7v3aqlxs7e.fsf@gitster.siamese.dyndns.org>
References: <20080315103900.GC14769@ins.uni-bonn.de>
 <20080320154338.GA4741@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 20 17:43:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcNrJ-0008FD-9a
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 17:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbYCTQmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 12:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757293AbYCTQmi
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 12:42:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbYCTQmh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 12:42:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A2BFD1A57;
	Thu, 20 Mar 2008 12:42:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 181011A56; Thu, 20 Mar 2008 12:42:31 -0400 (EDT)
In-Reply-To: <20080320154338.GA4741@ins.uni-bonn.de> (Ralf Wildenhues's
 message of "Thu, 20 Mar 2008 16:43:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77668>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> * Ralf Wildenhues wrote on Sat, Mar 15, 2008 at 11:39:00AM CET:
>> 
>> Now that I learned about filter-branch, here's my share of nits with its
>> documentation, a couple of language nits and inaccuracies.
> [...]
>
> I noted that this wasn't applied.  Is there something (or everything? ;-)
> wrong with the patch?

No, but I have not see anybody commented on it, so it was hard to tell if
there was anything good with the patch, either ;-)
