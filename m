Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247471F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 21:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbdFEVTe (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 17:19:34 -0400
Received: from secure.winserver.com ([76.245.57.69]:61797 "EHLO
        mail.catinthebox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdFEVTd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 17:19:33 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jun 2017 17:19:33 EDT
DKIM-Signature: v=1; d=winserver.com; s=tms1; a=rsa-sha1;
        c=simple/relaxed; t=1496697240; h=Received:Received:Message-ID:
        Date:From:Organization:To:Subject:List-ID; bh=jrfrOn0nwIwJFX1nIw
        uaNYNeyc0=; b=ZazDEd4N+XQhh01VzptczAoI5bqQ3p5R5jG5PNTjLLe2IwaFbS
        hFAgbYJhaGE/Dx1otpTYRjys49MEbFIcPPDXBQNvGc+kyFP5MPHR/6V0mTOVQBbZ
        YEZ8eMnLBY/1dBAxUAYx5kDJsWSCFAR7rzcHJf0q8qLvQguGXdCGA3dB8=
Received: by winserver.com (Wildcat! SMTP Router v7.0.454.5)
          for git@vger.kernel.org; Mon, 05 Jun 2017 17:14:00 -0400
Received: from [192.168.1.68] ([99.121.5.8])
          by winserver.com (Wildcat! SMTP v7.0.454.5) with ESMTP
          id 1056134341.1.5080; Mon, 05 Jun 2017 17:13:59 -0400
Message-ID: <5935C999.5060801@winserver.com>
Date:   Mon, 05 Jun 2017 17:14:01 -0400
From:   Hector Santos <winserver.support@winserver.com>
Organization: Santronics Software, Inc
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.8.1
MIME-Version: 1.0
To:     git@vger.kernel.org
Subject: Git "Keeping Original Dates"
Content-Type: multipart/mixed;
 boundary="------------040809070408000606060201"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------040809070408000606060201
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm implementing GIT.  If there an option or compile/version that 
"keep" file timestamps?

-- 
Hector, Engineering & Technical Support
Santronics Software, Inc.
http://www.santronics.com (sales)
http://www.winserver.com (support)
http://www.winserver.com/AupInfo (Online AUP Help)
Office: 305-248-3204


--------------040809070408000606060201
Content-Type: text/x-vcard; charset=utf-8;
 name="winserver_support.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="winserver_support.vcf"

YmVnaW46dmNhcmQNCmZuOkhlY3RvciBTYW50b3MNCm46U2FudG9zO0hlY3Rvcg0KZW1haWw7
aW50ZXJuZXQ6d2luc2VydmVyLnN1cHBvcnRAd2luc2VydmVyLmNvbQ0KdGVsO3dvcms6MzA1
LTI0OC0zMjA0DQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------040809070408000606060201--

