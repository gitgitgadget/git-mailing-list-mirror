From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [RFC/PATCH 7/7] Documentation formatting and cleanup
Date: Wed, 2 Jul 2008 21:09:24 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807022053090.10323@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <Pine.GSO.4.62.0806301730230.7190@harper.uchicago.edu> <486A2C8C.5050204@free.fr>
 <7vej6dmgps.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Olivier Marin <dkr+ml.git@free.fr>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Jon Loeliger <jdl@jdl.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7d-0002yW-Ls
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbYGCG7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbYGCG5c
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:32 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:54159 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbYGCCJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 22:09:57 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6329PAk009923;
	Wed, 2 Jul 2008 21:09:25 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6329OHU012067;
	Wed, 2 Jul 2008 21:09:24 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <7vej6dmgps.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87242>

Junio C Hamano writes:

> Olivier Marin <dkr+ml.git@free.fr> writes:
>
>> Also, in Documentation/gitdiffcore.txt, you did:
>>
>>> -These are applied in sequence.  The set of filepairs git-diff-\*
>>> +These are applied in sequence.  The set of filepairs `git-diff-*`
>>
>> but the file does not compile, now.
> 
> There are other places with the same breakage.

Sorry about that. Thanks for the fix.

Do you know of a good page to read to learn that subset of Asciidoc 7
we use?  Right now, I am wondering: why wouldn't `git-diff-\*` work?

Jonathan
