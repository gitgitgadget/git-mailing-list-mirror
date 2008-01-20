From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Time to flush developer accumulated patches?
Date: Sun, 20 Jan 2008 11:18:23 +0100
Message-ID: <0B23B7DB-8AB2-4D8D-BE50-917651238353@wincent.com>
References: <e5bfff550801200210y212d0921x214773596810be52@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 11:19:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGXGi-0004fT-Dl
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 11:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbYATKSl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 05:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbYATKSl
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 05:18:41 -0500
Received: from wincent.com ([72.3.236.74]:43602 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666AbYATKSk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 05:18:40 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0KAIPJD006623;
	Sun, 20 Jan 2008 04:18:26 -0600
In-Reply-To: <e5bfff550801200210y212d0921x214773596810be52@mail.gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71169>

El 20/1/2008, a las 11:10, Marco Costalba escribi=F3:

> Reading mailing list threads it is becoming common these days to hear
> about contributors with patches ready to be sent as soon as 1.5.4 is
> out.
>
> Would be a good idea to open a new branch new_stuff as a target for
> this pending stuff?
>
> I understand that you want people focused on fixing bugs, but I also
> understand that people don't ;-)
>
> Opening a new_stuff branch could have the following benefits:
>
> - Give more time to fix bugs before 1.5.4 is out without stopping
> people from having fun and reduce the pressure to release.
>
> - Reduce the merging impact when master reopens because patches are
> already merged in new_stuff and developers have already taken care of
> conflicts
>
> - Do not slow down the wheel: I can develop some patches and keep the=
m
> myself, but until are not discussed in the list and eventually got in
> master has little meaning to continue develop additional stuff.
>
> - Perhaps it's lack of reviewing time on your side that worries you
> (as is normal because we are on bug fixes mode in master) but upgrade
> from new_stuff to master would be not automatic nor guaranteed but at
> least people have an idea at what's going on and can keep contributin=
g
> in code and ideas.

We already have two such branches: next and pu.

Here's an old version of a mail from Junio describing the different =20
branches; I know he's sent out newer ones but this it he one that I =20
could lay my hands on:

http://article.gmane.org/gmane.comp.version-control.git/39954

Cheers,
Wincent
