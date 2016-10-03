Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEE8220986
	for <e@80x24.org>; Mon,  3 Oct 2016 08:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbcJCIp0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 04:45:26 -0400
Received: from know-smtprelay-omc-2.server.virginmedia.net ([80.0.253.66]:45795
        "EHLO know-smtprelay-omc-2.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbcJCIpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 04:45:25 -0400
Received: from red.patthoyts.tk ([82.37.62.216])
        by know-smtprelay-2-imp with bizsmtp
        id qwlN1t0104fw4HN01wlN4r; Mon, 03 Oct 2016 09:45:23 +0100
X-Originating-IP: [82.37.62.216]
X-Spam: 0
X-Authority: v=2.1 cv=XKnNMlVE c=1 sm=1 tr=0 a=y+L2qvWGb0b1Khfuzk0aNQ==:117
 a=y+L2qvWGb0b1Khfuzk0aNQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=xqWC_Br6kY4A:10 a=1oJP67jkp3AA:10 a=ZZnuYtJkoWoA:10
 a=CH0kA5CcgfcA:10 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=Rf460ibiAAAA:8 a=haI8qLXqc884PJVu8iQA:9 a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=6kGIvZw6iX1k4Y-7sg4_:22
 a=AjGcO6oz07-iQ99wixmX:22 a=-X4ai1wA6IXBCEr1GZS2:22
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2001:470:1f1d:26c::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by red.patthoyts.tk (Postfix) with ESMTPS id 985B7196F175;
        Mon,  3 Oct 2016 09:45:22 +0100 (BST)
From:   Pat Thoyts <patthoyts@users.sourceforge.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Satoshi Yasushima" <s.yasushima@gmail.com>, <git@vger.kernel.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 6/6] git-gui: Update Japanese information
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-6-git-send-email-s.yasushima@gmail.com>
        <048AF5D4DC044BDC9F3A75A3BABD00F1@Yasushima>
        <xmqqk2enobol.fsf@gitster.mtv.corp.google.com>
X-Face:  .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
Reply-to: patthoyts@users.sourceforge.net
X-Url:  http://www.patthoyts.tk/
Date:   Mon, 03 Oct 2016 09:45:22 +0100
In-Reply-To: <xmqqk2enobol.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 07 Sep 2016 10:35:22 -0700")
Message-ID: <87int9x1lp.fsf@red.patthoyts.tk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>"Satoshi Yasushima" <s.yasushima@gmail.com> writes:
>
>> There seems to be a cause in the following taboo.
>> Sure, PATCH 3/6 is little too great.
>> http://vger.kernel.org/majordomo-info.html#taboo
>>  >Taboo things to be done when discussing at VGER lists
>>   : (abbr.)
>>  > * Message size exceeding 100 000 characters causes blocking.
>>
>> To somehow.
>
>Since I received the patch directly bypassing vger, I queued it on
>gitgui-0.20.0 from Pat and tentatively merged it to my 'pu'.
>
>Pat, we haven't heard from you for a long time.  How would you want
>to proceed?  If you fetch from me and merge 52285c83 ("git-gui:
>update Japanese information", 2016-09-07), you'd get these six
>commits for po/ja.po and then we'd be in sync next time I pull from
>you.
>
>That is, if that ever happens--is git-gui pretty much in deep
>maintenance mode without anything more to do from your point of
>view?
>
>Thanks.
>

I'm just starting to catch up once again. hopefully I can be
a bit more reactive than recently. Merging 52285c83 looks fine. I'll
stick that onto the 0.20.0 head and see what else I can pick up on top.
There are a few from the git for windows set among others.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
