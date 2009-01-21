From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Re: how to track multiple upstreams in one repository
Date: Wed, 21 Jan 2009 18:02:51 +0200
Message-ID: <8e04b5820901210802y1102cfd0q4a3f8812f357c398@mail.gmail.com>
References: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm>
	 <20090119021426.GA21999@shion.is.fushizen.net>
	 <alpine.DEB.1.10.0901181957070.20741@asgard.lang.hm>
	 <8e04b5820901182352n29b3885cj850e6ddae6ca237f@mail.gmail.com>
	 <20090120033402.GC8754@kroah.com>
	 <8e04b5820901192329pf44431coce4423e6a8d43198@mail.gmail.com>
	 <20090120120319.GR30710@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Greg KH <greg@kroah.com>, david@lang.hm,
	Bryan Donlan <bdonlan@fushizen.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 17:04:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPfYy-000672-Do
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 17:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbZAUQC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 11:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbZAUQC4
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 11:02:56 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:35726 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbZAUQCz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 11:02:55 -0500
Received: by ewy13 with SMTP id 13so1559019ewy.13
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 08:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=plZn8O5SphObLv0kAot0mrRJ63Xu7Aak1qZ8XGR8vf8=;
        b=xwUF+49aJRbx2MKc3szkD1CUaBjGU6QrPVOYbDBIiyg46k9VJ+rA51dVLX98m4MyrK
         KrHqiMBr0uSXe246qQKozA8l5DAHjhC7/UHNWE4X9GaIBE4ghSPVlt5CrNn6WDYzcgbb
         CIp9L0+MEfeyD/KjB4Fzc+ApJ+hyZITpdd1cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qkAOsG5/y/2vgeJsEqWbCdp9YGNIBKTqJ1RA8OQkq2v8Rf340Q9SDLWYG7Aqm4Yqo4
         HuIa36ramIpwKdahueHnFJI15WGGFNEPJzq05TdMat5c0e3oKaVP+alnH4h51TaEHfwW
         y/yYC39x8P/FAsxLRtftGMcKbLvRza2P487FY=
Received: by 10.210.120.17 with SMTP id s17mr894014ebc.54.1232553771794; Wed, 
	21 Jan 2009 08:02:51 -0800 (PST)
In-Reply-To: <20090120120319.GR30710@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106621>

On Tue, Jan 20, 2009 at 2:03 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Tue, Jan 20, 2009 at 09:29:13AM +0200, "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> wrote:
>>     :) This is something that escaped me... Could you give me the
>> exact git url for this repository? (on kernel.org I'm not able to find
>> it, just the current one...)
>
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6-stable.git
>
> Have you tried this one?

    Ok... I'm ashamed... :) :) This is exactly what (we all) were
looking for... Sorry.

    Just one curiosity: is this older (I mean if it was created) than
when 2.6.18 or 19 was released? Because at that time I've searched for
such a repository, didn't found it and hacked the config as I've said
previously...

    Ciprian Craciun.
