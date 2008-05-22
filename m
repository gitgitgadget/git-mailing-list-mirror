From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Two minor tweaks on git-gui where textboxes weren't vertically
 centered with their labels and buttons
Date: Thu, 22 May 2008 16:59:08 -0700
Message-ID: <7vabihvqk3.fsf@gitster.siamese.dyndns.org>
References: <412a1d9a0805172218v7c0a920es8a48129014051a35@mail.gmail.com>
 <20080519040746.GA29038@spearce.org>
 <412a1d9a0805182234i18e2da4ckf428b2c134e174d1@mail.gmail.com>
 <alpine.DEB.1.00.0805191127200.30431@racer>
 <7vej7w6syo.fsf@gitster.siamese.dyndns.org>
 <20080522121107.GK29038@spearce.org>
 <7v4p8qw7to.fsf@gitster.siamese.dyndns.org>
 <20080522225730.GQ29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Twiinz <twiinz@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 23 02:00:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzKhi-0007e6-C8
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 02:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759497AbYEVX7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 19:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759205AbYEVX7X
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 19:59:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759497AbYEVX7V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 19:59:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2AA7F4051;
	Thu, 22 May 2008 19:59:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CC0854045; Thu, 22 May 2008 19:59:10 -0400 (EDT)
In-Reply-To: <20080522225730.GQ29038@spearce.org> (Shawn O. Pearce's message
 of "Thu, 22 May 2008 18:57:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 180D0E9C-285B-11DD-BB2C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82672>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> > In this case it is a very trivial patch.
>> 
>> Yeah, I realized that I should have added that after sending the message.
>> I'd rather not to see a patch without S-o-b than with a S-o-b with a
>> phoney name, though.
>
> Like this one?

Sorry, your comparison is worse than apples-and-oranges.

Gitzilla was a relatively old-timer, already known entity in git circle
for quite some time, when we accepted that patch (also I think we know the
real name as well, check your local list archive).

In either case, that one and the one under discussion are both trivially
obvious changes and do not give us much worries.
