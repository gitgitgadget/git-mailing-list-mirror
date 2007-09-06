From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Git's database structure
Date: Thu, 6 Sep 2007 13:03:16 +0200
Message-ID: <541BD0C7-3D71-4C60-A501-7055283635F2@wincent.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com> <7vtzqany0z.fsf@gitster.siamese.dyndns.org> <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com> <20070904212507.GA24434@thunk.org> <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com> <46DE5861.4050201@op5.se> <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com> <46DEC26E.7030809@op5.se> <9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com> <Pine.LNX.4.64.0709051648400.3189@reaper.quantumfyre.co.uk> <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com> <46DFBF13.9040109@op5.se> <7vsl5sb1nd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, Jon Smirl <jonsmirl@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 13:04:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITFA1-0003sJ-N8
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 13:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbXIFLE3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 07:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbXIFLE3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 07:04:29 -0400
Received: from wincent.com ([72.3.236.74]:45919 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814AbXIFLE2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 07:04:28 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l86B3JZA001538;
	Thu, 6 Sep 2007 06:03:20 -0500
In-Reply-To: <7vsl5sb1nd.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57861>

El 6/9/2007, a las 11:09, Junio C Hamano escribi=F3:

> Andreas Ericsson <ae@op5.se> writes:
>
>> Estimated daily uses of git-blame, world-wide: few
>> Estimated daily uses of git-{merge,diff}, worldwide: lots
>
> Which makes the author of git-blame weep X-<.

But the few times when you do use git-blame (apart from when you use =20
it out of sheer curiosity) it usually saves you backside (ie. when =20
you've located a problem in the code and you want to know the who/=20
what/when/why of the offending commit).

Cheers,
Wincent
