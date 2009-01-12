From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-patches list?
Date: Mon, 12 Jan 2009 15:54:22 -0800
Message-ID: <7vr638f5ch.fsf@gitster.siamese.dyndns.org>
References: <90bb445a0901121543q29d30d49yaa723b4b913a4b31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Akira Kitada <akitada@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 00:55:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMWdN-0001YJ-RE
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 00:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbZALXy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 18:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754627AbZALXy2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 18:54:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbZALXy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 18:54:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4F6CC1C594;
	Mon, 12 Jan 2009 18:54:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 25E241C598; Mon,
 12 Jan 2009 18:54:23 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5892F636-E104-11DD-B00F-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105418>

Akira Kitada <akitada@gmail.com> writes:

> Can I propose having another mailing list for posting patches to avoid
> daily mail flood to this list?
>
> Yes, I can filter out the emails but still...

This list has always been the only place where git development happens.
It would make the development very awkward to set up another list only for
patches, forbid patches to be sent to anywhere but that new list, but
still discuss the patches on this list.

It does not make much sense to me.

Consider what you would do when you see a problem somebody is having on
this list, and wanted to respond with a quick "this may fix it" patch?
Should you be sending that to the patches list, and sending a separate
message to this list saying that you have a potential fix in mind you
would want to discuss here, but the patches list rule mandated that you
had to send the patch to the other list, asking people who are reading
this list to look at the other list as well?

And no, having a separate "user list" won't solve the above problem either
and that is not what I am suggesting.

Not that I am seeing any problem right now; I am saying that the split
list as you suggest _will_ create problems.
