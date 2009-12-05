From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gui criticism
Date: Sat, 05 Dec 2009 12:14:54 -0800
Message-ID: <7v3a3prxdt.fsf@alter.siamese.dyndns.org>
References: <loom.20091205T194800-496@post.gmane.org>
 <94a0d4530912051137u682a3a99ved9d19338b881b13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ram Rachum <cool-rr@cool-rr.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 21:15:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH12J-0006lM-23
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 21:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbZLEUPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 15:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbZLEUPD
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 15:15:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbZLEUPB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 15:15:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 83997A40CD;
	Sat,  5 Dec 2009 15:15:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZHFA21PdXQu7/pPzeL/0pV3tWZM=; b=UMmIKA
	iWcJn2kCyH/+Oj58tbwry5vfCdXPZMV/BmCUL2eqOqvencjO4ybyDwevJldBflud
	ACKjXsuyQnLP+X82uZVuxRVPvQ/nI9wkoPJ+/a9l4gbpN4w6GCIKEVf+DZZmzzoN
	Grgx+0axjJFGLpDkxQbNFSjHLzuE9We1ADtu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HWUGo2krHIABfNWJALPC8mP419DNnWJv
	zCp4YpgATZUiwlfv3e7aAV3Hn1aCEgvY+xWL/QuXy7ITTw/4fLcHNQLP+FJ/0A4n
	k5Cc9YzkcpvYagx2u38D1YzdF3uQhIBTqaFYcAdY5CkMiaw7+yBY+hfsz7hpAv84
	AdtvBXj8YJg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53CB8A40CC;
	Sat,  5 Dec 2009 15:15:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A384DA40C9; Sat,  5 Dec 2009
 15:14:56 -0500 (EST)
In-Reply-To: <94a0d4530912051137u682a3a99ved9d19338b881b13@mail.gmail.com>
 (Felipe Contreras's message of "Sat\, 5 Dec 2009 21\:37\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE194206-E1DA-11DE-8F43-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134619>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I don't think the mailing list is the best place for this, that's why
> I just started a project in SourceForge, so that users can post these
> kinds of issues in the ideatorrent:
> https://sourceforge.net/apps/ideatorrent/git-ux/ideatorrent/

Two issues and a half offhand after entering one:

 - I found the experience of adding an "idea" too clunky and slow.
   Writing a well thought out e-mail can be done in the same time.

 - Although enforcing a minimum structure of "idea" description is a good
   thing to do, I found the current structure presented by that web page
   lacks focus.  It has problem description and a rather broad and vague
   "idea", and it feels to me that it is promoting entering any garbage
   without discussing feasibility, "pros-and-cons" or necessary steps to
   achieve a particular goal.

 - The largest issue of this kind of system is who will be moderating and
   how capable they are.
