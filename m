Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59481F453
	for <e@80x24.org>; Fri, 26 Oct 2018 12:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeJZUqm (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 16:46:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:58787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeJZUqm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 16:46:42 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MP1PX-1gBuCj3d6V-006ND9; Fri, 26
 Oct 2018 14:09:46 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MP1PX-1gBuCj3d6V-006ND9; Fri, 26
 Oct 2018 14:09:46 +0200
Date:   Fri, 26 Oct 2018 14:09:52 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/mingw-http-ssl, was Re: What's cooking in git.git (Oct 2018, #05;
 Fri, 26)
In-Reply-To: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810261407030.4546@tvgsbejvaqbjf.bet>
References: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Cv+++Pqi1sl/kbPPv8236d8tb/mEq3Sa9htqjU9dSr5X2plSAOz
 lm0HuBuqavfKiZc75ZZkPlwzJHapbW/7Y3SQ4olEhlGyT/Wyo2GP69QJvitm4s9Bovltuf/
 vMv8s6TOOzSyrP/KabNK0UtqRXf6XbycBp1kn44qPnXAkwjBQjvAvA3hAS/h5XBg7xN/Wq0
 /oEB7sLM7mRz9lAjarcMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:23sxmxq8NUM=:I+JvlEoy8QxADdwtAVNIRL
 TzSck6uxyb3BITAnWfcGDyitsCl5Kt+pBcGo+A4gfldHS6L1L0hNlZyXhucfgyg26AlOK7puc
 fYbeiZMchGOaLtMKj0Dt4RIlsXd4CJeK2JkJg7lc9MTBRFrK09c/nyUSx5l5NuBk2AEbPPu6+
 p31NGX2M69vS7YIMC7b5Jm8ashnrFNIG6OQRN4dqvm4ZjRPcdcbw7BbrUsrBlZeKmHfTyOIR4
 G7sDo34Lspd25rw6hSB9Sk43BTOsIusVOP9+JntukoBAYVSslDMTtJl2G1xq5ZD0xwfXHiiY1
 qbmA6npOJ7IQqqQuzBBXxdGJMHgTysX6lkXH1gG49/c5sxEjSSWWLsTFTEs9lGe/Xt+RFLx0k
 0+vMjQc4f9Uhvg88BHvGseYTnaMvNJEwM/FZwz9KGpDHcF9xbdQz+/qtDEBSrgiVjrRJ+xm6z
 xOpkv6oyFn3ZPzC/VFggKk/1LYIgjZB+PDfQtAvuqK/dPZ2NVsOf64gNAwIThlj4GGj4A7TS5
 6p4fmOMrJY9sEhi7o3QNaShUe3auBUMr6i8Jb5bcHMX3vfBEFFiXhw3+RGqP7aufLqBKhHERb
 Hy14ZZc+KqlkjftP37lZYzgz9Alzg9xHxQH+4R3iwatF62pmp8vNdWqqKuYDpCXpn2KqAFpL3
 w9IjLc7WigFnb8dI+HKAmZ399hwy7Fyt39v4oD8sy7imgotDdtk2W7C/q/GzDS29BR0LR1XlN
 BR7T1i5ZlaKRdA4UtvIQUEEDMu5cGUwIt8bY/4I1KML42nOhpg9xAUmgOJNds0ZJ0i11iBecp
 ryno++1T12ri1/r/J84HjmiBiMUhPaDVZ2iYf6kkWG4qIUmG1s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 26 Oct 2018, Junio C Hamano wrote:

> * js/mingw-http-ssl (2018-10-26) 3 commits
>   (merged to 'next' on 2018-10-26 at 318e82e101)
>  + http: when using Secure Channel, ignore sslCAInfo by default
>  + http: add support for disabling SSL revocation checks in cURL
>  + http: add support for selecting SSL backends at runtime
>  (this branch is used by jc/http-curlver-warnings.)
> 
>  On Windows with recent enough cURL library, the configuration
>  variable http.sslBackend can be used to choose between OpenSSL and
>  Secure Channel at runtime as the SSL backend while talking over
>  the HTTPS protocol.

Just a quick clarification: the http.sslBackend feature is in no way
Windows-only.  Sure, it was championed there, and sure, we had the first
multi-ssl-capable libcurl, but this feature applies to all libcurl
versions that are built with multiple SSL/TLS backends.

The two patches on top are Windows-only, of course, as they really apply
only to the Secure Channel backend (which *is* Windows-only).

>  Will merge to 'master'.

Thanks,
Dscho
