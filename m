From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and 
	Mercurial
Date: Sun, 26 Apr 2009 08:53:54 +0030
Message-ID: <4d8e3fd30904260123r35b6a348uab3ad22fde9daa3f@mail.gmail.com>
References: <200904260703.31243.chriscool@tuxfamily.org>
	 <m363grq13i.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 03:23:36 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxzgS-0008KO-Jj
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 10:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073AbZDZIX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 04:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbZDZIX5
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 04:23:57 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:52478 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbZDZIXz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 04:23:55 -0400
Received: by fxm2 with SMTP id 2so1767763fxm.37
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hcuVnz0ubXreHkUwMfscLZ5hG+tSrK0/2KFtO5BYCts=;
        b=wTwdZYUv9rSdhXYhGBm7sw10a8QGUtiYOI3G/IZlaLovLy+wMmNu+1KQnnY2drcu/r
         bllYpGAvMt3XD0UR29YzJSy5tPJtVxsD3UdjKMXvL7EO/njSvyBaqjNGx08MgvPD4Hhl
         CYbMFEexCVmya1Wvcq6n7xEOBZfB1qsNdqfeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B4aBdFXsGWaFM10eH9rLavxW9iNo3+/m2EFNfrIqmk4uqIeHKwMLh/XAm6dCMOYikA
         M7Y9f53uY14utZPIrQPQ5u9e7RM2nvDaokP4tnrxILYWIjzSVBOYJy+hZNfSSUMi9asM
         N58+yYwOI3ny5XtbOvWUDwTWLSyWJOhw+ekSY=
Received: by 10.86.86.10 with SMTP id j10mr2212461fgb.37.1240734234857; Sun, 
	26 Apr 2009 01:23:54 -0700 (PDT)
In-Reply-To: <m363grq13i.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117594>

On 4/26/09, Jakub Narebski <jnareb@gmail.com> wrote:

> The deciding feature (well, one of deciding features) was the fact
> that Mercurial has better HTTP support... I guess (it was not obvious
> from the analysis, but it was hinted at) that Mercurial uses its
> custom protocol over HTTP, as opposed to "dumb" HTTP protocol support
> in Git.
>
> Perhaps it is time to restart work on _"smart" HTTP protocol_?
>


wasn't Shawn working on it?

ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://mypage.vodafone.it/
