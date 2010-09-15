From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: ls-files --exclude broken?
Date: Wed, 15 Sep 2010 19:47:30 -0400
Message-ID: <AANLkTimPFvRie8oMErD_X503gfiu=f8_O7JqK9KRznRe@mail.gmail.com>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
 <7v62y661pl.fsf@alter.siamese.dyndns.org> <AANLkTimYNtU7sHn4_Vx50evTWDpMK_=XgshU3ZzT+eVw@mail.gmail.com>
 <AANLkTik7ORPUsABJv-bFraFNt2TvP0Xx=-013P2=A6Nr@mail.gmail.com> <AANLkTi=L0PA-p5HkWnurfurfyYAQhCBt+Q7SzzCczFLH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 01:48:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow1hv-0003nN-Tq
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 01:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab0IOXsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 19:48:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44998 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715Ab0IOXsB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 19:48:01 -0400
Received: by iwn5 with SMTP id 5so510537iwn.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ibbGKxH7T5qfs1ABUSgZZPyj2o0DYyynfkF689MobrM=;
        b=lHUzKhHQ6miTNA8/yZDrcLCphI6I3XnqXVxfHuwNo9XIOO5gBUIzumZ6D9z3hXV96n
         cYVJcdBkyB43gaX/GJBKwBKOu73z1gfZZg/fP5BW/LFXYpGei/tjKywszRhchZZub0nZ
         /K79fas4cBUSEO6EjRuGvEreksYsR9T+Eqgho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=x5jR4ZcQgfjqtzQEvSgzCGrm+nMZyUcdtIWLsxO/A642V769GsL6iNJH0YX/sGTktb
         mftTxrFyv5P3Ezwz1/cNK5AKKJ4G42MhRcSotp8S0A7TnGRC6dj5c0fgl4/bti6Kq5AC
         gRPeMG1cs8Y2Y8h5AE+nwP9vZqxz8hLt+wvRQ=
Received: by 10.231.10.135 with SMTP id p7mr2322508ibp.88.1284594480172; Wed,
 15 Sep 2010 16:48:00 -0700 (PDT)
Received: by 10.231.11.11 with HTTP; Wed, 15 Sep 2010 16:47:30 -0700 (PDT)
In-Reply-To: <AANLkTi=L0PA-p5HkWnurfurfyYAQhCBt+Q7SzzCczFLH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156278>

On Wed, Sep 15, 2010 at 7:41 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> But I'll go dig in the mailing list archives now to see if I can find
> what motivated Jeff's change beyond what he gave in the commit
> message.

http://thread.gmane.org/gmane.comp.version-control.git/129889/focus=129976

Hmm.

j.
