From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Wed, 19 Dec 2007 13:07:49 +0100
Message-ID: <0FC1BEA1-3A1E-4316-BF1D-40522E355553@wincent.com>
References: <20071217110322.GH14889@albany.tokkee.org>  <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>  <7vk5nd53lp.fsf@gitster.siamese.dyndns.org>  <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr> <7vfxy04ze7.fsf@gitster.siamese.dyndns.org>  <20071218154211.GB12549@alea.gnuu.de> <46a038f90712181541x781c3ebcq6d85b88dbf5cbe23@mail.gmail.com>  <38C1471E-0927-4B43-AF73-70735820F8F9@wincent.com> <46a038f90712182346t5309448egebfd3726f4d493c5@mail.gmail.com> <Pine.LNX.4.64.0712191150240.23902@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 13:08:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xij-0003yE-TV
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 13:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbXLSMHz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 07:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbXLSMHz
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 07:07:55 -0500
Received: from wincent.com ([72.3.236.74]:35587 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbXLSMHy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 07:07:54 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBJC7o8R019560;
	Wed, 19 Dec 2007 06:07:51 -0600
In-Reply-To: <Pine.LNX.4.64.0712191150240.23902@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68898>

El 19/12/2007, a las 13:01, Johannes Schindelin escribi=F3:

> But stash really is about things like
>
> 	$ git stash
> 	$ git pull
> 	$ git stash apply
>
> I do not _want_ to see the stash list in _most_ cases, because I do =20
> not
> stash away million dirty changes.
>
> And that workflow was what "git stash" was designed for.

+1.

Wincent
