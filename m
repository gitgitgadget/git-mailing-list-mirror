From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Using Transifex in git.git
Date: Tue, 14 Jun 2011 15:42:12 +0530
Message-ID: <BANLkTinkc6yZ39JVtBaENikFj5xPKnh9mw@mail.gmail.com>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com> <4DF726F4.3000204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dimitris Glezos <glezos@indifex.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jun 14 12:12:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWQbv-0005z1-CT
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 12:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab1FNKMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 06:12:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35171 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab1FNKMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 06:12:33 -0400
Received: by wya21 with SMTP id 21so3770602wya.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=pIjUsKpQvqu99gxft2Ezs/B0DYY84HjbrJj90ZVCBr8=;
        b=QIzYCyfsda5mMVyENg/2ZYjjyrJgHttE6oYinbwitlto6/0oTdEaxWDJc1EwraMefA
         QIN8S1SeMZ7q1LBg6I/s+kbZuK7ZjtGy25ua3IYZ22hA+PlaWB+GUGfxfcJ/sJAyElzc
         n/TCVgI/wqbltlkCOpkjAN9PETe/6dqg8TDEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Xg1Habc8FDET6m+cJ9rG83O1MZqLfvJcA8nBQhhTYjjPSG4lOT5/36mny8HkZ+6D5A
         6FRq18Xa4FCi6OXt5Ir5wbiIE/LRP+ipRA4Dva2gr/zuhPTY53krJmZzJ0jYrxlT7OpC
         TguunrQJDbHBdjfA5WVCfrrwGoTf2prlz3ots=
Received: by 10.216.201.163 with SMTP id b35mr6011312weo.80.1308046352265;
 Tue, 14 Jun 2011 03:12:32 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Tue, 14 Jun 2011 03:12:12 -0700 (PDT)
In-Reply-To: <4DF726F4.3000204@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175757>

Hi Andreas,

Andreas Ericsson writes:
> It's always better to start coding on changes and then show how those
> changes make life easier for people than to suggest something out of
> thin air and start a discussion about it before applying any work.

Yes, this would normally be the case.  My apologies for being unclear
about the purpose of the original email: It's not a sales pitch where
I'm trying to sell one translation system - I'm merely trying to find
out what features the community at large would like from an abstract
web-based translation engine; what should it look like so that it fits
into our current patch/ review system?  What this translates to in
terms of work: evaluation various translation systems, and writing the
necessary features into the one that comes closest to what we want.
At a glance, Transifex seems to be a good option, but I could easily
be wrong about that.

-- Ram
