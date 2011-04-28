From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 16:15:10 +1000
Message-ID: <BANLkTimaWr1FA154p87KZM7NT+2CQTuYZQ@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<BANLkTi=XcR9FTPC8oe100fMneNf1nca4_Q@mail.gmail.com>
	<BANLkTikGZgEb-4jzHt+t2k__s7BMgbU9gg@mail.gmail.com>
	<4DB84D65.6070906@gmail.com>
	<BANLkTimyFmujc+Lsd7DMWfJgUzZME+Sveg@mail.gmail.com>
	<BANLkTi=vJeUAwMH0Fa7SXmK=2hwu8vnPGg@mail.gmail.com>
	<BANLkTi=-RYfUrPt+LkUA9GA6_vmTzVkQnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 08:15:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFKVU-0002Vl-RA
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 08:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab1D1GPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 02:15:13 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65500 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab1D1GPM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 02:15:12 -0400
Received: by eyx24 with SMTP id 24so724392eyx.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 23:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=Uove51GgdH9TxYyvTYrFHOX99c1PFTaf3TBpUn78DSU=;
        b=Nvu6Qku9HfIUHxla/tQvctpmW/iZPTrsqbGmPZyD3bL0cWoWs98S7a9Kx91Y8ZHht5
         BmvOz1QcSNgFMxoXhVejzrlzjjis6vu0bki0Bn9WQodVX4nR0VEvftaJM5BDBBWjOlrS
         WgSZpcHtHI5zlMQkuCt9kxRTKP+MOTrRraHes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=Q+wOwoiUZNQ0trJmk90wc55IrJj19fulgBdtUDqDgbIhrrRquy+M7brncOCHH+dltc
         IuVtNTfJRCqpsxSrm9QAfRFtbO4LR9aWN207QoeeZPaowC+m+lN1yDq7urHOVKvxA2ic
         1ehdxrjhTYJxQehbte78QBc6iwEnbFRpsMOqI=
Received: by 10.14.10.130 with SMTP id 2mr1350621eev.181.1303971310823; Wed,
 27 Apr 2011 23:15:10 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 23:15:10 -0700 (PDT)
In-Reply-To: <BANLkTi=-RYfUrPt+LkUA9GA6_vmTzVkQnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172317>

FWIW: I have renamed my github package from gpm to git-plugin.

Contributors who grok the concept as I conceive it are welcome to
submit pull requests.

jon.

https://github.com/jonseymour/git-plugin
