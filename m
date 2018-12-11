Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,EMPTY_MESSAGE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MISSING_SUBJECT,PI_EMPTY_SUBJ,PYZOR_CHECK,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A78E120A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 06:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeLKG5u (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 01:57:50 -0500
Received: from mail.ges.sh ([217.182.72.128]:35054 "EHLO mail.ges.sh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbeLKG5u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 01:57:50 -0500
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2018 01:57:50 EST
Received: from d2r3.idesign.lan (unknown [81.190.40.214])
        by mail.ges.sh (Postfix) with ESMTPSA id E1E791FA55
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 07:49:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=idesign.center;
        s=default; t=1544510976;
        bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
        h=To:From:Date:From;
        b=s4lUFekbqKOya9gOcUZ3c1suC5DVwkqtDmzpwAc2L+9qnIFr5IQRqssWDS4lm/U3J
         J5epRlXG6F16s+mfx/E9HuunkDKiy2SBBctB5TqcRj/vgQnhCCt3IfzDgj0enuUFcp
         U1Sxu3V8sboI5k6D5FdwpD/jBo1kpiX1Jb0f6HQeG9E7o1EcLWFL5hoRvmcQiIZPBA
         aiTDVd9EFFnLuOO6blX+BUZ7sloGqp/5zBepFLoqCTVdDeSAxsep8RbAUzd4tZlE8y
         vyWQsbcpa5ihR/VK0EjfHPcRsWDjjEcdZgGipAIg9LU63KLuE2SmWc+WezLdLbTmZr
         M3+n2fdWMx/dg==
To:     git@vger.kernel.org
From:   =?UTF-8?Q?=c5=81ukasz_Opasiak?= <lo@idesign.center>
Message-ID: <4db735aa-d476-9ff5-58f0-b6464a3d30cc@idesign.center>
Date:   Tue, 11 Dec 2018 07:49:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


