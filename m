From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: LCA06 Cogito/GIT workshop - (Re: git-whatchanged: exit out early on errors)
Date: Thu, 26 Jan 2006 15:10:54 +1300
Message-ID: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 26 03:11:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1wbM-0001R7-Ph
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 03:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWAZCK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 21:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWAZCKz
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 21:10:55 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:50214 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751286AbWAZCKz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 21:10:55 -0500
Received: by wproxy.gmail.com with SMTP id 57so237049wri
        for <git@vger.kernel.org>; Wed, 25 Jan 2006 18:10:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XJKNAeVGXt0wZl7Q9d1TrdgW8V4FVqNrqVPlgjg3w+6j1xCrYIGOdXLPuzHpRZiFpxcFlAjIr06JmnrlkAZmETT04K0smlnWQy4ehiD0gPnoYO1kN2Rv7e+Ri5ye8Wum7VbCgNo+zdU4g5wVUKaOxmif7hSom6ppQ0U98Fx502s=
Received: by 10.54.127.3 with SMTP id z3mr1819788wrc;
        Wed, 25 Jan 2006 18:10:54 -0800 (PST)
Received: by 10.54.127.8 with HTTP; Wed, 25 Jan 2006 18:10:54 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15148>

On 1/26/06, Linus Torvalds <torvalds@osdl.org> wrote:

> If we get an error parsing the arguments, exit.

This bug found thanks to the 'demo' effect. ;-)

The workshop had a 2hr slot -- after 2hs 15, I asked Linus if he
wanted to talk about the internals. He did, and the workshop went
on... for 2 hours more. It was actually hard to get people out of the
room.

Sadly, not many people actually played along on their laptop. Those
who did got an extra bit of help to migrate their preexisting CVS/SVN
repos ;-) (thanks to Sam Vilain for all the help!)

I'll upload the presentation material soon -- very similar to the
stuff I used @ Wellington Perl Mongers. Still text-based; given all
the talk about plumbing and porcelain, I steadfastly refuse to add
imagery.

During the presentation someone mentioned errors when running
git-cvsimport which I'm keen on hearing more about.

cheers,


m
