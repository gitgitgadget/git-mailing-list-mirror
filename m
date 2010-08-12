From: Sultan Shakir <sshakirflhosp@gmail.com>
Subject: Re: Can Git work for us if we are remotely hosted?
Date: Thu, 12 Aug 2010 13:59:12 -0400
Message-ID: <AANLkTimxYgAwWWoJCxsQ_Rr-eGfWJWoL4Qscw3FBYk9_@mail.gmail.com>
References: <AANLkTin4JyZhmjm_1c4q7kjP0eXzA-_2eNsLzsnGASet@mail.gmail.com>
	<AANLkTi=GDj47jieVL4+0YD1X5pa+9g7=c2wRx_T3CDVS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Avery Pennarun <apenwarr@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 12 19:59:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojc3q-000501-Ou
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 19:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760539Ab0HLR7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 13:59:17 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49271 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760525Ab0HLR7P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 13:59:15 -0400
Received: by qwh6 with SMTP id 6so1779067qwh.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=AaKjCleG9RpiQpnS9EA1Lz/ybgnpMOAv8YhZfv5AxMQ=;
        b=U+MQfXFdyvY6earNN29qwxGRf+OcPF3XDOnpMQgaNbUjjmS2FEMVxb0lZViadjsH4a
         ai5stuDHALmdUE3weMcaiHbr3iefhRUQRM50jN0E8giTh707xxpSOvIPhLT/MwdI20sz
         R0IyqrBwNfFjZdGYtchsrAUu8cwWlp4VYC2Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=O23ZMiHxI/asDmH/tHTaVZMg75P5pLtGW6liwSXdYIEqh3IzF4/Ey9YmelUIQtWzP3
         ShlgBoFMOwFtgD+CYrU43nxn3vCxI7ka6PBM5BmjOwLQdZOx8eGaqqr79pGLmbNThHF2
         yErSy3jGYITC54+3Auu3sFifxniVh47S4K9cQ=
Received: by 10.229.192.4 with SMTP id do4mr370811qcb.164.1281635952804; Thu,
 12 Aug 2010 10:59:12 -0700 (PDT)
Received: by 10.229.69.76 with HTTP; Thu, 12 Aug 2010 10:59:12 -0700 (PDT)
In-Reply-To: <AANLkTi=GDj47jieVL4+0YD1X5pa+9g7=c2wRx_T3CDVS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153396>

On Wed, Aug 11, 2010 at 7:06 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Wed, Aug 11, 2010 at 6:51 PM, Sultan Shakir <sshakirflhosp@gmail.c=
om> wrote:
>> I've been trying to wrap my brain around how I can get Git to work a=
t
>> my organization. =A0The issue is that nearly all of our programs and
>> their IDE are remotely hosted. =A0This means that to even work on a =
file
>> we have to connect to the network in order to use the application th=
at
>> we code in. =A0We do have access to the backend where the files are
>> stored though. =A0How can we use Git in this situation without setti=
ng
>> up another server?
>
> If you want, you could just push/pull to a git repo in a file share o=
n
> one of your existing fileservers.
>
> Have fun,
>
> Avery
>

Avery,
Please excuse my ignorance.  What do you mean by a "file share" and
"existing fileservers"?
