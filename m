From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Inconsistencies with git log
Date: Thu, 8 Nov 2007 10:19:21 +0100
Message-ID: <ABA55D82-3CB3-4AAA-9C0A-7A7B0C4F91AE@wincent.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> <Pine.LNX.4.64.0711072242230.4362@racer.site> <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> <Pine.LNX.4.64.0711072255420.4362@racer.site> <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3YG-0007gd-FR
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605AbXKHJTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 04:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757285AbXKHJTd
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:19:33 -0500
Received: from wincent.com ([72.3.236.74]:51966 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757187AbXKHJTc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 04:19:32 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lA89JOVk028896;
	Thu, 8 Nov 2007 03:19:25 -0600
In-Reply-To: <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63974>

El 8/11/2007, a las 0:03, Jon Smirl escribi=F3:

> On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>
>>
>> We also tend to take the approach of viewing the history as that of
>> the whole project.
>
> But if you type 'git log' while cd'd into a subdirectory the whole lo=
g
> is almost never what you want. It's this kind of thing that makes git
> harder to use.

At least in my case, that's completely untrue. Whole-project history =20
is basically *always* what I want even if I am cd'd into a =20
subdirectory. If I wanted to path-limit the project history I'd do =20
"git log ."

Cheers,
Wincent
