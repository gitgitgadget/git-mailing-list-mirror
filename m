From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Add Russian translation to gitk
Date: Mon, 27 Apr 2009 11:51:34 +0400
Message-ID: <20090427075134.GA15723@dpotapov.dyndns.org>
References: <20090426132452.GB30825@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:08:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyLdN-0000xJ-Px
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 09:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbZD0HwH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 03:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbZD0HwF
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 03:52:05 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:21219 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbZD0HwD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 03:52:03 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1869390qwd.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 00:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iZcYakjorvJEwhJCEJFYmckX0aheElonEbAnjCqDUQg=;
        b=uSh4/q8DZ7YjcwLPy/WUmOZFc1gPGfEfGRG4olKiHy/83e613TKM1Hkte7xSwsu0QT
         ZFfAWpE9a4kS46eZGLTQ106Z3YNpJWPfsmkdpzh34cJyz+jiC1Y4mMFp1ajrlmuvMHDP
         AGXvDAmpGgajb6Prx3Gfbof4Kn/cgG0Sx6eRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bYoWosMsZC7PT2qaBYY8zl2+XnZbl7Ll6AC3/SYBZef4FFiLuyZTemSYWh0hAl1ZlY
         ly4Y4I1/Wf4HsQWahZ1L+NNYjlrMN25FRj3ZxtxMfuWTyfS82OEB/zgJjWEEmTROC9uF
         TNsme2lIlJKnsBNPYubtbk3BDtv1qKDlQo7xg=
Received: by 10.224.2.203 with SMTP id 11mr5324100qak.342.1240818722560;
        Mon, 27 Apr 2009 00:52:02 -0700 (PDT)
Received: from localhost ([91.78.48.223])
        by mx.google.com with ESMTPS id 7sm6246888qwb.10.2009.04.27.00.52.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 00:52:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090426132452.GB30825@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117618>

On Sun, Apr 26, 2009 at 03:24:52PM +0200, Alex Riesen wrote:
> +#: gitk:1917
> +msgid "Reread references"
> +msgstr "=EF=C2=CE=CF=D7=C9=D4=D8 =D3=D0=C9=D3=CF=CB =D7=C5=D4=D7=C5=CA=
"

reference -> =D3=D3=D9=CC=CB=C1
branch -> =D7=C5=D4=D7=D8, =D7=C5=D4=CB=C1

So, it should be: "=EF=C2=CE=CF=D7=C9=D4=D8 =D3=D0=C9=D3=CF=CB =D3=D3=D9=
=CC=CF=CB"

> +
> +#: gitk:1918
> +msgid "List references"
> +msgstr "=F3=D0=C9=D3=CF=CB =D7=C5=D4=D7=C5=CA"

"=F3=D0=C9=D3=CF=CB =D3=D3=D9=CC=CF=CB"


Dmitry
