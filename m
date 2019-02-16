Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PYZOR_CHECK,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75A7C1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfBPLMT (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:12:19 -0500
Received: from st43p00im-zteg10071901.me.com ([17.58.63.169]:38914 "EHLO
        st43p00im-zteg10071901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbfBPLMT (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Feb 2019 06:12:19 -0500
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Feb 2019 06:12:19 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=04042017; t=1550314962;
        bh=gORcQ5eR+p0+qNP4l53yvket3NwncOkPtSbaOdqaovo=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=tWHCpDF+UihV2sIPijhEnVOSQnEFcKkI0PlZOBSqYqNlJ+0+rEu5d68GdrqJC1qLy
         xrXuHKLjhnMD/C4xIQ6GKyilU0ezI8BvpPrRVEb9rc+13STpnelkB1Ps8NDXU5ayZI
         tRYFUTNGW/EWwRPIbsWHgG+84qrv3PLd/I532OcYfRdI/4Hs42lpF2MTBMBFoxhWy6
         TfNgxzy5YBgZ8wDUm3ftHux0JnBjJe8ZcY1f3MlpMORrPCdcnH4uC3aM0NoqBAlJVt
         fgy7vmAbeROGDgvgxZ6yi8s14ewv178+zyzauzUEbZdGXKVyJEroqBXVXfUo/Qph/Z
         15lfgUrgyFHjg==
Received: from [192.168.1.243] (104-56-191-14.lightspeed.milwwi.sbcglobal.net [104.56.191.14])
        by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id 3D586D80A0F
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 11:02:42 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Rick kolinski <regnerpark2015@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 16 Feb 2019 05:02:41 -0600
Subject: Debug.protocol
Message-Id: <3126221B-73C4-41D3-99C0-E3DBA9BA6889@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPad Mail (16C50)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-16_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=321 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1812120000 definitions=main-1902160084
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPad
