From: Arnaud Lacurie <arnaud.lacurie@gmail.com>
Subject: Re: Gate between git and mediawiki : remote-helpers
Date: Sun, 22 May 2011 19:58:00 +0200
Message-ID: <BANLkTim+2Mv7bnfsNVAsn80MUx8-fjYZow@mail.gmail.com>
References: <BANLkTikTpfpBYddfWcBfzGTuHqLyQ0sE5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	"matthieu.moy" <matthieu.moy@grenoble-inp.fr>
To: Claire Fousse <claire.fousse@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 19:58:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOCvW-00080a-EH
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 19:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab1EVR6W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2011 13:58:22 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51890 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab1EVR6V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2011 13:58:21 -0400
Received: by vws1 with SMTP id 1so3644244vws.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Ol/kTC+iOlXhuiByzZoXHh7mXPQm8Aj93Z8VPj0SsBo=;
        b=LZkA3cFzJbpREs0HsnpqIY0IoTpNDBK5TWkVe1Fc0b3KwAAtGd0GH2EBqMmIofIYIs
         oF2TpoT2lkjMqpi545KLHGCIjJHXLcmjTWByPI3f9fU2PU8XNIpOO+iJhvUON9pckxpK
         kYkDJCS/gNKSDI/8C/CiF6NmzQca3vwZGdcyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Aq6C0Un3p9j6qUX9Q7pUC6TMrJow49rup1pwsUb6fWEy2lS/9uu4EbVI6pw5LzZ/Ab
         etfnEhQXiQl6nk0QxzQYraMmBOuHCkZckcFbOhfbGaFWp35nEThM0ArrcOhV6lePstkp
         pcoq+xbZn96S5wBSMq/A7/bnuyO/M2MZ/NnM0=
Received: by 10.221.9.136 with SMTP id ow8mr501257vcb.78.1306087100146; Sun,
 22 May 2011 10:58:20 -0700 (PDT)
Received: by 10.220.189.8 with HTTP; Sun, 22 May 2011 10:58:00 -0700 (PDT)
In-Reply-To: <BANLkTikTpfpBYddfWcBfzGTuHqLyQ0sE5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174194>

This mail referred to that previous one :
http://article.gmane.org/gmane.comp.version-control.git/173991

2011/5/22 Claire Fousse <claire.fousse@gmail.com>:
> Hi,
>
> I'm a member of the team trying to establish a gate between mediawiki
> powered wiki and git.
>
> We've tried several things which seems to work. However, it is
> something like git-svn and would require some commands such as git-mw
> to work. Is it recommended to use remote-helpers instead of that ?
>
> There is one problem though : nobody wants to git clone the whole
> Wikipedia for instance. And we should add a functionality which allow=
s
> the user to clone only a part of a wiki. Are partial clonings doable
> with remote helpers ?
>
> Thank you for your help,
>
> Best Regards
>
>
> --
> Claire Fousse
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Arnaud Lacurie
