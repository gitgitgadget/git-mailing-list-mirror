From: Michael Witten <mfwitten@gmail.com>
Subject: Re: file mode
Date: Mon, 13 Jun 2011 13:58:59 +0000
Message-ID: <BANLkTik-hvEyZoM1OeaBQUO=6knKYDW+dw@mail.gmail.com>
References: <alpine.DEB.1.10.1106122055210.6124@localhost> <BANLkTimh=-caLH5dVaUeXXmcF21+=-o0tw@mail.gmail.com>
 <20110613053814.GA2680@sigill.intra.peff.net> <4DF61634.7020003@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Peter Kleiweg <pkleiweg@xs4all.nl>,
	git@vger.kernel.org
To: =?UTF-8?Q?Dirk_S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon Jun 13 15:59:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW7fz-0002ZN-06
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 15:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab1FMN7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2011 09:59:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35516 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab1FMN73 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2011 09:59:29 -0400
Received: by iwn34 with SMTP id 34so3807659iwn.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=WosebpPBg8ruf+ExMJ2Zzn/t2OPqk0AgMBlLQl4KwDE=;
        b=mwIRGIs5+tY8NN4W1F/Y7y4dTCLZsGhZThchh++w5v6X5tO0U7k6U3kV1PHpUToQdp
         zEi84oRTa5s3xjURzQR+YnNfcFbDyzCEr/btyh5qPGNGqP8PHwJy48zFA2OWd/pRGr5Q
         OD/0QHnfmgZSKzfKOBwV2kGoNh0HpQ2LxjINU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Hzxac0vN/QUWbKskkx9+qyXuCw/F5TYGoaPr3h6Ko/2BHxXoHxfcypmQH/QthTmZXm
         a3NQh9YLxLH142dUxUqlHGNCrFYiM6S/In4whre9rgsMK2Xc23zKibkBADSmCwMjn5Sp
         Grl23rxZdE+ZHWn2PXAToVp8Z5uZ60jKhCxWg=
Received: by 10.42.172.131 with SMTP id n3mr7085856icz.247.1307973569085; Mon,
 13 Jun 2011 06:59:29 -0700 (PDT)
Received: by 10.42.217.197 with HTTP; Mon, 13 Jun 2011 06:58:59 -0700 (PDT)
In-Reply-To: <4DF61634.7020003@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175707>

2011/6/13 Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>:
> I think for most newbees this list is the last
> effort AFTER googling, so googling won't help.

Not in this case, clearly.
