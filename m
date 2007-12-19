From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Wed, 19 Dec 2007 08:33:02 +0100
Message-ID: <38C1471E-0927-4B43-AF73-70735820F8F9@wincent.com>
References: <20071217110322.GH14889@albany.tokkee.org> <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr> <7vk5nd53lp.fsf@gitster.siamese.dyndns.org> <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr> <7vfxy04ze7.fsf@gitster.siamese.dyndns.org> <20071218154211.GB12549@alea.gnuu.de> <46a038f90712181541x781c3ebcq6d85b88dbf5cbe23@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 08:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4tQr-0005oT-Ce
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 08:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbXLSHdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 02:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbXLSHdJ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 02:33:09 -0500
Received: from wincent.com ([72.3.236.74]:35078 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbXLSHdI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 02:33:08 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBJ7X4Iq013002;
	Wed, 19 Dec 2007 01:33:05 -0600
In-Reply-To: <46a038f90712181541x781c3ebcq6d85b88dbf5cbe23@mail.gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68859>

El 19/12/2007, a las 0:41, Martin Langhoff escribi=F3:

> On Dec 19, 2007 4:42 AM, J=F6rg Sommer <joerg@alea.gnuu.de> wrote:
>> I vote for stash print the list, because I dropped in the pitfall.
>
> I've dropped there myself, and work with a large team where we are
> both fans of stash, and scarred by it. Any newcomer to git that
> "discovers" stash gets hit by it a dozen times, this is completely
> unnecesary.

I may be missing something here, but what's the danger here? An =20
unexpected stash is incredibly easy to revert, unless I'm missing =20
something. And nobody commented on the idea I posted earlier which =20
seems to address the concerns about newbies not knowing what "git =20
stash" with no params does:

http://marc.info/?l=3Dgit&m=3D119799257404542&w=3D2

Cheers,
Wincent
