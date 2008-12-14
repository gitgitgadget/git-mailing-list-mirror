From: "Tim Visher" <tim.visher@gmail.com>
Subject: Re: Announce: TortoiseGit 0.1 preview version
Date: Sun, 14 Dec 2008 12:45:49 -0500
Message-ID: <c115fd3c0812140945x79db8b85yb12c6b23c0479552@mail.gmail.com>
References: <1976ea660812130033m2d54cc57tfe134fab0d687d71@mail.gmail.com>
	 <m3d4fuewe0.fsf@localhost.localdomain>
	 <bd6139dc0812140528w4591ee03h9723ba66a967051b@mail.gmail.com>
	 <1976ea660812140548k940a73buf307cd331b775f31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, "Jakub Narebski" <jnareb@gmail.com>,
	git@vger.kernel.org
To: "Li Frank" <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 18:47:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBv3d-00076s-Fy
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 18:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbYLNRpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 12:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbYLNRpv
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 12:45:51 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:56095 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbYLNRpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 12:45:51 -0500
Received: by yx-out-2324.google.com with SMTP id 8so988291yxm.1
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 09:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=U39aV3+FTX4v5H7ITcB5/FKc73WwEi/hlJYrt9aLHbc=;
        b=Je1dWcQ4/szeGJcMZ9mZNsK/cG0xyYBFop8BO9prOZsaVZtGxeyYSl27lxpRszCa5c
         7CHhMqlid2X+TXltuDqjIAfHcXePhM6IhnMrtSB0gwZUyNzXrMcY6yMAMsiNXQD1Ac94
         vwRKZJY4crsIJTqqfmIr86t5UwWtFaR0Acm+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Tgn0/j2Fn1YOORttow/laV5jn8hTJImugbvaqXU/GH4YHLHokXU0z+ZXPmZpc9vW0Z
         48Z+xV6clB4XnIHnpVvc8AK6YbTyuC2qoHv2ktPRGMNtD3GjL44jLnz42HPANwxw2I56
         WrQwuCEwTlTGCuFOTPqOI5kFc4h4iMbZe/IhY=
Received: by 10.100.9.19 with SMTP id 19mr4063798ani.8.1229276749829;
        Sun, 14 Dec 2008 09:45:49 -0800 (PST)
Received: by 10.100.198.2 with HTTP; Sun, 14 Dec 2008 09:45:49 -0800 (PST)
In-Reply-To: <1976ea660812140548k940a73buf307cd331b775f31@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103096>

On Sun, Dec 14, 2008 at 8:48 AM, Li Frank <lznuaa@gmail.com> wrote:

> I think TortoiseGit can make git popular at windows enviroment.
> Window user is waiting for the good UI.  Porting from TortoiseSVN is
> fastest way.

I think you nailed it on the head there, Li.  I had a hell of a time
trying to convince my team to use Subversion over (*gasp*) VSS,
despite the abominable network performance that we were getting with
VSS _and_ all of its obvious flaws (which they freely admitted), until
I finally showed them Tortoise (which I don't personally use) and then
they were all for it.  Something like Tortoise for Git on Windows
would remove a __huge__ barrier to entry for most people that aren't
already comfortable with the command line.  As simple as git is from
the command line, certain people just don't want to bother.

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
