From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add hints to revert documentation about other ways to
 undo changes
Date: Wed, 20 Aug 2008 16:52:49 -0700
Message-ID: <7vvdxvmege.fsf@gitster.siamese.dyndns.org>
References: <7vk5ec7s05.fsf@gitster.siamese.dyndns.org>
 <1219175431-20730-1-git-send-email-tarmigan+git@gmail.com>
 <7vzln7mglj.fsf@gitster.siamese.dyndns.org>
 <905315640808201636of09ccb3wb31b71cd090b451@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Daniel Barkalow" <barkalow@iabervon.org>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 01:54:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVxVC-00082e-2N
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 01:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118AbYHTXxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 19:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755951AbYHTXxE
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 19:53:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756082AbYHTXxD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 19:53:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 77D9C5275B;
	Wed, 20 Aug 2008 19:53:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B6FA752759; Wed, 20 Aug 2008 19:52:55 -0400 (EDT)
In-Reply-To: <905315640808201636of09ccb3wb31b71cd090b451@mail.gmail.com>
 (tarmigan+git@gmail.com's message of "Wed, 20 Aug 2008 16:36:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1EEB3780-6F13-11DD-A6F0-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93074>

Tarmigan <tarmigan+git@gmail.com> writes:

> On Wed, Aug 20, 2008 at 4:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ..
>> Did you hand edit the diff?
>>
> ...  I did use emacs
> though, which, when I tried to recreate it right now, seems to change
> the 6 to a 7 when I touch any of the changed lines.

Ok, I was not complaining, just being curious.

Recounting by Emacs's diff mode is sort of broken (it is not quite broken,
but it could do better).  My primary interest in the question was to to
see if you are using some other broken diff editing environment.
