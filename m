Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C59209FD
	for <e@80x24.org>; Mon,  5 Jun 2017 11:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdFELsO (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 07:48:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:52627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751293AbdFELsN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 07:48:13 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9b4B-1dASl615LD-00CvJh; Mon, 05
 Jun 2017 13:48:07 +0200
Date:   Mon, 5 Jun 2017 13:47:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org, git-for-windows@googlegroups.com
cc:     Junio C Hamano <gitster@pobox.com>
Subject: Git for Windows v2.13.1 delayed, was Re: [ANNOUNCE] Git v2.13.1
In-Reply-To: <xmqqlgp7usvh.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706051316210.171564@virtualbox>
References: <xmqqlgp7usvh.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xS+JqwBSIbp5nuzmU4KjY16g/qU8EVhoVeA/pdyB30aTXMeDoOw
 CMAzRcROZM1Odx6Bnip5/xokIwdyQ4vB3Pyl2V8Wu+bk5GfEDIR9WP6qnr8v9scDGHs3tNk
 XDqc7xCDHmNLsv4ZWT1r2Dv6cHb+pcOmoev0DdKeHEb3D2djBWxy7jQoRC+BMGjcf9Hlcsb
 K8TERD2UXTGNNEd+gDLIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Sk8sLFkLZks=:4/bg+esIrOTTE4iH0f0sZV
 zZ70hTAD1WKouiXrPYAISemhw5yET445BwE5C0G9WGp8sm0ccneoaQsQ69pVFwVt9MlTG8cut
 h9BcHUu46p1hHySsiQejQE8Wg/P8HTX5jJPHZ/ANfkG/EcYMyDREfqsi3tm++3EL6DsG4stMa
 OOz4Bd6edxOErwh59W27TztxN9dfSY6gF5bgIgaqmYMbeI5BkeI98gHJSYrKhPTM4YWI7yTYB
 LYs4JFWsVHVIdztn/aqsOf6ImPnYw9bFqFeTqYTX4pBO4hARxcNApvAfoET7OPYfsw94S8PXC
 lWeysfyWwEzpjFzNVaE2ZNDfQDpwlNKs7C3V8LlcZIk0eaaoSqP2Pi8/vxmcLfc5CPD0NLVEJ
 eeA4SRABXc+ZblUdYbHl7ljwlXYHkGX+UH7LpPG5D5f3wO0IWprkEWTrp5h3DcTx5RfOociy8
 UCiWakNoRNcpOB0oMJz73pl9rVvi4ATazBpi7t8hBQ8EMfzlycW81UMlU09ZFK6aZ1dp6J/Fb
 ps4aNNEXmY8dzrRQjSzfVl8fu6q37lWeB9hG2YITFztXYALazDe6spWvL85zv0n6PHm5BW0Pl
 bPd/IkryIOOxIaam+AylGM9NeF+Yffc495H7fRHLKkJZ/yUtOD7X5vDk5Moh3hu71mjcp9pY+
 Xtpk8m1RPhTgQPCP3ouKsCHOjLayDnNpu2YnBpkeYfVhL6JZ3XA3WV8XD88Q8d/fmYXvgEMEc
 oL+CXnoYKZc+H4vQTTJeVTTdW6pkEmqRt6sOKzRz65RS97gwo4UQL1YfMrpWdyJ6nDOkLyRER
 42P+51H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

On Mon, 5 Jun 2017, Junio C Hamano wrote:

> The latest maintenance release Git v2.13.1 is now available at
> the usual places.

Due to unexpected problems in renewing my code-signing certificate, and
another set of unexpected obstacles in obtaining a new one, Git for
Windows v2.13.1 is being delayed.

In case you need any of the fixes that made it into v2.13.1, you have the
following options:

- Build a custom Git for Windows:

	https://github.com/git-for-windows/git/wiki/Making-an-installer

  Git for Windows' current master was just updated to be based on Git
  v2.13.1.

- Download a snapshot (with unsigned executables) from

	https://wingit.blob.core.windows.net/files/index.html

  The snapshots are built from Git for Windows `master` branch, meaning
  that it may take a little while before the snapshot for the current
  revision is available.

Sorry for the inconvenience,
Johannes
