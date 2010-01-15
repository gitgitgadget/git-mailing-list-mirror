From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC] Git Wiki Move
Date: Sat, 16 Jan 2010 00:21:18 +0100
Message-ID: <fabb9a1e1001151521s1837b3d5o2a35cb5bb35c8038@mail.gmail.com>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> 
	<4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr> 
	<4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:21:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVvUC-00076I-2G
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 00:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758626Ab0AOXVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 18:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758616Ab0AOXVl
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 18:21:41 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:48367 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab0AOXVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 18:21:39 -0500
Received: by pzk1 with SMTP id 1so1350217pzk.33
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 15:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=JgalKHPJ6c7ZUWK8D1wRBo28QH8A2JeW6NxkpGiI67g=;
        b=XDeLeP2qd2k7Ifj2+UiLl34nECKP0n4gF/mN+OS8i3oZnmDvC0uRz2ABRkyFwInkE/
         AkakDtosJ8j1TBvs3xW0SV2GLTiR14Whm6Q8JHPgOG1MpQrsE4XVfSyTJAuDGYKqpKoC
         mt2PsuByFygX3KjLn/7S4XrgW15GzxLxg71Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=N1U+ZBzzYsHqVLvMs38ZeZzuys5Odv7yN3sNAbUqSqzzn65cNngMUceD5otQ4qoZNS
         rp6BxgVyxym7YjJ0Qs4A1BWrDhje5CyRAXs0I+y5YJFiklY2BOgun5fAwsnaiORKsELZ
         NUHbjpEfH6VactJKtb6BLrZbNsKi/oSWUMEyQ=
Received: by 10.143.24.26 with SMTP id b26mr2109810wfj.64.1263597698094; Fri, 
	15 Jan 2010 15:21:38 -0800 (PST)
In-Reply-To: <4B50F7DB.7020204@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137159>

Heya,

On Sat, Jan 16, 2010 at 00:18, J.H. <warthog19@eaglescrag.net> wrote:
> Quick update - I think I've got the vast majority of the obvious and
> simple to correct problems fixed at http://git.wiki.kernel.org anyone
> want to run through and see if there's anything else that would be
> considered a show stopper?

I'd say it's pretty embarassing if our FAQ [0] is broken. Don't have
the time to fix it manually atm though :(.

[0] http://git.wiki.kernel.org/index.php/GitFaq

-- 
Cheers,

Sverre Rabbelier
