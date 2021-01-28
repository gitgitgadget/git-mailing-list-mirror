Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_NAME_FM_MR_MRS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9205AC433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B2A64D92
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 15:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhA1PLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 10:11:37 -0500
Received: from pv50p00im-zteg10021301.me.com ([17.58.6.46]:34704 "EHLO
        pv50p00im-zteg10021301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232398AbhA1PLY (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Jan 2021 10:11:24 -0500
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 10:11:24 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1611846051;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=0g9T9h+7PDuUPjmf5B65iELuwbNSEe+saooXCexZmhKXwdP3J+nDoLFJSYXpxe0Ch
         nckCfHIkwE8SkZhWx/NE8aGcEm1a9b2oipzpqtkgvaBSiEJVRi1CnBkg4iGd5Ma++i
         nhsp3R5xwEII8DDJT8w2Ju79OtAFLWPeyKBrg+OdPQzbEVnqhvEeFqTM02Pg7yX15j
         l7Fd0p7bIbY4LxVxwLPvmKei5K8+wq9KVQHiBl5dnKrq280DbyVwtynS1J3PYohqya
         Q4GLbe1TuwvfFMev4V3TiiBeFZUr47S8u0GIB8T1j3VqJgf6cjRsL7xbOkWOxuu56Z
         0x7+rXRI0sQuA==
Received: from [192.168.0.119] (unknown [2.49.189.24])
        by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id A0B6DCC04BE
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 15:00:50 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   MR-SHaalan <m.shaalan123.com@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Thu, 28 Jan 2021 19:00:45 +0400
Subject: For code
Message-Id: <A1D065A9-78A9-45CB-A0B2-774F9E070805@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (16H22)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_11:2021-01-28,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=257 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101280077
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
