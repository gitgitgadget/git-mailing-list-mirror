Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAA9C433F5
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 12:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7252360F93
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 12:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhJaMMA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 31 Oct 2021 08:12:00 -0400
Received: from atfriesa01.ssi-schaefer.com ([193.186.16.100]:14713 "EHLO
        atfriesa01.ssi-schaefer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231501AbhJaML7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 31 Oct 2021 08:11:59 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Oct 2021 08:11:58 EDT
IronPort-SDR: 8WPde9cIdMArn4a54kRPp6oF0A3z177A/EbU3PMSVwxgdB+T2Goiqu2n80MgBoTo4zmTyrvb5P
 VFtC0wVDrU+ew+QIw1URRtk7GIIWW4Tkt3zdWEhm1hfRQFKs1Hs1j+R5uuDQHUGhdapdNIKpv4
 BXp/qKHTv2cZ5i3PSp+6wcJGtkj/JzXBFxOhgVxWWhLxCrqESusrzMQg2DAHsnqUu0kBr6XAvx
 mdN3foimCHo9V1PctxJOAKwuiGHkGUxwHijrZk4S0ZMY0fW/Qd7NWGpc4tYmyak2dpf4WtHXgr
 NFo=
IronPort-Data: A9a23:Isy2eapLY/y9xoQX8lHj9XuxRHleBmKNZxIvgKrLsJaIsI4StFCzt
 garIBnUbPfeZGb1fo92bo2woEoH7JPSn4NlHVA/pXs8RCtB8pacVYWSI3mrMnLJJKUvbq7HA
 +byyzXkBJppJpMJjk71atANlZT/vE2xbuKU5NTsY0idfic5Dnd+4f5fs7Rh2Ncx2YPgW1rlV
 e7a+KUzBnf0glaYDUpEs8pvmDs31BglkGpF1rCWTakjUG72zxH5PrpGTU2CByKQrr1vIwKPb
 72rIIdVXo/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Z1
 vxsvsa+agUVG4rG3/Q8bkRTHj8vFPgTkFPHCSDXXc279HbnVVLS5theVgcNBqw+06BdIFMmG
 f4wcW5dKEra2qTsmO39GrgEascLdaEHOKsQoHxviz7dAPkmRpXrWL7LoMRT3D49iM1UW+vFD
 yYcQWsxNU+QMkQRUrsRIJVvvuavpnKlSR5Z+GDKvqU55nre0SUkhdABN/KQILRmX/59kUeEj
 nzJ8n6/ARwAMtGbjz2f/RqRavTnlDjhQ4wODPuj7f9viVyXgGoeFHX6SGeGnBVwsWbmM/o3F
 qDe0nF1/MDeKGTDogHBYiCF
IronPort-HdrOrdr: A9a23:lk4ko6+hBaqFkLyg47Nuk+DSI+orL9Y04lQ7vn2YgHRuHPBw8P
 rAoB1773LJYVkqKRMdcLy7Scq9qBDnmaKdg7NhWYtKNTOO0ADDEGgF1/qG/9SJIVyYygc378
 ZdmsZFaOHNMQ==
X-IronPort-AV: E=Sophos;i="5.87,197,1631570400"; 
   d="scan'208";a="96138916"
Received: from asrsftp.ssimail.net (HELO SSINAVMEX2.SSINA.BIZ) ([168.215.207.89])
  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2021 13:01:35 +0100
Received: from SSINAVMEX2.SSINA.BIZ (10.100.1.42) by SSINAVMEX2.SSINA.BIZ
 (10.100.1.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sun, 31 Oct
 2021 08:01:26 -0400
Received: from [77.247.110.23] (10.100.1.43) by SSINAVMEX2.SSINA.BIZ
 (10.100.1.42) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Sun, 31 Oct 2021 08:01:26 -0400
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: ATTENTION, GOOD MORNING
To:     <git@vger.kernel.org>
From:   MARY JOSEN <greg.gleghom@ssi-schaefer.us>
Date:   Sun, 31 Oct 2021 13:01:22 +0100
Reply-To: <maryjosenn1@gmail.com>
Message-ID: <a2bfd371-95fd-4cd1-b840-808bbf049e96@SSINAVMEX2.SSINA.BIZ>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


FROM MS MARY JOSEN
COVID-19 Charity Donation.
Greetings to you my dear,
My name is Ms. Mary Josen, I am 85 years old. A widow, I have been diagnosed with esophageal cancer. I am currently admitted in a private Cocody hospital.

Please I have a fund donation for you for a charity project. and  the reason why i am giving you this fund $650,000 dollars is because of my health condition is very bad now and my doctor confirmed that my health cancer is getting bad every day by day. i was out from comma some few months which i have been taking my treatment. So i make up my mind to give you this fund because i did not have any person who will inherit this fund if i die.
I will give you more details once I hear from you.

I am writing from the hospital. I wait for your reply.
Thanks
Ms. Mary Josen
