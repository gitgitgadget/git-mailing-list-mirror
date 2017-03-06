Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFF86202D7
	for <e@80x24.org>; Mon,  6 Mar 2017 05:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbdCFFeE (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 00:34:04 -0500
Received: from mout.web.de ([212.227.15.3]:54393 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752789AbdCFFd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 00:33:26 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LsyBm-1cIU0W0VlC-012Xdv; Mon, 06
 Mar 2017 06:33:22 +0100
Subject: Re: Git download
To:     Cory Kilpatrick <haeltotoe@gmail.com>, git@vger.kernel.org
References: <6BB71432-FB8F-458B-A1FF-EBF93565E6D8@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <f59daa22-311e-403a-a5f8-7a2a4ed92dcd@web.de>
Date:   Mon, 6 Mar 2017 06:33:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <6BB71432-FB8F-458B-A1FF-EBF93565E6D8@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:OjnyVjISPzHkRcWr8BHB0l9qOx4nIyhPomVimYdvYRsExjB63oc
 8LwFS/Gm0rjkTP8GUyb4lslnkbUzPs/f5EvpEJ3bScaYXJW2nJ899UfJ5qgjFJguTRo7KQy
 Jqs6YtTUS9x1N2Na8JvtApfsEVF5EBOtSAlXb/wfEwhrQIvMt6TXBSp4RWU4KLuituD2aQ/
 s6rRGaaVr6vlze+tDk6uQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1H18+PemPKM=:f+d2y2KPh1sGrfP3tQkZ/N
 evSqK+2WSFvouLWg/oxJaCZgTuz1OPXnmu54J4qOhmRD4xlpgwHjasisb50Y81oKMsd1DemTR
 MAXMshIyW/V3++S1ZGnlWnON0DEG+Vae6IVT0y/5shkrYqeJnsiwVLBAEB/7YV/ipdgjLE3wG
 JiIw6AMf8hLRRNuzIlZs20GxuW+tD64Eutuu7G2V9qb0BV4Y0UJ6fHzriQvgQv4ThDyRdMJ0X
 kLtjTTir8Owc7W0FhV5WoCw4WaQTVBO2BC+vJi1kOTq90fJfPkJpbcGetZ2iYAA7Ki4K2mrFt
 97LaZmouHkD9OZtRgVGwGPUEFTqA0kiGybPv5ioH3rYvmeDIWPvuz/pCsBqhsN9n0rLB3mnjE
 KDfRqTrzvCv7P0Iy12oZ1TvFtUWQNVbecunVYhgaDKkpLq+Oki5BVBBvYW+9XoEQW6h8sPhSX
 4+HvSeLGTUXxvm9y9pk37ExqWCFt8SZlrxu0GLBI+ydnUlCD8It/arnl+PjS7o8dTkRNaSjKr
 2rJuNsrPuQELenJMqyY8VXzYnCFYXnvv63i1iuMdoIbPzp730XP8lwSlgheRyCKwPq9ydF9c5
 XdgjNfZ97fYYWj0eLgt8o4aR8BsDx1N8Cv1Iz055qmtmlalfy9+sKK+yP9DW4/+qvAilBf0Zh
 CcXKntY5O6/bP1Ot8Zom2/2o2uKIu7rUPZHB5077YQUClYpPLblryg1KbKpMLXMfphggDU+nb
 UJgeTsF+WPAFSaRCmM9PRF48aIp3S//co6r1TjEZbo+IhyghDeTeqXtf93mcUBj0x/FbLzSQF
 TqH6vZb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/05/2017 09:26 PM, Cory Kilpatrick wrote:
> I have downloaded Git and cannot find the application on my Mac. Should I try to download it again?

I don't think so.

It could be helpful if we can get some more information:

- Could you open the terminal application and type

  which git

git --version

and post the results here ?
It may be worth to mention that Git is a command line tool, so that you 
may not

see anything in the "Applications" folder.

