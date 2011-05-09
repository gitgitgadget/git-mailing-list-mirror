From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Tags named '-'
Date: Tue, 10 May 2011 00:04:16 +0200
Message-ID: <BANLkTinDHCq4DAiN-3CQPjcZe7LswOxuZA@mail.gmail.com>
References: <1304954496.11377.11.camel@kohr-ah>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 00:05:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYZh-0005au-38
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298Ab1EIWE6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 18:04:58 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55672 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158Ab1EIWE5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 18:04:57 -0400
Received: by qyg14 with SMTP id 14so4366392qyg.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=/YBwtlw56HAG6BeM6Pu9Kt1L2d4Nlr0fx+ASmUTVKFE=;
        b=nX0kBwaQiiH1WJzj18eNloNK38MMmWaZsTLU912AtpwSDj3lcg/dRVE4vmUqWVfhRx
         BfEIuVHK5NTewmIGEmbPprm1khxP1EftK0ucg3z1aSSg46KPaTzHM5v1ltvIr+YwzvTe
         PUC7iCfIuWNi1+iV70FHQ/FzZfBsZqUzwFE2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xn4PvAyEv/m1G7xd/NRlt9laDwErbd40y8xUDdMxPp2epWyVshYJu/unzcMlDUTyf4
         5tSbivwisbhEG9ZdkCdYtfsJZ6mk3uesaG1sAUq9oZqa/NiyFSwWM5MhOzVOaJlhQoql
         PVqVhH5HZLQEkPdsFJ/5btFSV3+Q4Vead7miE=
Received: by 10.229.45.203 with SMTP id g11mr5542008qcf.65.1304978696165; Mon,
 09 May 2011 15:04:56 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Mon, 9 May 2011 15:04:16 -0700 (PDT)
In-Reply-To: <1304954496.11377.11.camel@kohr-ah>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173263>

Heya,

On Mon, May 9, 2011 at 17:21, Alex Vandiver <alex@chmrr.net> wrote:
> =C2=A0The functionality of `git checkout -` is very useful, and I am =
hopeful
> that `git merge -` will eventually land, as it matches my workflow we=
ll
> as well.

Speaking of which, my cursory check of 'man git-checkout' did not give
me any information on 'git checkout -'. ISTR it lets you check out the
branch you were previously on, but I'm not sure. Is it undocumented,
or am I missing it (entirely possible, searching for an option named
'-' is somewhat difficult).

--=20
Cheers,

Sverre Rabbelier
