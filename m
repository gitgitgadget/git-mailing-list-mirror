Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40E0202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 18:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbdKWSva (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 13:51:30 -0500
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:44978 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753195AbdKWSv3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2017 13:51:29 -0500
Received: from resomta-ch2-17v.sys.comcast.net ([69.252.207.113])
        by resqmta-ch2-11v.sys.comcast.net with ESMTP
        id Hwaue5GcpY0YRHwaue98Ql; Thu, 23 Nov 2017 18:51:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1511463088;
        bh=CGX8EGo/PqhQa2v+amd6iJJZySv/LkgKsiysm7DvYjI=;
        h=Received:Received:To:From:Subject:Message-ID:Date:MIME-Version:
         Content-Type;
        b=fyUTNcqq9OUGRD36//kRowvAFVIAJIDePKmCHo2JHRnNFbNG6M3vH0qO77EYrIWQS
         EAoI8CSKK5IO+rq5ws7YrvmJndaNxQx+jVhCxgWEhgoT+ndISJtIMUH1Tu31uZHzYM
         XwypbQXMEOOzWTea2Cwk0SWIpumYh/URtT8RdP1KVEVUgu6P/t9e2Y9rxi+wGWkA79
         5IRuoEoKLPALv1wTsZefSCdt16RO5SlFL+pZ1J5ctD8rv7TbfPuX70S8qhQjbv3ziY
         uhD9BIY8DNQMgXICRKjMWL5eTgN5zDzYrZMr93dZ3fbNPrCqfCBvevAwlFu1hmhdf5
         fk27vNLMRpUvA==
Received: from [192.168.1.100] ([73.149.212.147])
        by resomta-ch2-17v.sys.comcast.net with SMTP
        id HwateRKbFRomNHwaueZMas; Thu, 23 Nov 2017 18:51:28 +0000
To:     git@vger.kernel.org
From:   Phil Martel <pomartel@comcast.net>
Subject: Problem installing Git
Message-ID: <077942bb-5952-6f4a-8054-b17d3883b901@comcast.net>
Date:   Thu, 23 Nov 2017 13:51:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4wfJY1heTXwHR0xmEL/iokrL/YtVf+0MhiEgP65WaAmA3VSIJcORSRy0oXvxD5At/p5YNRoXjowc0nJimw44c2bUHuugrBQKalTq9xFCpiuWpsvEX5Ex25
 fu9jqYnxtG3dJNUqeNeXMbRE6BegmCxZ32itD/GG5kDAbHljzb8zIEZaUoaHlPJHpMK8Uepy1FL2tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm trying to install Git-2.15.0-64-bit.exe onto my Windows 10 machine.  
When I run this installer program no matter what options I try or 
whether I run as administrator it ends up with an error box saying "The 
drive or UNC share you selected does not exist or is not accessible. 
Please select another".  I do not see any way of selecting a drive.  Any 
suggestions?

Best wishes,

--Phil Martel

