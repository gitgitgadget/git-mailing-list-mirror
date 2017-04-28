Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6130B1FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 09:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035615AbdD1Jcb (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 05:32:31 -0400
Received: from hl157.dinaserver.com ([82.98.134.5]:56924 "EHLO
        hl157.dinaserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035606AbdD1JbW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 05:31:22 -0400
Received: from ES07113 (42.red-213-97-227.staticip.rima-tde.net [213.97.227.42])
        by hl157.dinaserver.com (Postfix) with ESMTPA id 9A8DF69350
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 11:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=esail.es; s=default;
        t=1493371876; bh=tDKtVH0hWdu/jVdCALHvjbzUUX9KtRQq2Iiag56AC/c=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=EzZrmTfW2ozygRS84kuce+RSI/qNIj7el4T0SvJSgHlfge+DJKu9m7wrMsNW4co3N
         XUDwQPZLdOt+ECtuaFgg4QC0aLxKqMlTxa4P6Py93jDvgtqbn7r17Cw4rGfkHnJ+yv
         TZtZHwQls8osN7FXjzc3f8KuVrk09mltTGVhnWEc=
From:   "Miguel Angel Soriano Morales" <miguelangel.soriano@esail.es>
To:     <git@vger.kernel.org>
Subject:  Git and Active directory ldap Authentication
Date:   Fri, 28 Apr 2017 11:31:07 +0200
Message-ID: <000e01d2c002$2dfa4650$89eed2f0$@esail.es>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdLAAiAanBRCaa+hSS+rRWt/yx+nyw==
Content-Language: es
X-DinaScanner-Information: DinaScanner. Filtro anti-Spam y anti-Virus
X-DinaScanner-ID: 9A8DF69350.723AD
X-DinaScanner: Este E-Mail no ha sido analizado.
X-DinaScanner-SpamCheck: 
X-DinaScanner-From: miguelangel.soriano@esail.es
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for my English and Thanks for assisting me. I would like use git in my
Company. We use Active directory for everything, but I prefer install git in
centos7. I Would like authenticate all my user in Git through Active
Directory. And Every Project had ACL permissions .It this posible? Can you
help me?

Thanks a lot and good weekend




