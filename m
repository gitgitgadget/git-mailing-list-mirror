From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-scm.com
Date: Sat, 26 Jul 2008 16:11:02 -0700
Message-ID: <7vbq0kckc9.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
 <6b6419750807251838h12ea4f19gdff107694e3797c4@mail.gmail.com>
 <d411cc4a0807251928g75744b78vac2ce77bf07fbd81@mail.gmail.com>
 <20080726023707.GX32184@machine.or.cz>
 <alpine.DEB.1.10.0807251943280.11335@asgard.lang.hm>
 <d411cc4a0807252230v76670d3cp2205e40826acc6e2@mail.gmail.com>
 <F3D70DCD-E9A9-42C3-8870-ABB7EECF83CC@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Scott Chacon" <schacon@gmail.com>, david@lang.hm,
	"Petr Baudis" <pasky@suse.cz>,
	"Patrick Aljord" <patcito@gmail.com>,
	"git list" <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 01:12:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMsw1-0006iq-3y
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 01:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbYGZXLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 19:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbYGZXLO
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 19:11:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34700 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbYGZXLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 19:11:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E34C3D840;
	Sat, 26 Jul 2008 19:11:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C35DE3D83F; Sat, 26 Jul 2008 19:11:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2373757E-5B68-11DD-BDB1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90291>

Wincent Colaiuta <win@wincent.com> writes:

> I'd like to see the "official" Git homepage as distanced as possible  
> from GitHub. They've taken Git (free as in speech, free as in beer)  
> and built a closed-source commercial product on top of it -- curiously  
> for something which you can do for free yourself anyway ...

I do not share that sentiment.  It is perfectly fine for somebody to offer
managed git repositories as a commercial _service_ to people who want to
just _use_ git.  It is what they could do themselves, but from the end
user's point of view, it's just "outsourcing" and is nothing unusual.

If GitHub folks improved the core part of the system while building their
service, we would want to get the changes back, and we will, _if_ they
distribute their software (i.e. they are not allowed to just distribute
binaries, if it links with git).

At the emotional level, if some people make the world a better place by
building new software around what I wrote, I would like to have the same
kind of access to its source as I gave them access to my sources, whether
they distribute the end product as packaged software or they offer it as a
service to be used by others without ever distributing anything.  But that
is merely my _wish_; it is different from the terms git is distributed
under.

I think you are going a bit too far to hate them for not opening up their
sources they use to implement "managed git repositories service", which is
a _user_ of the core git, but most likely is not a derivative of git
itself.  IOW, it's not your code.
