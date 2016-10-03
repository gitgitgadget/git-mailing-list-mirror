Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_BLACK
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195E8207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 23:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbcJCXHv (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 19:07:51 -0400
Received: from know-smtprelay-omc-2.server.virginmedia.net ([80.0.253.66]:60281
        "EHLO know-smtprelay-omc-2.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751631AbcJCXHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 19:07:50 -0400
Received: from red.patthoyts.tk ([82.37.62.216])
        by know-smtprelay-2-imp with bizsmtp
        id rB7n1t00H4fw4HN01B7n9b; Tue, 04 Oct 2016 00:07:47 +0100
X-Originating-IP: [82.37.62.216]
X-Spam: 0
X-Authority: v=2.1 cv=XKnNMlVE c=1 sm=1 tr=0 a=y+L2qvWGb0b1Khfuzk0aNQ==:117
 a=y+L2qvWGb0b1Khfuzk0aNQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=xqWC_Br6kY4A:10 a=1oJP67jkp3AA:10 a=ZZnuYtJkoWoA:10
 a=CH0kA5CcgfcA:10 a=ybZZDoGAAAAA:8 a=FP58Ms26AAAA:8 a=NEAV23lmAAAA:8
 a=Rf460ibiAAAA:8 a=R2tq4aTG1kOhRna5okQA:9 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=6LVbBl2NLSWPyIBDCKCu:22 a=Bn2pgwyD2vrAyMmN8A2t:22
 a=-X4ai1wA6IXBCEr1GZS2:22
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2001:470:1f1d:26c::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by red.patthoyts.tk (Postfix) with ESMTPS id 651271960AB7;
        Tue,  4 Oct 2016 00:07:47 +0100 (BST)
From:   Pat Thoyts <patthoyts@users.sourceforge.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] git-gui: Update Japanese information
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-6-git-send-email-s.yasushima@gmail.com>
        <048AF5D4DC044BDC9F3A75A3BABD00F1@Yasushima>
        <xmqqk2enobol.fsf@gitster.mtv.corp.google.com>
        <87int9x1lp.fsf@red.patthoyts.tk>
        <xmqq60p98kym.fsf@gitster.mtv.corp.google.com>
        <xmqq7f9p6xh8.fsf@gitster.mtv.corp.google.com>
X-Face:  .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
Reply-to: patthoyts@users.sourceforge.net
X-Url:  http://www.patthoyts.tk/
Date:   Tue, 04 Oct 2016 00:07:47 +0100
In-Reply-To: <xmqq7f9p6xh8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 03 Oct 2016 12:31:15 -0700")
Message-ID: <87mvilt4jg.fsf@red.patthoyts.tk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>Junio C Hamano <gitster@pobox.com> writes:
>
>> Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>>
>>> I'm just starting to catch up once again. hopefully I can be
>>> a bit more reactive than recently. Merging 52285c83 looks fine. I'll
>>> stick that onto the 0.20.0 head and see what else I can pick up on top.
>>> There are a few from the git for windows set among others.
>>
>> Nice to hear from you again.  I think I have a few topics I merged
>> to my tree bypassing you in the meantime. Let me get back to you
>> with a list of topic tips to bring your tree in sync with what I
>> have later.
>
>I think the following lists everything that has been done bypassing
>your tree:
>
>66fe3e061a ("git-gui: l10n: add Portuguese translation", 2016-05-06)
>52285c8312 ("git-gui: update Japanese information", 2016-09-07)
>2afe6b733e ("git-gui: respect commit.gpgsign again", 2016-09-09)
>b5f325cb4a ("git-gui: stop using deprecated merge syntax", 2016-09-24)
>
>52285c8312 and 2afe6b733e are already in my 'master'; the other two
>are already cooking in 'next'.
>
>So if you fetch from me and merge the above, you'd be in sync with
>me (I won't be in sync with you, as you would have more than I have
>from other places like Git for Windows set).
>
>Thanks.
>

I've tried to merge in these branches as they appear in your version
although I already had one patch on top of 0.20.0 for some time. I've
tentatively pushed this up to http://github.com/patthoyts/git-gui as
branch 'pu' with additional stuff on top of the patches you already
have. If this looks ok to you I'll merge this to my master and send you
a merge request to get it all synchronized.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
