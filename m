From: Russell Steicke <russellsteicke@gmail.com>
Subject: Re: A question about changing remote repo name
Date: Thu, 7 Jan 2010 09:53:19 +0800
Message-ID: <c1b8b6671001061753h12d29511pa07bb080bd6c7834@mail.gmail.com>
References: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com> 
	<c1b8b6671001041852w4740b7d6g4b8db1221c5dc744@mail.gmail.com> 
	<60ce8d251001042030l75c5443gf173f127ad206df3@mail.gmail.com> 
	<c1b8b6671001051607j6b6398d8gf08f7615a38de64e@mail.gmail.com> 
	<alpine.DEB.1.00.1001060123280.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dongas <dongas86@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 07 02:53:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NShZI-00029l-Ba
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 02:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756359Ab0AGBxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 20:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756271Ab0AGBxk
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 20:53:40 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:48756 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868Ab0AGBxj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 20:53:39 -0500
Received: by mail-iw0-f194.google.com with SMTP id 32so2028382iwn.33
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 17:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Pnvu2wZyOxsslnRWm0obmwrvy3zvnGArzfF1ARHEaYs=;
        b=H5ZuJdCY5v0TPSdmYBJWWCA1LwUmno5EdXx03AqL/YwlMrcjw6QFhHzEjbieJdcf2U
         2mTOb1UNP6jy9rTpVgwCq16G0T/vOxSX/3K4GuHrurYsDHeMCtPI4Y3xa1Xvly7OM1zh
         iQyS1gVDdL93kOzaaU0p6Wu59PInMSKr4wct8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xI+g/MJXfFGZsNrBwCRlvFNMKGrqF+UheLAOuZtKqQtIn7OMaMgZNBUHiAj7xztHMi
         pNpLLmvVo5XaQBN6XClVJU/2hoQEq37dDBJaRjxJLBpxkh1tXtT3WFe2TOOI+fzYtv03
         70iqLMLSTzpvwTVDmopCsHd/3TeLq2KRntWfs=
Received: by 10.231.148.3 with SMTP id n3mr1016367ibv.25.1262829219104; Wed, 
	06 Jan 2010 17:53:39 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001060123280.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136313>

On Wed, Jan 6, 2010 at 8:27 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> For everybody reading this thread: DON'T!
>
> Russel, it would be better if you knew about the mechanism before
> making other people believe that it is safe to delete a file that is _not_
> a cache, but _replaces_ the existing refs.

Thank you for explaining that.  I apologise for the misleading information.

I have seen refs in packed-refs as duplicates of those in the refs/
tree.  How would that come about?



-- 
Virus found in this message.
