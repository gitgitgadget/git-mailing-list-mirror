Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F27E91FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932195AbeARVDa convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 18 Jan 2018 16:03:30 -0500
Received: from elephants.elehost.com ([216.66.27.132]:52804 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbeARVD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:03:29 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0IL3ReK031028
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Jan 2018 16:03:27 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     =?UTF-8?B?J9CQ0LvQtdC60YHQsNC90LTRgCDQkdGD0LvQsNC10LIn?= 
        <aleks.bulaev@gmail.com>, <git@vger.kernel.org>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
In-Reply-To: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
Subject: RE: git 2.16.0 segfaults on clone of specific repo
Date:   Thu, 18 Jan 2018 16:03:21 -0500
Message-ID: <009401d3909f$ca040fe0$5e0c2fa0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIqZQ4r/LzJm8pBdd3mqqccac8im6LMdEzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 18, 2018 3:56 PM, Aleks wrote:
> I found that git 2.16.0 segfaults on clone of vim-colorschemes repo.
<snip>

Just tested on NonStop NSE and works fine here. Just an FYI now that we're on 2.16.0.

Cheers,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



