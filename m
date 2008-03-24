From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: A script that keeps track of your favorite Git/SVN projects?
Date: Mon, 24 Mar 2008 00:47:21 -0400
Message-ID: <32541b130803232147n5fa6ccd3j712aec413a372353@mail.gmail.com>
References: <fbede933c733.47e73470@broadpark.no>
	 <alpine.DEB.1.10.0803232051320.6107@dell.linuxdev.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Kyrre_Nyg=E5rd?=" <kyrreny@broadpark.no>,
	git@vger.kernel.org
To: "Asheesh Laroia" <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 05:48:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdebO-0002kL-5Z
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 05:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbYCXErX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 00:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbYCXErX
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 00:47:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:49002 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbYCXErX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 00:47:23 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2782852fgb.17
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 21:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zyzLvssD8tbhlYT0ErcZKuZD34WrL8uBfP/71Qlk40s=;
        b=PYtVuboBM4zzwuuyTB11/yleo3MzqNWn/TEzYKwlmu4wbKwh7o4UR5bDrHnFrrjLXMzauBNESTPjXebSInTay/Tm/eO/V4VgRvrP1z+2mT8ZLl1Kb5bDf/FlJ2u3/FfgOEf2D5klRf2JirfXgOGf6j4rqxjVKh+cCmDUY6AEdJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UrWKvZq9CF5f3+m+qulCsrXxd8z45NMPVAgSyxAkmmJHmdI8DaKg3ZVjMu8rllmZZ7BXyAuJzIS4r6CzmY1odMsTjTirIW9exaccq87yJbOcYRtDW86BwBXM+CJszmDELw+BgutaeJLCla3+sVlnkSQaV6fO3OX+JlUvEcySwQI=
Received: by 10.82.170.2 with SMTP id s2mr16181073bue.30.1206334041259;
        Sun, 23 Mar 2008 21:47:21 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Sun, 23 Mar 2008 21:47:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0803232051320.6107@dell.linuxdev.us.dell.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78002>

On Mon, Mar 24, 2008 at 12:04 AM, Asheesh Laroia <asheesh@asheesh.org> =
wrote:
> On Mon, 24 Mar 2008, "Kyrre Nyg=E5rd" wrote:
>
>  > Hi there, Hasanybody ever written a script that keeps track of you=
r
>  > favorite Git(and SVN) projects? E.g. sends you an e-mail every tim=
e a
>  > revision hasbeen made, with details like the summary, time and dat=
e,
>  > author andcode differences.
>
>  I don't know of a "subscribe to a source repository" program myself,
>  actually.

Why not subscribe to the gitweb of each one via your RSS reader?

Avery
