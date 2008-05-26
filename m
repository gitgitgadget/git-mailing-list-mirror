From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rev-parse doesn't take pwd into consideration
Date: Mon, 26 May 2008 14:48:39 -0700
Message-ID: <7vprr84tzc.fsf@gitster.siamese.dyndns.org>
References: <7vhcckddov.fsf@gitster.siamese.dyndns.org>
 <20080526195812.GA23396@bit.office.eurotux.com>
 <200805262135.m4QLZtpq023003@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Luciano Rocha <luciano@eurotux.com>, git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Mon May 26 23:49:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0kZj-0004e3-JM
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 23:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbYEZVtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 17:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754753AbYEZVtA
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 17:49:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648AbYEZVs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 17:48:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6941A39B9;
	Mon, 26 May 2008 17:48:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AB7AF39B8; Mon, 26 May 2008 17:48:51 -0400 (EDT)
In-Reply-To: <200805262135.m4QLZtpq023003@mi0.bluebottle.com>
 (nanako3@bluebottle.com's message of "Tue, 27 May 2008 06:35:10 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A636170-2B6D-11DD-999F-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82964>

しらいしななこ  <nanako3@bluebottle.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com> writes:
>
>> This was discussed to death.  Check the list archive.
>
> Junio, sometimes I think you are being very mean.  I am reasonably sure you meant this one, but why didn't you give a pointer for him?

Well, because my response roughly translates to "Your lack of research
before posting would have wasted other's time, don't do it", I _could_
have spent some time researching before posting to keep Luciano from
spending his time on going back to the list archive.  Setting a good
example, so to speak.

In that sense, perhaps you may have a point.

But I do not think I (or we collectively as the project) can afford to
keep doing that in the longer term.  A minute lost for me is a minute lost
for the project to review and integrate changes that others spent dozens
of minutes, perhaps hours, to come up with.  So I should not be constantly
doing the archive research for other people.

My response might have been mean, and I instead could have ignored it and
allow the thread to waste time of others responding to it, but that would
have been a worse alternative than nipping it off in the bud.  I am not
sure what better alternatives there were, other than having a dedicated
secretary/librarian to do the archive research for the community.

> http://thread.gmane.org/gmane.comp.version-control.git/68786/focus=68852

Yeah, that's the one I had in mind.  I like quoting the threaded interface
from gmane --- it makes the context of old discussion very clear.

Thanks.
