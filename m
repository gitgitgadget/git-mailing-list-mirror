From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should we discuss Windows-related changes on git@vger.kernel.org?
Date: Fri, 11 Jul 2008 16:06:57 -0700
Message-ID: <7vmykohvfy.fsf@gitster.siamese.dyndns.org>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de>
 <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness>
 <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de>
 <alpine.DEB.1.00.0807111652170.8950@racer>
 <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de>
 <alpine.DEB.1.00.0807111930160.8950@racer>
 <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org>
 <alpine.DEB.1.00.0807112037220.8950@racer>
 <0E93411E-745C-4858-999E-F0B7487B48B1@zib.de>
 <alpine.DEB.1.00.0807112226190.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 01:08:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHRih-00031N-5Y
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 01:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbYGKXHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 19:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbYGKXHJ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 19:07:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57319 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbYGKXHH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 19:07:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6112B29ABC;
	Fri, 11 Jul 2008 19:07:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7AA8F29AB8; Fri, 11 Jul 2008 19:06:59 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807112226190.8950@racer> (Johannes
 Schindelin's message of "Fri, 11 Jul 2008 22:38:23 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 14D40E64-4F9E-11DD-A3B3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88197>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And if the separation is not always that clear, why not discuss those 
> things on msysGit first, and then come to git@vger with our minds (and 
> possibly our patches) made up?

I know you mean well, but my impression from reading the kernel list is
that often a message that says "we already debated this issue on our list
to death and here is our conclusion, take it or leave it" to the audience
is not accepted warmly, and more central kernel people may even say "do
not hide the discussion in the subsystem list, do it in the open,
discussion on the subsystem list does not matter".

Taking that lesson from the other community, I'd suggest that it is
probably a good idea to start discussion on your list, but once (some)
people in the discussion think the topic is releavant here, move it here
sooner rather than later.
