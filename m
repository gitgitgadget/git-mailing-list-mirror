From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: git send-email prompting too much
Date: Sat, 04 Apr 2009 18:12:07 +0100
Message-ID: <80hc148hso.fsf@tiny.isode.net>
References: <449c10960904041002s22124b74k8440af216b1de9ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 19:20:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq9Xb-0003vt-UX
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 19:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbZDDRSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 13:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbZDDRSO
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 13:18:14 -0400
Received: from rufus.isode.com ([62.3.217.251]:56191 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbZDDRSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 13:18:13 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Apr 2009 13:18:13 EDT
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SdeU5wAs9BIU@rufus.isode.com>; Sat, 4 Apr 2009 18:12:07 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Sat, 04 Apr 2009 18:12:07 +0100
X-Hashcash: 1:20:090404:dpmcgee@gmail.com::ZjWThr6nTpHYQq2N:000000000000000000000000000000000000000000002G4u
X-Hashcash: 1:20:090404:git@vger.kernel.org::mQFwrIX+8y/Ek7QI:0000000000000000000000000000000000000000001FbH
In-Reply-To: <449c10960904041002s22124b74k8440af216b1de9ee@mail.gmail.com> (Dan McGee's message of "Sat\, 4 Apr 2009 12\:02\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115589>

Dan McGee <dpmcgee@gmail.com> writes:

> I'm guessing this is related to commit
> 6e1825186bd052fc1f77b7c8c9a31fbb9a67d90c but I haven't bisected yet.
> Having to hit enter 10 times ad the Message-ID prompt seemed a bit odd
> to me. Has anyone else seen this behavior?

Yes.  Apparently one uses \C-d now.

[...]
