From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 15:34:16 +0100
Message-ID: <D3716EB3-10B1-4D96-AB12-BD86CBB189CB@wincent.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <ee77f5c20801160254u53e07773qb4125ffd90cf7619@mail.gmail.com> <alpine.DEB.1.00.0801161517260.5260@bender.nucleusys.com> <alpine.LSU.1.00.0801161341430.17650@racer.site> <alpine.DEB.1.00.0801161549140.5260@bender.nucleusys.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF9Mp-0000Sf-1Y
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbYAPOfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 09:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753717AbYAPOfR
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 09:35:17 -0500
Received: from wincent.com ([72.3.236.74]:32797 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755190AbYAPOfP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 09:35:15 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0GEYJco021021;
	Wed, 16 Jan 2008 08:34:20 -0600
In-Reply-To: <alpine.DEB.1.00.0801161549140.5260@bender.nucleusys.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70682>

El 16/1/2008, a las 14:58, Petko Manolov escribi=F3:

> On Wed, 16 Jan 2008, Johannes Schindelin wrote:
>
>> I think that you're missing the point of version control.  It's not =
=20
>> only about having an up-to-date source tree, but also about being =20
>> able to go back to a certain revision.
>
> No contradiction here.  In my case old source code will work =20
> perfectly with new binaries/firmware.  That's why i don't _need_ the =
=20
> history, only the latest stuff in order to save space.

You may be interested in the history, but the entire purpose of any =20
version control system (not just Git) is to record exactly that: =20
history.

If the exact contents of these large binaries *really* don't matter, =20
as you say they don't, than why don't you just commit one and never =20
touch it again?

Cheers,
Wincent
