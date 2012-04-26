From: "David E. Wheeler" <david@justatheory.com>
Subject: Re: Bad Man Page URLs
Date: Thu, 26 Apr 2012 15:11:52 -0700
Message-ID: <BEA084BA-739D-4D73-80C0-FE2FC1598D9F@justatheory.com>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
 <20120406023223.GB16264@sigill.intra.peff.net>
 <20120406025457.GA23997@sigill.intra.peff.net>
 <20120406042215.GA3938@burratino>
 <20120406054637.GA25301@sigill.intra.peff.net>
 <7vzkap1gck.fsf@alter.siamese.dyndns.org>
 <BCD7B631-8C73-4F3F-AB37-9B5CF02655D5@justatheory.com>
 <20120426201921.GA15026@burratino>
 <20120426210251.GA31589@sigill.intra.peff.net>
 <CAP2yMa+mjvFmVwXjrB7FRaD2=iMCCPENWAOoCG5TCsqFdsCDxQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNWuv-0008Sj-94
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab2DZWL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:11:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077Ab2DZWLz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 18:11:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD35D6536;
	Thu, 26 Apr 2012 18:11:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject
	:mime-version:content-type:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=sasl; bh=
	qW/eG9oRuvQji6Zjt7C+QhWhaQc=; b=slPT4O9jD6GpNS931WTbO6R+KzVA+4ah
	1UspE4KKrIl1dUAbjBM/KO5v5em2XSxMu7gNogjg3r+s8bSma1msH1sXmWGptifW
	dOUEw0QgN7hqYbZaxS924946wywPV0YL4aL5YRNz2b2bwsDCL02l8R4ASL0MA0Pk
	C/8aoISN7zA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3F256535;
	Thu, 26 Apr 2012 18:11:54 -0400 (EDT)
Received: from hydrogen.iovation.com (unknown [74.121.28.6]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DBE36534; Thu, 26 Apr 2012
 18:11:53 -0400 (EDT)
In-Reply-To: <CAP2yMa+mjvFmVwXjrB7FRaD2=iMCCPENWAOoCG5TCsqFdsCDxQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1257)
X-Pobox-Relay-ID: D4E50A86-8FEC-11E1-B00A-FC762E706CDE-76319746!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196419>

On Apr 26, 2012, at 2:58 PM, Scott Chacon wrote:

> Yes, we are very close to launching a big redesign of git-scm.com.
> The manpages will be automatically updated on that site, you can
> certainly link to them there.
> 
> If you want to preview what it's going to look like and the URL
> structure, you can check out the current working version here:
> 
> http://git-scm.herokuapp.com/docs/git-fetch

Wow, the new site looks *awesome*! :-)

> There are a number of known bugs and I want to make it much faster
> before I officially launch it and redirect DNS, but you can get an
> idea of how it will be structured and what it will look like.  If you
> want to start generating docs with static urls for man pages, they can
> be of the form: http://git-scm.com/docs/git-command
> 
> You can also put a version number after them to permalink them at a
> certain version:
> 
> http://git-scm.herokuapp.com/docs/git-fetch/1.7.3.2

Very nice. I only found one of the links from the manpage there, though:

  Everyday Git
  http://git-scm.herokuapp.com/docs/everyday.html

Here are the others on gitmanual.org (maybe I just couldn't find them on the new site?):

  User Manual
  http://www.gitmanual.org/user-manual.html

  git concepts chapter of the user-manual
  http://www.gitmanual.org/user-manual.html#git-concepts

  howto
  http://www.gitmanual.org/howto-index.html

And this one is a broken link on gitmanual.org and other places on the internetz.

  GIT API documentation
  ????

Best,

David
