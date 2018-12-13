Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA3FD20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 13:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeLMNxF (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 08:53:05 -0500
Received: from mout.gmx.net ([212.227.17.20]:34079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbeLMNxF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 08:53:05 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzbXq-1hS8re0nsQ-014oSX; Thu, 13
 Dec 2018 14:53:00 +0100
Date:   Thu, 13 Dec 2018 14:52:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Fix regression in t9902 with NO_PERL
In-Reply-To: <20181213132707.GX30222@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1812131452020.43@tvgsbejvaqbjf.bet>
References: <pull.99.git.gitgitgadget@gmail.com> <20181213132707.GX30222@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1350468521-1544709180=:43"
X-Provags-ID: V03:K1:qZ31RgF6t5oFsPBH9rBhq+2zatmP0oUFZU5KRp+IKpnUDFZ783A
 osBKjMDd1f1sk+J3BMufE8Sw9nmZlt7ESGaC6Sc3NJa5Kz6vjEN2dfEfa9PRunAVdWyoTn0
 jmvunN3b6OBiOYk6e/rS++mq+oLYoP+FE7RMlxP2STlyvNZSMQcjf2ETUYvFMslTWxjkoq4
 HnWyc6HMIokbN1kfP4v1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tdETlppJrkM=:oFxbGtcQYX2beim3u4xO1I
 eFX6y/ewwuFiforxKm3Qv0GTtWzYwDAVHAQY69Bu9VRd40ln6BsS+o3ymvI4+s90ET5Eckwqr
 69M7MnnhoWqFjl/x8m6kC3Ks4TtulmYqUAusKVreOoFE6Gs/HANRTcgmiPjW8A3b9FGxMNSEq
 iPdpWSUClKMLgnq7a5qrGqfZvEkxmoKmeT3XYgz47L30DWsrhGZ8wdqRZ9LT9pwv5PKZ67c+G
 kEQFH0mnu5RG8VEYl/lsgCiE9+20IYl7hN9BOLRbaAzflV4ch9aGENrzqGNYYesHigVgeVdMA
 qi0lJ5cEIK2mEBGUKczLlASsPX0ZdNq44ic9WmEXlDjAeTz/HZxukUFwCG6FWXzi+7K33DXmT
 EwpvCxwzSYYv4SExH+rMXz03Na+41KlU2ZkOxdkRUht5kMRCwgLch0KSEddPfjSU7fihYbwTm
 XuLd0v4T+jWXuQ90Ada/Rj8k+WzvuBDvfFEJXMJIrjH64J7wmGJkPqICfYLdastvSe7AN7bcN
 1wbf7OxCN2HIpaxcBjotM+e99X3sk/hMnNKj1QSgWX1JHLkIk/eWdlBqr9ZBsSvgPnvNjEiKr
 ZsYthqspbkSwaXryeUlx0IM+2XccafAA8+k1Cv8luq8LRGWq8DhrFmQfD8gNIetd45yb7glnB
 9RU6xrjOj1c8FqTkRUOf+RXbGINBQD1zBIA4hvVsFa8u1rHNuK6HcZgIeBUu/xgPBmCzRGgYa
 4MAEizihZK7u0fxBCLMufo27Md6BbqMYzeMco2iAl7uFdgK44ybEC0LiY5zp8wXuc8oqrhwBl
 WiAAM5/E1Jzt1S6vqpZpjobnKGSzDEt0zIaShPhOeS4MLdRtUq6bkY2zNjdPBFM56dHR9ysaF
 eC/YcBfxrKglFMqYBIY/ODXeU/ziLrZzuJ61hvlbkWV2+tLD6JhQ71fsY9drrX5eFDcOhK+ku
 LBTzCPCBQlw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1350468521-1544709180=:43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Thu, 13 Dec 2018, SZEDER Gábor wrote:

> On Thu, Dec 13, 2018 at 05:01:11AM -0800, Johannes Schindelin via GitGitGadget wrote:
> > The oneline notwithstanding,13374987dd (completion: use
> > _gitcompbuiltin for format-patch, 2018-11-03) changed also the way
> > send-email options are completed, by asking the git send-email command
> > itself what options it offers.
> > 
> > Necessarily, this must fail when built with NO_PERL because send-email
> > itself is a Perl script. Which means that we need the PERL
> > prerequisite for the send-email test case in t9902.
> 
> I find this text in the cover letter to be a better commit message than
> the text in the patch itself, because mentions when it broke and clearly
> mentions why it broke.

Okay, I replaced the commit message.

Ciao,
Dscho

> 
> > Johannes Schindelin (1):
> >   t9902: 'send-email' test case requires PERL
> > 
> >  t/t9902-completion.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > 
> > base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
> > Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-99%2Fdscho%2Ft9902-no-perl-fix-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-99/dscho/t9902-no-perl-fix-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/99
> > -- 
> > gitgitgadget
> 
--8323328-1350468521-1544709180=:43--
