From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] bash completion: add 'rename' subcommand to
 git-remote
Date: Wed, 21 Jan 2009 02:26:32 -0800
Message-ID: <7veiyxeyzr.fsf@gitster.siamese.dyndns.org>
References: <200901162254.58300.markus.heidelberg@web.de>
 <20090116221203.GP10179@spearce.org>
 <7vd4em8ilx.fsf@gitster.siamese.dyndns.org>
 <200901201921.10223.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Wed Jan 21 11:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPaJc-0000qw-1M
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 11:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092AbZAUK0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 05:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbZAUK0m
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 05:26:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbZAUK0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 05:26:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 56C0C1CED5;
	Wed, 21 Jan 2009 05:26:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6F1531CE92; Wed,
 21 Jan 2009 05:26:34 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FD216514-E7A5-11DD-AC3C-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106589>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> Junio C Hamano, 17.01.2009:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> 
>> > Markus Heidelberg <markus.heidelberg@web.de> wrote:
>> >> 
>> >> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
>> >
>> > Acked-by: Shawn O. Pearce <spearce@spearce.org>
>> >
>> >> 	I've just accidently read in the completion file itself, that
>> >> 	Shawn is the maintainer, so I give it a third try. The first two
>> >> 	haven't been sent to him.
>> >
>> > Sorry, I must have missed the other two attempts.  :-)
>> 
>> And I seem to have missed all three.
>
> I really don't like to bother you again, but compared to the inclusion
> of the other patches, I guess you have forgotten the third try of this
> patch.
>
> Thus this fourth try :)

I did not mean that I forgot by the above "I seem to have missed".
Literally none of your three attempts seem to have reached me.  I can
guess what you wrote from the _included_ text in Shawn's response, but
that is not a good/right place for me to pick up a patch from, is it?
