Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFB0C2BA16
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 05:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1294A206F7
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 05:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="FvHcZwR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDGFGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:06:23 -0400
Received: from pv50p00im-ztdg10021801.me.com ([17.58.6.56]:52403 "EHLO
        pv50p00im-ztdg10021801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgDGFGX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Apr 2020 01:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1586235982; bh=ruW4UFXxVsMKbdPMnmxDaTv+16pA7U93ISteQk0ZEwg=;
        h=To:From:Subject:Message-ID:Date:Content-Type;
        b=FvHcZwR+d596bdsnJH3JulZ2YKPzl5CqdwHfkcj0GhEWeYomj8B6xEVcz1ylEnUdG
         zT2/epCrA6XOqJYo2iNmAZoi5328OaXIQrWLt94MoVmTN+O6iTCHrf3euS+quhnQ7a
         Fnm0NjVU9RC9N3f39jErE5JfpZcd80M+FYBOTP8tviYxY2oW+ivHmXWr+YIWuZ26og
         MqsjEvkAVHAgFmvVRSoy2RQFrTWbedC2KwwC2kEJUHUgOys7OTs8WpZP/to8uvkBlC
         ljNxcL684mneNtwQZB92ItJFvy4XF0IYjliA8yCJ4AC3EcuIeZhJuKJedJFryF39EW
         EIL3DW5JhePtw==
Received: from [10.0.0.7] (unknown [110.7.217.176])
        by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 189BC3605FD
        for <git@vger.kernel.org>; Tue,  7 Apr 2020 05:06:21 +0000 (UTC)
To:     git@vger.kernel.org
From:   number201724 <number201724@me.com>
Subject: help
Message-ID: <c638c240-d87d-44bf-c7b0-071e169cefa9@me.com>
Date:   Tue, 7 Apr 2020 13:06:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-04-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=1 clxscore=1015 mlxscore=1
 mlxlogscore=198 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2004070042
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

help

