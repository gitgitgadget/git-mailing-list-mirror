Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA781F516
	for <e@80x24.org>; Tue, 26 Jun 2018 22:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeFZWJt (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 18:09:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:59175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932107AbeFZWJs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 18:09:48 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McmS9-1fpsXu2iNF-00Hwn6; Wed, 27
 Jun 2018 00:09:43 +0200
Date:   Wed, 27 Jun 2018 00:09:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org, joel@teichroeb.net, gitster@pobox.com
Subject: Re: [PATCH v6 4/4] stash: renamed test cases to be more
 descriptive
In-Reply-To: <0f49fc90bee5e6a297c49224f1451a7aee4c8635.1529943789.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806270008440.21419@tvgsbejvaqbjf.bet>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com> <0f49fc90bee5e6a297c49224f1451a7aee4c8635.1529943789.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Tk1DTIRByAQbsTxbIc22ONM4OlVWECNSghRD3WJQXJcu0fIVtNe
 oSdZuBfEQ5nUoztpfN7UoE3g1f9pI7fyObpASZ2/uD+inXd0uw/06oWdZ/GxKdYy/vUV1QG
 vhb4CNKF4ohs2S6zCL2bvli4jxXoTmbrjsJcGBmELMdvdoq+Gvfrm6nCn0Pd/PEqU5HQrVY
 +H++f2bxgfUzJgKhr3GJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lgMH7PstKuE=:9wHuac3MJfvvITCtWfUuE5
 UyMV3P3/gG02gX3xCtrm7Pa0nlwPh6IdOwn7JIIZm9vH1f7dps1xx5EAzV65PWFrNgxtttEsA
 xKUZVzoLZGzE0Yugg6+sK35KivUg9nquJZ29trkrA8jsKKuNPGTOjSzaJC66H0bQnPMlYnNZ5
 sum7aOkAsVrqDOc8F7mnemDAApd4l4WW+6qX+bHGnukSk//5FWD8AMD2c5SfR5Z5xmjqygHdE
 gCiYP1SOLePK/IAUVUQecPPBgrFEKuoNsDU0i8OvFvSB2PuUq9zDNuikGVj3hbb3xtxdbd2pW
 cXnjyrnWQd5OKOZZt4V/eG1uAMuUya/WszQxZSdyrI+MERdjEYEe+xhj9x1QY8j10+/nThgf8
 938zNNc5O8Z3zlE2OxQlVjHJilQH+57tOsOqdVai4ls6W7kLmAalvVItjF0s6Iw7xIvFMAziP
 xsCKtxrivCMDnxUvTm6J+7ebAHtEUTTSJHbLMvuvjYQKVO+PePxc1eXwjDEH3S15BZZp63RcS
 Rxa+Jg9NTkoIR/FyPY4edPHpVqHyAAxN3Gm3j8hU7u+J3eky7WhGcb3ihsr3tvUHZXLlWiycb
 RkjSSb4sEAnuM75NiMr3FEdxLFxwW480rAllCfIRYC7U+ncRX5G1miViPsHmjpRW8PV8wbMbK
 YF7e7WilKlTWhzVHiw/FIRO5BCF5AqsjTJ1QAAJKClw299W6YnInKzzCXstcSdNxk6d90k0h5
 L5eB13RLbYDQRGbXqfaSzMNLsOy9g2WLeGmmmy5/JtibZ2dZ6B+lybkU1+tjg0ld4WcnOWP6H
 gFHeoOL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Mon, 25 Jun 2018, Paul-Sebastian Ungureanu wrote:

> Renamed some test cases' labels to be more descriptive and under 80
> characters per line.
> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

As I suggested this kind of change, I am obviously happy with this patch.

Apart from minor suggestions, I think this patch series is good to go.

Thank you!
Dscho
