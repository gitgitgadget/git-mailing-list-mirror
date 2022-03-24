Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E2DC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 14:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351176AbiCXO7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbiCXO7j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 10:59:39 -0400
X-Greylist: delayed 2586 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 07:58:02 PDT
Received: from user1.webd.pl (user1.webd.pl [194.181.122.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A72BF3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 07:58:02 -0700 (PDT)
Received: from wn13.int.webd ([192.168.101.113] helo=wn13.webd.pl)
        by mxn00.webd.pl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <adama@puszkadla.com.pl>)
        id 1nXOEn-0005Rs-4k
        for git@vger.kernel.org; Thu, 24 Mar 2022 15:14:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=puszkadla.com.pl; s=default; h=Message-ID:Subject:To:From:Date:Content-Type
        :Sender:Reply-To:Cc:MIME-Version:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=usEXCWX2kpuuvtUyTemO4F/I3l6qEkkQRwqHiRF1RQU=; b=xs1BTPMbuO6chGy8lhrwHOIn/8
        lCifol0UaaYYrsz3mWFCAm49H2zJRGpEHN+zC0jWDg3Iru2ieD5jNljwOt5io+3iKSyUShAV+O+aF
        7H9f9wi/isuGvS3bI1VliBG+a5QFlKR8JlK02biHiVBq/nP3/ky+1XA/Xtb0fqjyCScXRG8GJXBR9
        +BCeSvgjcxghrqygUeF8JjsxzYUPgv3k7v0kNa+slML6NoHR295hQHquyWSDHjromjy91iiSlx2vu
        E3KiZqMCZSZJgKA/BAH4IYvv+joadJGzhilxLEO4fJyNA+0+6R+cPsATGtB1hOxeXaZXFxbWE5wah
        6bz9L7yA==;
Received: from afjb128.neoplus.adsl.tpnet.pl ([95.49.235.128]:53275 helo=dell)
        by wn13.webd.pl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
        (Exim 4.93)
        (envelope-from <adama@puszkadla.com.pl>)
        id 1nXOEm-0023pG-WB
        for git@vger.kernel.org; Thu, 24 Mar 2022 15:14:53 +0100
Content-Type: multipart/mixed; boundary="------------000205030902090206000509"
Date:   Thu, 24 Mar 2022 15:14:53 +0100
From:   "adam poplawski" <adama@puszkadla.com.pl>
To:     "Dla git" <git@vger.kernel.org>
Subject: pytania
Organization: adam pop
Message-ID: <908589a09eb2a9dce63681704f8c06b9@puszkadla.com.pl>
X-Priority: 5 (Lowest)
X-Antivirus: AVG (VPS 220324-0, 24.3.2022), Outbound message
X-Antivirus-Status: Clean
X-SMTP-authenticated: YES
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--------------000205030902090206000509
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

witam

Mam na imi=C4=99 Adam, sko=C5=84czy=C5=82em 35 lata. Pomimo mojej niepe=C5=
=82nosprawno=C5=9Bci

ka=C5=BCdego dnia jestem osob=C4=85 pogodn=C4=85, mam wiele marze=C5=84.., =
uwielbiam

muzyk=C4=85 elektroniczn=C4=85 oraz interesuj=C4=99 si=C4=99 fotografi=C4=
=85. Jednak

najwi=C4=99kszym moim marzeniem jest M=C3=B3c Normalnie =C5=BBy=C4=87=E2=80=
=A6 Nie wiem, na ile

ono si=C4=99 spe=C5=82ni w moim =C5=BCyciu, ale ja uparcie wierz=C4=99, =C5=
=BCe moje =C5=BCycie

si=C4=99 nareszcie odmieni..

Cierpi=C4=99 na m=C3=B3zgowe pora=C5=BCenie dzieci=C4=99ce czteroko=C5=84cz=
ynowe, dlatego

poruszam si=C4=99 na w=C3=B3zku inwalidzkim. Cech=C4=85 charakterystyczn=C4=
=85 m=C3=B3zgowego

pora=C5=BCenia dzieci=C4=99cego jest post=C4=99puj=C4=85ca patologia

mi=C4=99=C5=9Bniowo-szkieletowa. M=C3=B3wi=C4=85c pro=C5=9Bciej, bez odpowi=
ednich =C4=87wicze=C5=84

nast=C4=99puje zanik mi=C4=99=C5=9Bni, pogarsza si=C4=99 utlenienie ca=C5=
=82ego organizmu,

zabiegi i =C4=87wiczenia pozwalaj=C4=85 na popraw=C4=99 ca=C5=82ej koordyna=
cji ruchowej, z

kt=C3=B3r=C4=85 mam najwi=C4=99ksze problemy.

By m=C3=B3c to osi=C4=85gn=C4=85=C4=87 musz=C4=99 je=C5=BAdzi=C4=87 na turn=
usy rehabilitacyjne. Jeden

turnus to wydatek 6000 z=C5=82. W moim wieku ju=C5=BC bardzo trudno uzyska=
=C4=87

dofinansowanie. PFROM maksymalne dofinansowuje 1600 z=C5=82 raz na 2 lata.

Jestem pe=C5=82en nadziei, =C5=BCe dzi=C4=99ki Waszej pomocy uda mi si=C4=
=99 wiele

osi=C4=85gn=C4=85=C4=87 i zaczn=C4=99 normalnie =C5=BCy=C4=87

B=C4=99d=C4=99 niezmiernie wdzi=C4=99czny za wsparcie finansowe, gdy=C5=BC =
moje skromne

=C5=9Brodki nie pozwalaj=C4=85 mi na rehabilitacje

fundacja avalon ul. Domaniewska 50A 02-672 Warszawa

tytu=C5=82 wp=C5=82aty 825 Adam Pop=C5=82awski na pomoc

nr konta 62 1600 1286 0003 0031 8642 6001

JAK PRZEKAZA=C4=86 1% PODATKU?

Wype=C5=82niaj=C4=85c odpowiedni=C4=85 rubryk=C4=99 w rocznym zeznaniu poda=
tkowym PIT

1 NUMER KRS: 0000270809

2 Wnioskowana Kwota nie mo=C5=BCe przekroczy=C4=87 1% po zaokr=C4=85gleniu =
do pe=C5=82nych

dziesi=C4=85tek groszy w d=C3=B3=C5=82.

3 INFORMACJE UZUPE=C5=81NIAJ=C4=84CE : 825 Pop=C5=82awski Adam

4 Zaznaczy=C4=87 Wyra=C5=BCam zgod=C4=99

SMS CHARYTATYWNY Wystarczy wys=C5=82a=C4=87 SMS pod numer 75 165 w tre=C5=
=9Bci  POMOC 825 bardzo jest wa=C5=BCna ta tre=C5=9B=C4=87 niestety nie mia=
=C5=82em wp=C5=82ywu na tre=C5=9B=C4=87
Koszt SMSa to 6,15 z=C5=82. brutto (kwota zawiera VAT), z czego dostaje 6  =
z=C5=82 z=C5=82
=2E 
Z wyrazami szacunku

Adam

-- 
Ta wiadomo=C5=9B=C4=87 e-mail zosta=C5=82a sprawdzona pod k=C4=85tem wirus=
=C3=B3w przez oprogramowanie AVG.
http://www.avg.com

--------------000205030902090206000509
Content-Type: text/x-vcard; name="adama.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="adama.vcf"

BEGIN:VCARD
VERSION:2.1
FN:adam
N:poplawski;adam
ORG:adam pop
TEL;WORK:+48
EMAIL;INTERNET:adama@puszkadla.com.pl
URL;WORK:http://puszkadla.com.pl
END:VCARD
--------------000205030902090206000509--

