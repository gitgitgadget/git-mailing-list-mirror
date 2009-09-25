From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 21:04:15 +0100
Message-ID: <e5bfff550909251304g53202e1fna50afabf93722ce5@mail.gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
	 <e5bfff550909250704x724fd4c7lebe7184b4557c7a9@mail.gmail.com>
	 <4ABCCFE4.6070202@viscovery.net>
	 <e5bfff550909250718y51709692kc8d1e2586017341b@mail.gmail.com>
	 <4ABCE167.7060204@viscovery.net>
	 <e5bfff550909251125t6ed59b1fv953eee597adc4471@mail.gmail.com>
	 <4ABD0E90.5030301@gmail.com>
	 <e5bfff550909251144ma9e4dccmb54a64f364b820fa@mail.gmail.com>
	 <e5bfff550909251208v68a561beu2d9f21ae2417fdd6@mail.gmail.com>
	 <4ABD178E.8000508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: alexandrul <alexandrul.ct@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 22:04:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrH2C-0004fw-7U
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 22:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbZIYUEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 16:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbZIYUEN
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 16:04:13 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:35707 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbZIYUEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 16:04:12 -0400
Received: by ewy7 with SMTP id 7so2880239ewy.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=SoOmeKS7DkF1fmAHKsBhuUv+9XyXvL3/CzmFOZz7WS0=;
        b=fMUPm6vIL/CYUKWIFdUjca/lDc8iaNra1XSs10LpSUFEs0TQuDBTt+Y5fQEyEitCVO
         dyKVI2nQf6t2PpIe3FqE7ztt1s4pgSf7UsQREeWXb941qG/s1P3Kcnz2diHAF+00lZoT
         F/ic++MgpKX1Z7rT19lVFr72K4MPw9l3wTL0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AqA5B4Krs9HoN9x1WCEu0gCx25M83mI0dJpmiY4DyB/8QDiiPELXPqOJm7vJcGxNbS
         /EOUkWkk64yXekw+sHnJiXDZbPnJH7TnutQ5wunvU5+dnQJDCQza4kJfEi5ziKd6+tV6
         OZzeOd9JsRyhO6HGR7IVpmu/SJDiFsSaAyGfI=
Received: by 10.216.16.148 with SMTP id h20mr115781weh.141.1253909055441; Fri, 
	25 Sep 2009 13:04:15 -0700 (PDT)
In-Reply-To: <4ABD178E.8000508@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129110>

On Fri, Sep 25, 2009 at 20:18, alexandrul <alexandrul.ct@gmail.com> wrote:
>
> then check your PATH and the configuration files from your HOME folder (as
> recommended earlier).
>

I have uninstalled git, verified git folder was removed.

I have removed git/cmd from the PATH in Windows and I have removed the
following files from users/marco

.bash_history
.gitconfig
.gitk

I have reinstalled all and it still does not work. There are other
files in HOME that I need to remove ?
