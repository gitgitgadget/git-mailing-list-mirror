Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F811F454
	for <e@80x24.org>; Fri,  1 Nov 2019 19:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfKAT33 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 1 Nov 2019 15:29:29 -0400
Received: from elephants.elehost.com ([216.66.27.132]:35113 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfKAT33 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 15:29:29 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id xA1JTOiq012979
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 1 Nov 2019 15:29:24 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
Cc:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
References: <011f01d58ab6$91fee620$b5fcb260$@nexbridge.com> <nycvar.QRO.7.76.6.1910281405000.46@tvgsbejvaqbjf.bet> <026401d58d9a$2bbe7600$833b6200$@nexbridge.com> <20191028145220.GU4348@szeder.dev> <027301d58da3$4a4996a0$dedcc3e0$@nexbridge.com> <20191029101615.GA24010@szeder.dev>
In-Reply-To: <20191029101615.GA24010@szeder.dev>
Subject: RE: [BUG] git 2.24.0-rc1 t0500 on NonStop in Jenkins
Date:   Fri, 1 Nov 2019 15:29:17 -0400
Message-ID: <026201d590ea$aa6b6690$ff4233b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHPNYlvTp8HvTWaccQRmuAfB7Lx7gHWySK8AblOW5QChv72xwFtCajbAl8qeNenNE9EAA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FYI: git 2.24.0-rc2 passes on the NonStop TNS/E platform - except for the usual t9001 and t9020 that never do and can't.

Thanks to everyone for all the hard work!
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



