From: Anca Emanuel <anca.emanuel@gmail.com>
Subject: Re: Google Gerrit
Date: Tue, 2 Mar 2010 21:22:21 +0200
Message-ID: <c1fb08351003021122wcd390bracd2a61f1355c5d6@mail.gmail.com>
References: <c1fb08351003020610q25b85b60hf9362aabc4b0126f@mail.gmail.com>
	 <4B8D2F17.8040305@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, sop <sop@google.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 02 20:22:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmXfp-0000Cu-0g
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 20:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab0CBTWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 14:22:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:30388 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab0CBTWX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 14:22:23 -0500
Received: by fg-out-1718.google.com with SMTP id 16so279195fgg.1
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 11:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=kkXssLJWLbzPY2UKzaySSKNLIOX1Iy2LMCLkllIFyx0=;
        b=S7/hsEZ4PXgYoDSTdL1N30YN09QRc7Mt3CACPUDhl9GKY/wUVnwp+JEqVEuADZTImD
         z2zMzwd+igHuZqWg6N7/srIPT1vLl1b4GKdZXVzBwe3bZdJDT/Krh94tfZeiHkPUmL6X
         PB0xbNM4nK90Zpqw6flYV3xzJ1vwA3gf9pSHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Bumw2c/eEKqJrWbrZIUnRtoCaaFH3QipUJ8LAcA7pH2NBkQVW6WWd5XzLE+1tZBp6i
         9tp+xi5uFyk5NnpZzX4vnUYdsMluwDbjNuYCORiM8ixwG2HIEWC+e2nusvJmbNoGHgFc
         5j/Xi5JlrKONqdEYn191WhUrXQQ6iemcV76Zc=
Received: by 10.87.69.20 with SMTP id w20mr2976130fgk.78.1267557741741; Tue, 
	02 Mar 2010 11:22:21 -0800 (PST)
In-Reply-To: <4B8D2F17.8040305@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141410>

> Maybe, one of the main Git guys here should look into it - such as the
> one you cc'ed and who's one of the main Gerrit guys also?
>
> Seriously, are you suggesting to use Gerrit for the management of
> git.git (the Git source), or what is this post about? Also, please don't
> crosspost. If you think kernel people should use Gerrit, post there only.
>
> Michael
>

Hi, Michael:

I know the tools are not matured yet, this is just an buzz about.

But in the future, I like to see lkml on wave and remote servers for
testing online and in "real time", etc. It's a dream ?
