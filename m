Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385761F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 08:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeJLPmP (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 11:42:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:38861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbeJLPmP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 11:42:15 -0400
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZTbR-1fwmzv2QjF-00LCqM; Fri, 12
 Oct 2018 10:10:58 +0200
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZTbR-1fwmzv2QjF-00LCqM; Fri, 12
 Oct 2018 10:10:58 +0200
Date:   Fri, 12 Oct 2018 10:10:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Era <aigner.erik@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Diff Range Underflow
In-Reply-To: <ED62D6B5-9227-4FC9-AB77-7DB4D3835501@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810121009060.45@tvgsbejvaqbjf.bet>
References: <ED62D6B5-9227-4FC9-AB77-7DB4D3835501@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1352393479-1539331859=:45"
X-Provags-ID: V03:K1:dJCTGj/tARYOYAedC5PARs59ajpI9NKfNOouIBpDfuplibDSUa+
 +8028ZSRxDu7UUhAfFDa1D5Yi6MoLHR1UGWsvP5hBYmH/EtXHnpGLJsW+0vPxT11AednEg8
 /9CSnjSWpHtIgC8neYPl8nNW9ejBySM424VIlXNM+ma6fMGGlR/QtOgzDiCx2xAeihT+i89
 +PyelLofReb5Vhqp7rByQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WtBFEeysM6w=:UrB00cGD/r+B+JflDjmgd0
 /bNkuKIgTH04wOQHI5XvRyDLCf4f7tWYMEtwxUWNUrt8s8RDXDGym2NdwmRiSBkJgOkOsNBcA
 elzLxAupSCQZFYtCxRJHnUgJwh7NkPi99upw4j4WQE2jie5lzhrD1zFAXop0WYGK1YfeuqmIf
 DKplzKZy/4cEVG+mKkDt+yC5huY6unXfMZhqJn/5+vVH8CQh7VEbmokIi0oPRxgWKA9goMnHv
 e53mmA4vpHJGSxmuTjaHmoz2gxPutFzyfRuiSHo3dbY4Ns1pzta979ZbzZZFq3X9hKBTMQqWU
 pno9Ja0AnZhY/HZqrkdOV2tsz9rS/Ny7aE+EBYRbt3RtytQfw0nI354aqkByNxYtramgbKSoC
 P5RNXrEa6P7rHr5bKHgPbUWeZRORTM4qGsB5BlKAmD/kihbqiYvxE2Dd5dd5GWiQTqwi34KH7
 gLeRYQAkEQMpnolePbU2YSXpC8fyCR9tpjnjMrf6XOiQU8w6YAxRVKzHWtMapdm1XmGOznth7
 VnmZaeErhbHZNb+kQ0vYoKbBkE5k5PHVvReVIUIXciEVMupVdmccBU1lytLVJ8EwN2F5+XG+g
 Y44FdhkQy9URFIhR+h8zRoe3vySk1Q9jC9qfrJnmFlPiIPPCFiYzm3Ci81EKyFAgVCMT29ZwB
 thImEayKiiTC3Si7z4I79zVoXLD1Y07wNtKScrUd1dLEv0fBKKzNZVU6PHtUpskytyuZ0BMTZ
 4Tavg6qIj+bLQttWN1gGJK+L1nft9SZuuqs2eGy/jetk6mg070J56nJU5kqhCWKQZQOtS4SAs
 n4AcMZNKuSiwPQ6LgCC0sbc9BnDV1ezUUDoA+/PB033dlyjAG0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1352393479-1539331859=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Era,

On Sun, 7 Oct 2018, Era wrote:

> I discovered an apparent underflow when using the —unified=0 / -U0 flag with git-show on a merge commit.
> Leaving the flag on its default value or 1 shows the ranges correctly.
> 
> 	$git --no-pager show -z --no-color --pretty=%x00%s%x00%b%x00 -U1 3ac9cfed9ce01836dea1fee96c4eceb2df4b6878
> 
> produces a diff with the following ranges
> 
> 	@@@ -582,2 -599,19 +582,1 @@@ extension TranslationContentViewControl
> 
> changing the flag to -U0 like so
> 
> 	git --no-pager show -z --no-color --pretty=%x00%s%x00%b%x00 -U0 3ac9cfed9ce01836dea1fee96c4eceb2df4b6878
> 
> results in the following ranges begin output
> 
> 	@@@ -583,0 -600,17 +583,18446744073709551615 @@@ extension TranslationContentViewControl
> 
> 
> Obviously this is some sort of underflow bug.
> Unfortunately I cant share the original repo or diff.

Happily, you can work on reproducing this with a public repository, or
even better: with two crafted files that can be compared via `git diff
--no-index ...` to trigger the bug, starting with the blob contents you
cannot share and editing them down to the minimal size, changing the
contents to no longer contain any sensitive information. Please do so.

Ciao,
Johannes

> 
> 
> Best regards,
> Erik
> 
> 
> 
> 
> 
> 
> 
--8323328-1352393479-1539331859=:45--
