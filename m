Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7218C1F424
	for <e@80x24.org>; Fri,  6 Apr 2018 11:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeDFLVX (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 07:21:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:35027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbeDFLVW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 07:21:22 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCtLD-1fCQAh3zkZ-009dp9; Fri, 06
 Apr 2018 13:21:17 +0200
Date:   Fri, 6 Apr 2018 13:21:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Colorize some errors on stderr
In-Reply-To: <xmqqwozc68r2.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804061315500.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1518783709.git.johannes.schindelin@gmx.de> <xmqqwozc68r2.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qJX1uwCRu/RPjmVQiZQsEQG4f5bY9uUyk2fmgGUdz3tJEL48JPo
 C2J10EjBw7jr1YMtSZEufymMPK3yDb8I2ub/41hml21oT3RmOFYjwhf1srnfl4XF1HMGp3w
 R2C0YrOWwOazD4EBfiMUu0U6UQuQPlYbs4U94ZuW5zVcrzaZj09d7poOEMztd10gLadSgn6
 e9Dwey0NRcSf8wbs3ymjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KAsGKZgJgTQ=:7GmA4DXGRA+x+Z/93HGayE
 vlylnwynbd2Z/J2keyZg83IB63rRQZ1MWJYs2rG2mBHcirkk38uugpTc/3CvpSW8mYfshPOtQ
 4ouLgjH0J3RYljH5ZJIH6UHZ+kpafNtnqP9sSwrs1dlJkOJb8mh7kQY5FGf9p79oqq1HrS3oo
 6BMskzUp6jxKOZubt0hsMzzSxmGNueQCQKWpQHtdGk+KuM62M+9Jfsc2hnAnWktTUOFAmKTgP
 Wfxj5MGDXOQ9MtCehdI97mwXZ7HS3gBTluFlXJafKs1WW8FRoWq/W1PqF/zI1kZN/oJbd8zEr
 1OlF1CwMOHvDSVOIinFHKO8MHa0CXHsS2TcoP8ID76cTvbybKn2TSK/aLDwxRqxa0LnBW/qt5
 hTbVxr7/oFkO7sqi9c4wk4iRZIANrj2qH7XkNyn3pmyKAsHcXeJxB4UhiWv5tTlnnbSbVWGH2
 otYq+kDXLtv35J73OHny3Vk9msfVDwaLtReSrKOnwRcy8M1ctuMq8vDfNE8ya7kJ0+y+jaUp4
 cUvYeT8fRaXSR7Sgqbkgv4IxlhXyHz2MhEjXtnSnBforKoNHioR9X7alfiUIsOiGXUXEbyL73
 v2nfxm5SXF8LDLbkHheHgLj9LbmGLx9bkeuKcGdXiJ4b/6G3b2n7P3k9d5b00l+6F5Y8oZ2vI
 4g5IutAue2o5AnWMgsFodAFyM4iYfioNgpo7B8gzoRe7zJJZB7gdqDgE9QFG3cGfW5xFmXtdo
 Mqa+gHq0zWCQnuEPG41/Uy3tRzqmwhVIwXv/2DfJvlAlrjk69MJS2tRi7FASLjaeUe05TY8K9
 pgUQ3Nudvb/keL2uWNd28uJpukHe/L+0QlCEJ4ks1FlmR5/D202pwJqsY44DxquYnWX9tTY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

[and welcome back, at least I hope you only read this after a good and
relaxing vacation]

On Fri, 16 Feb 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Now, what would be possible solutions for this?
> >
> > - introduce `int fd` in `want_color()` (and callees) so that we can make
> >   a distinction whether we want to detect whether stdout or stderr is connected
> >   to a tty
> >
> > - introduce a separate `want_color_stderr()` (we still would need to decide
> >   whether we want a config setting for this)
> 
> Between the above two, there probably aren't so big a difference, but
> in order to avoid disrupting existing callers of want_color() while
> possibly sharing as much code between the old and new callers,
> perhaps:
> 
> 	extern int want_color_fd(int fd, int colorbool);
> 	#define want_color(colorbool) want_color_fd(1, (colorbool))
> 	#define want_color_stderr(colorbool) want_color_fd(2, (colorbool))

I made it so.

Note that I also had to change the check_auto_color() function, and while
want_color_fd() can have a "private" record of previous results,
check_auto_color() needs to use the global color_stdout_is_tty (so that
builtin/config.c can edit it, for use in `git config --colorbool <name>
[stdout-is-tty]`).

> We should honor configuration at two levels, just like the colors on
> stdout, i.e. color in which individual items are painted (e.g.
> color.diff.filename, color.advice.hint) and whether we use colors in
> UI at all (e.g. color.ui).

This is how v2 does it.

Thanks for your suggestions,
Dscho
