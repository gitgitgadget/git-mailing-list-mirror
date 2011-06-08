From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 18/19] transport-helper: Use capname for gitdir capability too
Date: Wed, 8 Jun 2011 22:57:59 +0200
Message-ID: <BANLkTi=BkqgRY2qoYL9uM2FoLVMqAEMoAQ@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-19-git-send-email-srabbelier@gmail.com> <20110608205423.GL27715@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:58:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUPpt-0001fm-85
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 22:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab1FHU6k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 16:58:40 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33977 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab1FHU6j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 16:58:39 -0400
Received: by qwk3 with SMTP id 3so428412qwk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=RFc48/J/MI53Anz69KFC431GotdaEijcqLjmu/a3BIs=;
        b=tPDfwZl0sLTycbXLzfQ5/5dHmH7wGABo4485KXIiiH+yavTtAyFL5mwnx7xH5unOmL
         lgfFIpaJIafEaKrOE3uZODOWiBG0nMdziw0kos8L0ZKuEgjMzhpDUxdOZdsESweSIh08
         azuRWRsMr04eO8icN4aQgtAUM+xqhZ6t/Obsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kVeWKW+Pa891aFeD9EnVb0kru/p/5BdW45cCAAi3nblh3+ErP4I6qYoMz4Z1PAF1ll
         ZzhMm3xOy6FLwYP6C8pY3pncr0Dnht0U/Ri/25wwknekLHlSjgjs3fEfaQgZC0r0veDa
         Rmrwb1xJ0sh0S+CDKpWOY2ej1gGoj4a4vt5Xs=
Received: by 10.229.127.99 with SMTP id f35mr5900806qcs.91.1307566719112; Wed,
 08 Jun 2011 13:58:39 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 13:57:59 -0700 (PDT)
In-Reply-To: <20110608205423.GL27715@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175459>

Heya,

On Wed, Jun 8, 2011 at 22:54, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Thanks. =C2=A0The old commit message said [...]
> which seemed like a somewhat helpful thing to mention. :) =C2=A0I sus=
pect
> the after-the-cut comment would be helpful for future readers, too.

Yeah, not sure what happened, but all my commits had zero-to-none
commit messages. Perhaps I just added them while sending out the patch
series last time? Anyway, can't remember, but that's why, fixed
locally :).

--=20
Cheers,

Sverre Rabbelier
