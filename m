From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push mirror mode
Date: Thu, 08 Nov 2007 13:53:33 -0800
Message-ID: <7vk5os1k0y.fsf@gitster.siamese.dyndns.org>
References: <20071108121136.GG9736@shadowen.org>
	<Pine.LNX.4.64.0711081218090.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 22:54:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqFKO-0004Rm-WB
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 22:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759863AbXKHVxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 16:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758264AbXKHVxq
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 16:53:46 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56834 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759348AbXKHVxp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 16:53:45 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2A25B2F2;
	Thu,  8 Nov 2007 16:54:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9BB6D939FF;
	Thu,  8 Nov 2007 16:53:58 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711081218090.4362@racer.site> (Johannes
	Schindelin's message of "Thu, 8 Nov 2007 12:19:18 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64079>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 8 Nov 2007, Andy Whitcroft wrote:
>
>> Ok, sometime back Junio sent out a proof-of-concept change to
>> send-pack allowing a mirror mode.
>
> You added/left his sign-off, but did not attribute the patches to him.  

No big deal; I do not think much of my changes remain in the
result.  Mentioning "inspired by" would be nice as courtesy, but
I think this is mostly Andy's work.

As I haven't seen _his_ part of the change before he posted this
updated patch, copying my S-o-b line wasn't necessary either.
