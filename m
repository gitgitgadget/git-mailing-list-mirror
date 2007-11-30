From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] git-stash: Display help message if git-stash is run without sub-commands
Date: Fri, 30 Nov 2007 10:19:09 +0100
Message-ID: <E1F9A2D0-F9BF-4548-8228-33A3F4984FBC@wincent.com>
References: <e66701d40711300016v15700deft3d262d75a9055aca@mail.gmail.com> <20071130084131.GA29668@glandium.org> <e66701d40711300109nc43f3efyb33e591af15a060b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Mike Hommey" <mh@glandium.org>, "Git ML" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nanako Shiraishi" <nanako3@bluebottle.com>
To: "Kevin Leung" <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 10:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy22Q-00054K-LW
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 10:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbXK3JTj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Nov 2007 04:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbXK3JTi
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 04:19:38 -0500
Received: from wincent.com ([72.3.236.74]:50848 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbXK3JTh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2007 04:19:37 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAU9JAUW028703;
	Fri, 30 Nov 2007 03:19:11 -0600
In-Reply-To: <e66701d40711300109nc43f3efyb33e591af15a060b@mail.gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66627>

El 30/11/2007, a las 10:09, Kevin Leung escribi=F3:

> On Nov 30, 2007 4:41 PM, Mike Hommey <mh@glandium.org> wrote:
>> Still, 'git stash' alone should *do* the stash.
>
> How about `git stash' still does the stash, and `git stash llist'
> exits with usage message? And if you want to save the stash with name=
,
> you can only do it with `git stash save name_of_stash'.

That's probably the way it should have been all along.
>


Cheers,
Wincent
