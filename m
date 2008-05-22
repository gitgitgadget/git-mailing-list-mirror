From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Two minor tweaks on git-gui where textboxes weren't vertically
 centered with their labels and buttons
Date: Thu, 22 May 2008 10:46:11 -0700
Message-ID: <7v4p8qw7to.fsf@gitster.siamese.dyndns.org>
References: <412a1d9a0805172218v7c0a920es8a48129014051a35@mail.gmail.com>
 <20080519040746.GA29038@spearce.org>
 <412a1d9a0805182234i18e2da4ckf428b2c134e174d1@mail.gmail.com>
 <alpine.DEB.1.00.0805191127200.30431@racer>
 <7vej7w6syo.fsf@gitster.siamese.dyndns.org>
 <20080522121107.GK29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Twiinz <twiinz@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 22 19:47:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzEsr-0002kd-3s
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 19:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbYEVRqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 13:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbYEVRq3
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 13:46:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbYEVRq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 13:46:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A1367479F;
	Thu, 22 May 2008 13:46:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 011DC4798; Thu, 22 May 2008 13:46:19 -0400 (EDT)
In-Reply-To: <20080522121107.GK29038@spearce.org> (Shawn O. Pearce's message
 of "Thu, 22 May 2008 08:11:07 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FFCD074E-2826-11DD-B89F-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82641>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > The Signed-off-by is not so much for _you_ as for the people who _use_ 
>> > what you contributed, so that they can always say "but Twiinz signed off 
>> > on it, he said that he will not sue my $ss off later, like this Darl 
>> > b$stard".
>> >
>> > So yes, I do worry.
>> 
>> It is not about him suing us, but more about "He certified that he did not
>> steal it from anywhere else", iow, other people suing us for what he did.
>> 
>> And we should worry.
>
> In this case it is a very trivial patch.

Yeah, I realized that I should have added that after sending the message.
I'd rather not to see a patch without S-o-b than with a S-o-b with a
phoney name, though.
