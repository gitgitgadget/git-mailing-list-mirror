From: Nix <nix@esperi.org.uk>
Subject: Re: [RFC PATCH] t5538: move http push tests out to t5542
Date: Fri, 30 May 2014 19:33:01 +0100
Message-ID: <8761kn86ci.fsf@spindle.srvr.nix>
References: <87y4xk8asq.fsf@spindle.srvr.nix>
	<20140530010649.GD28683@sigill.intra.peff.net>
	<20140530013419.GE28683@sigill.intra.peff.net>
	<87lhtj8sqx.fsf_-_@spindle.srvr.nix>
	<xmqqr43b9o0l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 20:33:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqRcC-00034B-62
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 20:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbaE3SdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 14:33:12 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:54730 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbaE3SdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 14:33:12 -0400
Received: from spindle.srvr.nix (nix@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.9/8.14.8) with ESMTP id s4UIX1iX009471;
	Fri, 30 May 2014 19:33:01 +0100
Emacs: because idle RAM is the Devil's playground.
In-Reply-To: <xmqqr43b9o0l.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 30 May 2014 10:26:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
X-DCC-INFN-TO-Metrics: spindle 1233; Body=3 Fuz1=3 Fuz2=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250462>

On 30 May 2014, Junio C. Hamano said:

> Nix <nix@esperi.org.uk> writes:
>
>> (signed off with my work email address for paranoia's sake.)
>
> As long as your employer is fine with your patch contributed to us,

My employer encourages it.

> and assuming that the patch was done on your employer's time, it

That is hard to define, but I use this copy of git for work purposes as
well as non-work purposes, so I arbitrarily define it as done on their
time.

> would be the right thing to do ;-).  Just FYI, if your From: address
> on your e-mail does not match that address, you can start your
> message body with "From: Nick Alcock <nick.alcock@oracle.com>", a
> blank line and then the true body of your message.

Yeah, I oscillated on that and picked the wrong option in the end. :)
