From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Thu, 8 Jun 2006 06:29:20 +1200
Message-ID: <46a038f90606071129g2af6e5e2m7a4b979371d9e5db@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149220518.5521.43.camel@neko.keithp.com>
	 <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
	 <20060602041107.GA5429@spearce.org> <1149223164.2443.33.camel@dv>
	 <9e4733910606012144p5f4fda26sdc2de2cc77b71fe7@mail.gmail.com>
	 <df0b33100606070202w581ff581i435056f0fbc197f8@mail.gmail.com>
	 <9e4733910606070830g24a08771i1a332552a95283d1@mail.gmail.com>
	 <e66t2v$6hb$1@sea.gmane.org>
	 <Pine.LNX.4.64.0606070915220.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 20:29:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo2mS-0003gJ-Mx
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 20:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWFGS3V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 14:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWFGS3V
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 14:29:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:47319 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751219AbWFGS3U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 14:29:20 -0400
Received: by wr-out-0506.google.com with SMTP id i20so230729wra
        for <git@vger.kernel.org>; Wed, 07 Jun 2006 11:29:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b9QVgTDK8br0NE8J2ArQyA1XDqeyp3uJcwZKA/YML65pSQnTWYALLGnoBCJlvKuxlz0uHAPLIeWmfB8lsLWEbslzLPlIssU4wz1tV3qnVGqHi67/u1FKIV4q2reV8qDTK+tXlW5ZHFwG1YN1bDTx10ovO5CDOh1rlg3VL3O06dw=
Received: by 10.54.126.1 with SMTP id y1mr893166wrc;
        Wed, 07 Jun 2006 11:29:20 -0700 (PDT)
Received: by 10.54.71.4 with HTTP; Wed, 7 Jun 2006 11:29:20 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606070915220.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21447>

On 6/8/06, Linus Torvalds <torvalds@osdl.org> wrote:
> My guess is that it's the _mozilla_ documentation people that don't
> necessarily have cygwin and perl, because they don't work with the normal
> build.
>
> Ie there are people who can write user documentation, without them having
> any clue - or caring about - build systems.

Which means that git-cvsserver can probably help them -- I don't think
documentation people (and translators, graphic artists, etc) need all
the git smarts. A simplistic TortoiseCVS + git-cvsserver should fit
their usage...

cheers,


martin
