From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT: stgitformatversion vs. stgit.formatversion
Date: Thu, 7 Jun 2007 22:55:09 +0100
Message-ID: <b0943d9e0706071455n2136c75fm76571583c279d23b@mail.gmail.com>
References: <20070602191641.GB6992@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070603121718.GA6507@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Yann Dirson" <ydirson@altern.org>,
	"GIT list" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 23:55:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwPxN-0006bk-Gi
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 23:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936915AbXFGVzO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 7 Jun 2007 17:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937340AbXFGVzN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 17:55:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:54090 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936897AbXFGVzL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2007 17:55:11 -0400
Received: by ug-out-1314.google.com with SMTP id j3so787162ugf
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 14:55:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g9REl6/xu5iQV6Q4Z9KlJ6WxZfvsLv2Oj6Q/f0t665QGjYDRRRgmY0XcTo/9KdNGTy3Oj/8bUwZwhTUDPT1oibdo7WDkEeiJdEjZoyNy8dY0rAtOxu7OwJCvcSzRirJJOezDkzC123+LMj7AgBotfHA1mvns4MwPfgxyAX1look=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LWS1++LLNCb5GRtorfhNJkwWSiCNk9jT5D5fl9vG0kuEsUifO7TAHahCZNtutVT1xexkbz24HnVNVGGs9oQ2oN/4NXUSEKJVSjcpMjI/33ZdJ+tzqVR8OSFXXhT9WwViUuj+8nJAYLmdy/tz9MI7nxCpCthgyLMQTcCtOVeM2ZA=
Received: by 10.67.92.1 with SMTP id u1mr2316320ugl.1181253309903;
        Thu, 07 Jun 2007 14:55:09 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Thu, 7 Jun 2007 14:55:09 -0700 (PDT)
In-Reply-To: <20070603121718.GA6507@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49392>

On 03/06/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> It happens a bit too often that we find problems with patches only
> after Catalin has published them on "master". (At least that seems to
> be the case with patches coming from me!) Maybe a "pu" branch
> (maintained either by Catalin or someone else) would be a good way to
> smoke them out before they're written in stone and distributed to lot=
s
> of people.

BTW, if any of you is willing to maintain such a branch, I'll happily
pull from it when it gets stable.

--=20
Catalin
