From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Many things pushed out to 'master'
Date: Mon, 03 Dec 2007 10:19:00 -0800
Message-ID: <7v1wa3iquj.fsf@gitster.siamese.dyndns.org>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
	<ee77f5c20712021539r3075fc57ld6a4cec737e6043d@mail.gmail.com>
	<7vabosse23.fsf@gitster.siamese.dyndns.org>
	<7vbq98jdy5.fsf_-_@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712031109380.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:19:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFtA-0008Ao-8K
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbXLCSTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbXLCSTH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:19:07 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34659 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbXLCSTG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:19:06 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 06CAF2F0;
	Mon,  3 Dec 2007 13:19:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B4A99C7C4;
	Mon,  3 Dec 2007 13:19:25 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712031109380.27959@racer.site> (Johannes
	Schindelin's message of "Mon, 3 Dec 2007 11:12:34 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66941>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But I remembered that you requested a mode for signed tags where they 
> would just be copied.  I just realised while implementing "verbatim" that 
> "ignore" does just that.  Maybe we should rename this mode to "verbatim"?
>
> And maybe you want to make it the default (even if I think that this will 
> result in more surprise moments than the current mode which aborts).

I did not hear others agreeing with me, so let's respect the original
author's thinking.
