Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2DE41F453
	for <e@80x24.org>; Thu, 14 Feb 2019 21:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503300AbfBNVhB (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 16:37:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:32835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503285AbfBNVhA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 16:37:00 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyB6P-1h61kM1GeD-015YsX; Thu, 14
 Feb 2019 22:36:43 +0100
Date:   Thu, 14 Feb 2019 22:36:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        szeder.dev@gmail.com, 'Max Kirillov' <max@max630.net>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results)
In-Reply-To: <001501d4c476$a94651d0$fbd2f570$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.1902142234070.45@tvgsbejvaqbjf.bet>
References: <001501d4c476$a94651d0$fbd2f570$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PlyIcMORMciu6lBkWzk6LWzHTCvTw5qUJFlsQMfUPXHBtEHGyWJ
 Kz4xTg3xy2LeVo/tOZ70epvnVg6uFjviPkBDtlpJ4GdOW+1bIMcqOeTAdqYHeRUsDHoGzHp
 xQ4clwEtoN/I5BUy3X8eAg4lQ0JOVAMt3oIBetLVm1KXJoyW6g3oLt1rmJONX6Sc2/jN0Zn
 sOjdl1j2WF7aFtGu0nq+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3q9pTkY8tBA=:wvqSy3ZFH2YvVbn+7w7/0n
 b0ZrmzGLr5am2G4/UXcokBMua+4SiptLQAlRNsGUVQpL7MEJgDTWwefj0zq8bQH6YphkJ3h7Y
 VJ1n4sgd2zPBmjRDqFK6TjKrJ0yTECCcvuTaiMitMFgcm2NN+snIeq1mW94plGRQvZ+RqJCeI
 RbDbdk4SrG7f3yVcyAGJ2t+9srmpTSwTDut0uwo9wzGSSAkiIubywtDnZNNmox8so9F1j1i8W
 Sn60YTe/RqpZLQleeCj0Of4/vSpFhS4aFmkdVMjBeUKGnBokkXO/nrGdux+lpVVt8qaWDKU+O
 gsUhWCpGN+e/ZaYjlXESAAF+XldsCmfu7Q5+Y+yz0fkuy7w/OCRHfA7Ecg73YuKPMROc64Yod
 FjHHLzu8UAlI2y769+KR0YHl8qlefiuJ6OFzP9Jj369iZNUIqJvpxoGOJTTYVnd3Xt9Cb4I02
 NwrYU8B71VdpKlimgHlCkhJ9UwfNblYyJFOMD8iUZWhjgHyPVliZPgl5mtIgrMzj6h6LXlwlO
 wp6IaXcCH5Og3q4f0nVBsyV/4g4mXO51Ugzow4AtFVuV8gq5e+DIe855qq+XMvSWV8QvxXVv/
 U6Gh0AgnzOBsGjz6fvUTbJKXCoDB2gaTDMEtLy5eC52EBZi68NNW2R8uZ0Ai4M/liHbocomxv
 PegAfL8kZQqg3pIMRVEslzsPSruTKwqGMY0pr2ARc33smvO0o2xyN+molXIMFsT5C83VacDBR
 XUyVzqRdebsQ847RD78Fk7vpEqKO1xwr23JZ0GvV8i7m4T8nKQ896N1yTiru8rWdPG16aWVfG
 jMFt9Chc2+hCQIJxQUW/F3dkZqufo7b2qx13Jh+VXCyRBMws/VMapDDurfMS1DioT9wkUqaoi
 BXOJ51rvjvUKxIZaL8V//0HjnkWYOTI6hVhAiUEYJ1G19vU7JKXUdnVdR+QVXRouMiy29s8L7
 kPDQGxztrHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Thu, 14 Feb 2019, Randall S. Becker wrote:

> t5562 still hangs (blocking) - this breaks our CI pipeline since the
> test hangs and we have no explanation of whether the hang is in git or
> the tests.

I have "good" news: it now also hangs on Ubuntu 16.04 in Azure Pipelines'
Linux agents.

There is a silver lining with those good news, though: I found a
workaround, and it might work for you, too:

	https://github.com/gitgitgadget/git/pull/126

(I also submitted this to the Git mailing list, as I really wanted to tag
Git for Windows' v2.21.0-rc1.windows.1 only with a passing build, and I do
not want to keep that patch to the Windows port only.)

Ciao,
Johannes
