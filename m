From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Implicit stashes
Date: Wed, 30 Jun 2010 07:57:03 +0200
Message-ID: <AANLkTimIJcOe3fufZx83LxI8ZSDP8cCOj1BEPPbUy7Ol@mail.gmail.com>
References: <AANLkTilTaQP6qARY1A495vm9HAvLVX_lqIQd1l3WIv7a@mail.gmail.com> 
	<4C2AB260.8020108@workspacewhiz.com> <AANLkTimOTBzN7lnniImy2eqoBh775X9NbzIwcetS1GHh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 07:57:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTqId-0004UX-Oc
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 07:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273Ab0F3F5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 01:57:25 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56988 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab0F3F5Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jun 2010 01:57:24 -0400
Received: by yxi11 with SMTP id 11so43608yxi.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 22:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=plyPSfV2Etmt1OHqSQwFK0a8qcYR6JjjoF20ojaw6Vo=;
        b=mL1GCqNaeu2ope2VM+CbI8NaV6lxtUOV4DrpUnBb/fr8B3JM9eIBAgjhApyAFXm7TX
         CbluD/q77xzNZKYxd+9khvQYT3XKXM5qxfBD0eaPA6FMT+Mz7s0KLL3khBQX2H/bZV6N
         qoq6fe62o1rmjaKI7PqUDUDBgeE0ZPiGLhjdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LSW9Hw1oQudvMC+NdWDoNTu7jp62mbbx31Fbs3+DPatLCYPTz9S2wq1wtWCGrjW3M6
         PwO3IvL3Hr0Zh710d2QMQ0Y+a+Q2b5y3iAtVcBdPkcDckX60ER7/yxb1MapCniCXQMAm
         zTXA6hhNZi7MNNs0wqt8f5lE09xu27wc1QLUw=
Received: by 10.91.126.15 with SMTP id d15mr6821745agn.37.1277877443465; Tue, 
	29 Jun 2010 22:57:23 -0700 (PDT)
Received: by 10.150.184.8 with HTTP; Tue, 29 Jun 2010 22:57:03 -0700 (PDT)
In-Reply-To: <AANLkTimOTBzN7lnniImy2eqoBh775X9NbzIwcetS1GHh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149946>

Heya,

On Wed, Jun 30, 2010 at 05:05, John Tapsell <johnflux@gmail.com> wrote:
> I can't do it myself, but I'll give $50 to someone to get this going
> and do this :) =C2=A0(I know that is an insultingly low amount, sorry=
)

Hehe, I'll match your $50 and raise you a beer ;). Isn't there some
relevant site where people can pledge for stuff like this? Either way,
I doubt for most lack of financial stimulation is what's stopping them
from implementing this, but rather lack of time which cannot really be
compensated financially.

--=20
Cheers,

Sverre Rabbelier
