From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/23] nd/sparse reroll
Date: Mon, 14 Dec 2009 18:11:58 +0700
Message-ID: <fcaeb9bf0912140311n58197439k7a7b4e42316e286a@mail.gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com> 
	<4B261CF0.8090102@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 12:12:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8r5-0006m7-Dd
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 12:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864AbZLNLM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 06:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756872AbZLNLMW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 06:12:22 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:34922 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851AbZLNLMS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 06:12:18 -0500
Received: by pwj9 with SMTP id 9so1855299pwj.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 03:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LNVcN/hychMp6XJzrqI5g/3k+4WSZSfMFCalYVB9gEk=;
        b=eyjAPabKU/0LUo/xiLscXBjEHrPhH5zu9SCTXRyPyfemxeYEFY0dXt/+JGdorRPUPV
         DZUTxJSwokaZ2+B+2DaWRAmrVLTNnCDFU8b1GVvhp+++Si9tlkD49laeE3yonaYd8RRr
         eBj3kXePaat8/fcVWysBdwe9cSo0as+o+6MCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OIlNfAUBTlJO6reDE/oeh//5ytVLbx4vaf3NHrSk1Wh3PxhtgNMZVuOvoRaiC+jy/F
         1nrxT2mGWNilN5bOpnSrXFlNBxijH/Gy7V3bctLRlL7w+FjetT5R4zl66NWUzi3aSVHk
         LcMlWBGa+9vcm95bP3eHgEWyGF/MLSNksgNS8=
Received: by 10.114.28.12 with SMTP id b12mr3080056wab.209.1260789138098; Mon, 
	14 Dec 2009 03:12:18 -0800 (PST)
In-Reply-To: <4B261CF0.8090102@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135198>

2009/12/14 Johannes Sixt <j.sixt@viscovery.net>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
>> Compared to the current series in pu, ...
>
> Obviously, you didn't notice that the series is already in next, whic=
h
> means that you should have made incremental patches on top of bbbe508=
d77.

Argh.. sorry I did not catch up with git@vger lately. Will resend.
--=20
Duy
