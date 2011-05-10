From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [ANNOUNCE] libgit2 v0.12.0
Date: Wed, 11 May 2011 00:28:36 +0200
Message-ID: <BANLkTik_eGj4Vu4Ki5vBo4OACbWySMB_YQ@mail.gmail.com>
References: <BANLkTi=NesUc=9eZp7SapkpZ2MkdgPCZHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: libgit2@librelist.com, git@vger.kernel.org
To: Vicent Marti <vicent@github.com>
X-From: git-owner@vger.kernel.org Wed May 11 00:29:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJvQh-0005kJ-Eq
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 00:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab1EJW3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 18:29:18 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47628 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab1EJW3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 18:29:16 -0400
Received: by qyk7 with SMTP id 7so1994157qyk.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 15:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/U5+rGkHm4IMSHpcol/aCYSURwGvOOgC34WUe5Td40g=;
        b=rYdmgws6epd9CarreL+viwyiRDY+RuV0Xrr2n5oezleAAzEKNbDPnYwcrwVugmHmvj
         2pDmN0SQNVaH61TuYyjiJyQPoRilTdhtk2M6Xy0FRvTc1+6E42ELxMb17PDUWXOuLk9D
         y6XGHOjBzlI0SKn9089nGVoC9y3joXRl8yCi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kCcTzcKCODtm9m0Z/fJwQL4JASr86SNvakTAS5rzshZCNVNrzrrecHFkpYGR6sdwea
         dABbaIZ+k4SDgntUSXfJt2CDYp5jUWPIY5zVxevvtb6MOX6jtZCJhhZtToLhv1MquXU9
         IfLDTqTzk4ud/FGXvXPCVhZVZaujldLcd1zpc=
Received: by 10.229.90.90 with SMTP id h26mr6701186qcm.103.1305066556128; Tue,
 10 May 2011 15:29:16 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Tue, 10 May 2011 15:28:36 -0700 (PDT)
In-Reply-To: <BANLkTi=NesUc=9eZp7SapkpZ2MkdgPCZHg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173375>

Heya,

On Wed, May 11, 2011 at 00:12, Vicent Marti <vicent@github.com> wrote:
> as thoroughly requested, and after much delay, here's the new minor
> libgit2 release.

Cool! I like the crossposting of at least the announces to give the
project some more visibility in git@vger. Keep up the good work! :)

-- 
Cheers,

Sverre Rabbelier
