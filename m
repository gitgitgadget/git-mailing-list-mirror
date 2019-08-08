Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9464B1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 21:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390230AbfHHVTf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 17:19:35 -0400
Received: from rchemail.bankofamerica.com ([171.159.227.167]:52336 "EHLO
        bankofamerica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729780AbfHHVTf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 17:19:35 -0400
Received: from vadmzmailmx05.bankofamerica.com ([171.182.203.230])
        by lrcha0n0xepmx04.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x78LJXHb024742;
        Thu, 8 Aug 2019 21:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bofa.com;
        s=corp1903; t=1565299173;
        bh=/R5Nnmp+scHsK2KoRvmovXD/whOZurKdwT+CIrVoo98=;
        h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
         Content-type:Content-transfer-encoding:References;
        b=ldY+y6gJJ/a8lZpyDRKlyv1R3zRXnh7d7py84aogcXOxMEBiWoZ/1yrm+rQlgOzq3
         RWygszzFIvZpERtjgBWlCc2V90qQDBr5ksqAFeYcOVplgTR/gaRF9d53MeD5Xu03eZ
         sFBKhr0Ow3zB7HpINSy1E3doLvKwbr9reWvutQ/c=
Received: from lrcha0n6xepmx13.bankofamerica.com (lrcha0n6xepmx13.bankofamerica.com [171.205.12.14])
        by vadmzmailmx05.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x78LJQJ2001663;
        Thu, 8 Aug 2019 21:19:33 GMT
Date:   Thu, 08 Aug 2019 21:19:30 +0000
From:   "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Subject: RE: suggestion for improved docs on autocrlf
In-reply-to: <20190808205631.e2647kxq74thotjb@tb-raspi4>
X-Originating-IP: [30.245.13.45]
To:     =?iso-8859-1?Q?=27Torsten_B=F6gershausen=27?= <tboegi@web.de>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Message-id: <3269668c03a8482d8d854ec19dd43907@bofa.com>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Content-language: en-US
Content-transfer-encoding: 7BIT
X-MS-Has-Attach: 
Accept-Language: en-US
Thread-topic: suggestion for improved docs on autocrlf
Thread-index: AdVNISlxEEknYFEsRQ6Yj1wK7ruvjABLB7eAAAekNtA=
X-MS-TNEF-Correlator: 
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com> <20190808205631.e2647kxq74thotjb@tb-raspi4>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_08:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yes, do I read this as "I will send a patch" ?
Probably not, but you can read it as "I will cook up better wording and reply to this thread"

----------------------------------------------------------------------
This message, and any attachments, is for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at http://www.bankofamerica.com/emaildisclaimer.   If you are not the intended recipient, please delete this message.
