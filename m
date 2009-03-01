From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Yesss! sourceforge.net and Git
Date: Sun, 1 Mar 2009 23:02:20 +0100
Message-ID: <fabb9a1e0903011402y3d2878b1h7e29f720dbfe1c82@mail.gmail.com>
References: <alpine.DEB.1.00.0903012237360.10279@pacific.mpi-cbg.de>
	 <fabb9a1e0903011344r2a094283ge95e29d674858213@mail.gmail.com>
	 <alpine.DEB.1.00.0903012259390.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 01 23:04:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdtlI-00071g-9C
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 23:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853AbZCAWCY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 17:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755487AbZCAWCY
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 17:02:24 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:47828 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777AbZCAWCX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 17:02:23 -0500
Received: by fxm24 with SMTP id 24so1757292fxm.37
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 14:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wg2PYw02/Px4dJAZqkgIhzgqzUdhA0vdIQoasGQRE8A=;
        b=vieR4a7U7pamstRh3L4xfTJPRniHTDwmyVzGhbLV69ECux0By9xB4MJPKsay+EREgK
         O0+rEFkwUDY5pTPKzZvnWptoNA3ahGvIlTDajomhjtW+tYTbDW90NzF+5VZC03lWEQs4
         qiZUMMDzMnJdQ+fY7Hq+uH0KO0zw2e8kDjjBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OkETIENETfrtCW6ndFnhRyvoSEexb7vCJB944YZWr6ZnPccZyEqk7fbrwNsymLwPvs
         iFquCEEn2xkVAE0A0yHffyYOSY0gr6+ZXm3eX9z0+uL/RD3mzF67gHDYSy93Tm8PNVgd
         EBL0jmtAObN4XHWZXqPhCrexAH0D3dpJWYJZY=
Received: by 10.103.117.9 with SMTP id u9mr2585373mum.55.1235944940795; Sun, 
	01 Mar 2009 14:02:20 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0903012259390.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111886>

Heya,


On Sun, Mar 1, 2009 at 23:01, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 1 Mar 2009, Sverre Rabbelier wrote:
>> On Sun, Mar 1, 2009 at 22:38, Johannes Schindelin wrote:
>> > =A0 =A0 =A0 =A0http://apps.sourceforge.net/trac/sitedocs/wiki/Git

It seems there's a bunch of sillyness in there, such as them
recommending backup over rsync?! They should be telling people to just
make a clone, and in the case of a crash they can push the clone back
up!
Also, maybe we can tell them git learned how to clone empty repo's rece=
ntly?

>> About time! Totally awesome though.
>> Now, code.google.com and others have no excuse anymore, right? ;)
>
> Except that it is run by Subversion people, and therefore it by like
> asking git.or.cz to serve Mercurial repositories ;-)

Heh, speaking of Hg, I heard they're adding DVCS support to
code.google.com soon, if they're already adding a non-svn VCS, why not
git? :D

--=20
Cheers,

Sverre Rabbelier
