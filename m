From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 09:36:06 +0900
Message-ID: <fc339e4a1001131636m6e797112id1ecc7fd909311a0@mail.gmail.com>
References: <op.u6g8jnixg402ra@nb-04> <871vht7cs2.fsf@catnip.gol.com> 
	<alpine.DEB.1.00.1001140132110.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 01:36:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVDhP-0003tB-Bx
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 01:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab0ANAg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 19:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794Ab0ANAg1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 19:36:27 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:45803 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab0ANAg0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 19:36:26 -0500
Received: by iwn32 with SMTP id 32so76810iwn.33
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 16:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=EyKYi3si0y6YYNWHvL+L6bzKJlWeNqgxLTegFv5GDsY=;
        b=fMasaMB02eHC5prRLYkTJnYtFfcSC2Yy0pLskCIBkZuhjlYGzGN2cRErxvcFoyUZWU
         Z9UvicjvBoDxy4k5v37TW0djeGRZHFmcP+2QLYempAagWyWRJGhVkYk6k0RccwqMXzME
         10Rq/b1TlB1CQWervnpde/LnsQHdVO/hZE4uA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=GjOzEjfUEWBZrr5ZHB2oE8oxgYI07lVqgHoKWAEYCKyxFttSjiD4YhSmpERvQ4vLQ3
         SgTM+Xqnp4TDCLEu9K2RyI8iu0SCm+t/HlBJw4SwoNaxn4/yfqTglEXhpMatMK42QJo8
         5ya4yWM5EcrBgkw/8heIAsAUF+OU3ckU3gpck=
Received: by 10.231.167.212 with SMTP id r20mr72093iby.7.1263429386104; Wed, 
	13 Jan 2010 16:36:26 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001140132110.4985@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 598ddee3f4bbdc51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136905>

On Thu, Jan 14, 2010 at 9:33 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> I've wanted this for a long time, but discussions about it always se=
em
>> to end up petering out...
>
> That is not fair. =A0I came up with a patch already years ago. =A0You=
 could
> always have applied it to your own source, maybe after tweaking. =A0A=
nd then
> maybe lobbying for it.

Ah, sorry, I didn't mean anything against your patch, I just didn't
know about it.
I don't track this list as well as I could....

[Do you have a pointer to your patch?]

Thanks,

-Miles

--=20
Do not taunt Happy Fun Ball.
