From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Thu, 3 Jul 2008 08:26:59 +0200
Message-ID: <200807030827.00086.chriscool@tuxfamily.org>
References: <200612241807.kBOI746w008739@laptop13.inf.utfsm.cl> <Pine.LNX.4.64.0712310349260.2093@fbirervta.pbzchgretzou.qr> <486849C0.7050703@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Engelhardt <jengelh@computergmbh.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:26:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK8E-0002yW-Tk
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbYGCHAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 03:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbYGCG6Z
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:25 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:43120 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266AbYGCGXE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 02:23:04 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 459021AB2B2;
	Thu,  3 Jul 2008 08:23:03 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 20BE01AB2AA;
	Thu,  3 Jul 2008 08:23:02 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <486849C0.7050703@garzik.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87256>

Hi,

Le lundi 30 juin 2008, Jeff Garzik a =E9crit :
> Jan Engelhardt wrote:
> > On Dec 23 2007 06:13, Jeff Garzik wrote:
> >> Another year, another update!  :)
> >>
> >> The kernel hacker's guide to git has received some updates:
> >>
> >> 	http://linux.yyz.us/git-howto.html

May I suggest adding some stuff about "git bisect", or at least links t=
o=20
other documentation about it, in this guide?

Especially, you may want to add an example about how to automate testin=
g=20
using "git bisect run" as you suggest other to do that:

http://www.ussg.iu.edu/hypermail/linux/kernel/0804.1/0633.html

Thanks in advance,
Christian.
