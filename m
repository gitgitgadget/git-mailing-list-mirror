From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [ot] Re: gitblogger
Date: Fri, 21 May 2010 18:24:38 +0800
Message-ID: <AANLkTinN37ee6_gfsQqSajoYPAbq7GEaFf93L4dNiVYo@mail.gmail.com>
References: <ht3reo$b6i$1@dough.gmane.org>
	 <AANLkTilpaRyrIgHN5eK_jRFJoukOSYlyEMwU1-LdGT0K@mail.gmail.com>
	 <ht5huo$nd1$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 12:24:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFPPI-0000Ap-T3
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 12:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919Ab0EUKYj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 06:24:39 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:65532 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab0EUKYj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 06:24:39 -0400
Received: by qyk1 with SMTP id 1so1197625qyk.5
        for <git@vger.kernel.org>; Fri, 21 May 2010 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rm2f/tM7qkpVhcR6eYJ8nZKszSgeFFsaaoRJ+5yodyY=;
        b=pye7MLH4Heh1Xbcj+R4wLc07WsDErz1b6QGKx36DYb5HCtIQQ3vCxukDvQs6sumw7j
         Uk4e6VFYRigu9rbUw9zb6bTBpgWRnpG1VwD8XdQ/yiHDn/2lkRueOZ00rantWABfmPmj
         prgX/eU6PmOgP0xX53ySCm0uchzwCQdIXUPnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fU9eCyXm0O3HszgRrjsJzwDQEPHwq2RHJg6qdKJEXkbY6vNyOSFT7hiXnqrwWGc28Y
         zBEfpA8HU6it4eCVLHyjT3gQPkfNGsJdKAYYdRFajrHRilmDNCXgznxo6I/Tg+sStd0F
         quY2+KfhtcbOyzAps/Qx+FP5wkMKkgTKjWp6c=
Received: by 10.229.218.19 with SMTP id ho19mr317150qcb.143.1274437478040; 
	Fri, 21 May 2010 03:24:38 -0700 (PDT)
Received: by 10.229.83.145 with HTTP; Fri, 21 May 2010 03:24:38 -0700 (PDT)
In-Reply-To: <ht5huo$nd1$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147447>

On Fri, May 21, 2010 at 4:57 PM, Andy Parkins <andyparkins@gmail.com> w=
rote:
>
> Ping Yin wrote:
>
> >> http://gitorious.org/git_blogger
> >>
> >
> > You may want to have a look at toto ( http://github.com/cloudhead/t=
oto )
> > git + github + herokou + markdown + txt store
>
> Maybe I've misunderstood, but isn't this just a similar thing to ikiw=
iki? =C2=A0I
> realise it's not a full wiki, but this toto still requires self-hosti=
ng of
> the blog?

Yes, it requires self-hosting. However, you can host it to heroku for f=
ree.

>
> I really wanted to be able to make someone else (Google) do the hosti=
ng for
> me, but still be able to use lovely txt + git.
>

I think your solution is great too.
