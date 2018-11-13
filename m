Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8211B1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 23:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbeKNJEp (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 04:04:45 -0500
Received: from mout.perfora.net ([74.208.4.196]:48459 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731156AbeKNJEo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 04:04:44 -0500
Received: from ROGG752VY ([135.23.246.211]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LdFWZ-1febbO3uin-00iTiN for
 <git@vger.kernel.org>; Wed, 14 Nov 2018 00:04:20 +0100
From:   "_g e r r y _ _l o w r y _" 
        <gerry.lowry@abilitybusinesscomputerservices.com>
To:     <git@vger.kernel.org>
Subject: how often do you check in and with what tool(s)?
Date:   Tue, 13 Nov 2018 18:04:15 -0500
Message-ID: <5a1201d47ba5$34281790$9c7846b0$@abilitybusinesscomputerservices.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdR7pJWvHzv/jIt2SUadWzs+BxM0eA==
Content-Language: en-ca
X-Provags-ID: V03:K1:40dfE9XN0MexorgW5yEoXa54lSCwc9JcG8GeGSVhHcVrqVDc3rU
 vqcUBZkg8KwKs2OSA4OI1Wu+N3HN+NCpcEjJ8XrxvldOwNdgp3AkeIt1aGrlVEpenKZszx6
 k/qo5cEJ3kguZmDn8iM0F+ouQSA5Bzxl43noAWOvX4DvARN872rb6bqkFN2G3BfMrjcc2NZ
 B0DV07+TICyIM/+IWhxDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ncau/TkdBC8=:Int0sqlXEL4JUMBXlJ73B7
 KnnuUWfVPZ7r4q7Cwm+VRn4xR/w2ljfwOwSjNss2CJ99y7eN68b296FWNd49il3VCZcdHRdNr
 jhMGrXV6OzmOUJADqmNs9CTDEJW3ckhgZ8UEJ92VXJPdpjK6nwrYXJ/3XaF+5Ax2AHp+TNhDE
 I8Ab12mBCCHjtyNovi750OIMLn41A8gQXD796t4yYyT3RAJnOkw0oKp1QePXnyoYrtY15XP70
 rdST2NM4UtuUUnK2sPUhPIpyAYrvyrx7uUQnmva2a4YBvYNxTirzTr4Gzyh/mvEC16EzGqdzr
 WYXVsK8gp3U5KN+6UmZmaWjlyFyph7NSUvBLqWG0XD+lfbRTo8qi88ihDhBWyl4cn36lcBa8k
 S4Txs7D7mkG/qiKEV8zNlyB8IQG61HrKITAnC3aFkPjTuOZuNm/U1ynTkUXo62t7RrRzHJ/xl
 pvi9VYwDVgKW7N9ZQzGnwEhHZy3cE/DElUSytU8EsMgAVp90VhBIz4Z3vJiy2N1hISssjvVez
 td1Q+r3hPxkVi07Z7bv77LgIUG+f0kTh7cFud3B36WTPfQwRBZCVITga4FQ8O4N38gEqJayGJ
 ANPuKnwm8d3nbj9yS6cV/jxtr1Kaoebec/JJYBL20h0LXCf7XPXBAQcYTjCdSzqYU0g7j+83B
 eRwAKeVSVSFr1lwbyXFruWrudLWERGKxVoVlgYfhEjvXpW6RBP+p+v/PH+JeOJVVwmdmnapRA
 +5TvAex9EyVMC3i9jl4n5UONBQDg6BnD49icroWeHSaMxhTYm6VAXk6MprG+cB3V8cCmE40i8
 oAsWZi4dxExdBAQoVk2fdb5X90pI0TnjR89zs24ZmzRt9LBPS/EQACrmN36tEuRa8dIpBC+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, i use Git Bash and check in very frequently.

it appears there is a range from "extreme often" to "extreme very seldom".

Examples:

{me, extreme often, Windows}  very granular, with a brief yet appropriate comment [like narrating a story] per commit-i change a few
lines of code,
Alt+Tab to Git Bash, Git Add/Commit,
Alt+Tab back to some coding tool (example LINQPad).
[generally, i check in one source file before moving to the next source file]


{not me, very extreme seldom} in some project, not at all granular, in batches such as 50 of 75 files that have been modified, all
are checked in with a single detailed comment as to the overall purpose of the batched changes.


QUESTION:  how often do you check in and with what tool(s)?

Thank you.

gerry (lowry)
wasaga beach. ontario, canada
gerry.lowry@abilitybusinesscomputerservices.com

