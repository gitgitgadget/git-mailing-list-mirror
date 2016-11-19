Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB42E1FBB0
	for <e@80x24.org>; Sat, 19 Nov 2016 15:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbcKSPK5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Nov 2016 10:10:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:55038 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752975AbcKSPK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2016 10:10:57 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnOve-1cgufb1z70-00hb1Q; Sat, 19
 Nov 2016 16:10:53 +0100
Date:   Sat, 19 Nov 2016 16:10:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git-for-windows@googlegroups.com
cc:     git@vger.kernel.org
Subject: Prereleases of Git for Windows
Message-ID: <alpine.DEB.2.20.1611191605480.3746@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2JyvT8l+nr4QYUFjKknHhuBDhuOdjBEwBLqKRCz8qGCYFoycOf8
 7n7u3nH5bptyz+KbTnn2kSpv0UFWoyP07J3QfHX1bPMdU2TiLzwmePGKg/ANu2/YpBFRLq9
 aEyRpZg4Oz7CYlZZ0eWqhX/aKNAp/PoWEerwxjTBFuc1FpwTz/fPb9DCyf1S5rbFSlqad+x
 UUMjifvkn9SPgdfNOFTEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ezphooLtJlw=:7Hak2R9ExCI59/lyJUg1dg
 H3e/88zohvcGhFAwaNATR9LycCkTkcsdataK/lDMRjE1d7xUZW7pHgz7vcrDt25ggAOFfxU4s
 UqK6s1u987/+Th/EgUIhfXsNPOoXEoqJSkiAouNilIr7p/QYGWuFf+C/qna7anuVGjWo2Ptht
 YPCDbnKD3vPS2WUnZiMHUcspAbL16NnOq140HTBZTbh3KEyCiceNMjw/QccsGGZ+1VNZCdkCu
 2PAHb5U9fK9BEYR4uRz0SMDgnN02HAv9UL722UeCRSdIoiZNvHeDrU/u/OdJhbAwBghPB2IHR
 nR/v0wuFiBME3csrylN2n2+TTFmv0wDbi4RDWXMm4ODU4yhAb/q5epj/fXFG3JA2gdwR0asoO
 nLP9piNEpiD8RH5emNcqcwl6rgd9cJixOaTzbq4YeXKI9uOF58ivSkXSSzPg5ybiMsfpIaBOx
 RKK8SeSo8YlQ8dsIgxvjrvJ8p1Cjbtcvn+2YphP02iv9PygTwyW+71Tw3ReX2tmF2AOCLj554
 tcqIKPM3e/glbbv0q6RCyFBRxlIF/rKWZ+F9MxUdV0MeI2pwFn2nq5IpyRI38G0exQ8x1FKUG
 fUVJLTeHLNhXQSq7KohhAyd/n+MBoDcY2IuxLoh5JRLFPWH7W2lTUqZxZ/GeXiOLDENBU+po0
 LhMtNU2Dtdk9Ax3HZD2kNOnV+VHljn6eLUPBTFe3mrku/pY2Os4PflWMTvaydB1etbCVXXXNR
 F0eBR7TVI0hZ5iS3k1CBlT49riSCcuOqtMFuK6lIb61pt7bg2SR/QWl/F9wr2pXCRfJVUicLK
 2aTSf3Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I debated whether I should clutter the mailing list by announcing the
prereleases I published based on the v2.11.0-rc* releases of upstream Git.
I ended up deciding to announce that I won't announce them on the mailing
list, but only on Twitter [*1*]. After announcing the latest prerelease,
of course:

https://github.com/git-for-windows/git/releases/tag/v2.11.0-rc2.windows.1

Please give this a good beating and open tickets for issues you encounter
(unless you find that there are already open or closed tickets for the
same bug).

Thank you,
Johannes

Footnote: https://twitter.com/GitForWindows
