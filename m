Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2C81FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753704AbdA3QDS (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 11:03:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:49669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753651AbdA3QDP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 11:03:15 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJjUO-1cX8TL03jI-001EG4; Mon, 30
 Jan 2017 17:01:59 +0100
Date:   Mon, 30 Jan 2017 17:01:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add SWAP macro
In-Reply-To: <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
Message-ID: <alpine.DEB.2.20.1701301643260.3469@virtualbox>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1215542427-1485792119=:3469"
X-Provags-ID: V03:K0:aEA1SQmQcz6OiAGcp8TXhHozALcaO+JmiiaokkcAhztL1fEVSV4
 pGzDLSzxzy5LRXGmJ24ouCArMVX8pNINCNyPZuzO2jbGLaStmjr70r2tjz/1MdqwcwjUUFU
 ggrgrGmjBN58qKD9xPhfvHTX5bK/ULZJkHW1CLE2b1R8ZjRt787pbwSVdaeX87eS8Rx2Xak
 8tz1YBV2RJ74I6IsXYZFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tgdPlPO8DJs=:5/ikLvdE3/RQtSTW7WYDda
 tlEGGigaIhGyzhPKOf5odMV0UPN2daJlzVODzRStjW7bf2W1+VCjsNmaKh/5LsPYqYqcGwWlS
 a0q2yfegPibEK+uTtjb10J32L0JsbTqcEcPkY15NMWEgvbVVHUG7S2LVLxx2ioPq8nBC6Tx3L
 CnFPklF4jI7ikvQv8vfx8AChTtHF4MTp8uUL//eCQWYwQBvdSHAk05iE7FRYe8fHfHO92r5Gt
 VAoBBs0lZEV6sE7NEJKf6PJuYIkz2+YIEhYBs84yaGXsQ5CE0vHkyCWCWKRtemgX956V8kXMG
 6XrFtc0xdWSsHHV445eFNQxQKZvBqLfY/H8yDxDzt2vh2UimyXR8C4Qaz6NbTwxAes+OKn6CA
 TmS7QmJn03XatY9c24tPAqhJWMeDZYnQwfF7TsZ1S4lmBHmKyqLxUoqpsIos3czDnNEYw85xU
 aPen+fclvkdFLG9A27boJ5nTxFEBmJaMNgBzWLjOi/KwJnYMG66jUN9xEIooMyfGdryZHeKPC
 Kuc5Zb87bNmiG9RumS+GKm87AQ4ysPBO6xY1PdpIXgv6n9raiX6wcqKhZeSOde9DeMzIpfsXR
 D1ZTFyApsFWQ5T89KdZQ1gCXwUo7pLB9YJgw4vPWVgSVzN1c6qNR64xKFtySyfT02EurldOij
 jBy1DELX9RRB/xMBfjYVfHSNyrUpDRTf3/V08iA8AHRsDB0NTcfpQERxsnIoA5GGvwKa8q6Dy
 UNjARNvnWzmYpVKBkqraGEBLNxYr7YjkWrm+pqqkfWc+OsenwpZKDj6JoyVf4P7Obb2bt9auY
 ZvxzFdC8ymOjGGcPph3hdx0XUQug/+ttqEz3CLEIw9zU75TIuVE14pyCcibmK1yBLzXv8XNe1
 TMUDXDXNGV02gVbSOSmf8dNzLTxtJfEUr7ds8vE4jN0BMFSRCj22+jqy5v5I8Wa28ZjAkIo6K
 Xd2C49Ezo3eYYygFn1ypbt5IRj8ivGMuwSFxrAzArg9WtiMZl9QJa+YyGC6bu4nUjBXYAGT0Y
 AMT7LPYQdtiY72RxuTGjV5heoDOHPa/PtmbLwblyJO0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1215542427-1485792119=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Sat, 28 Jan 2017, Ren=C3=A9 Scharfe wrote:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 87237b092b..66cd466eea 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -527,6 +527,16 @@ static inline int ends_with(const char *str, const c=
har *suffix)
>  =09return strip_suffix(str, suffix, &len);
>  }
> =20
> +#define SWAP(a, b) do {=09=09=09=09=09=09\
> +=09void *_swap_a_ptr =3D &(a);=09=09=09=09\
> +=09void *_swap_b_ptr =3D &(b);=09=09=09=09\
> +=09unsigned char _swap_buffer[sizeof(a)];=09=09=09\
> +=09memcpy(_swap_buffer, _swap_a_ptr, sizeof(a));=09=09\
> +=09memcpy(_swap_a_ptr, _swap_b_ptr, sizeof(a) +=09=09\
> +=09       BUILD_ASSERT_OR_ZERO(sizeof(a) =3D=3D sizeof(b)));=09\
> +=09memcpy(_swap_b_ptr, _swap_buffer, sizeof(a));=09=09\
> +} while (0)
> +
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)

It may seem as a matter of taste, or maybe not: I prefer this without the
_swap_a_ptr (and I would also prefer not to use identifiers starting with
an underscore, as section 7.1.3 Reserved Identifiers of the C99 standard
says they are reserved):

+#define SWAP(a, b) do {=09=09=09=09=09=09\
+=09unsigned char swap_buffer_[sizeof(a)];=09=09=09\
+=09memcpy(swap_buffer_, &(a), sizeof(a));=09=09=09\
+=09memcpy(&(a), &(b), sizeof(a) +=09=09=09=09\
+=09       BUILD_ASSERT_OR_ZERO(sizeof(a) =3D=3D sizeof(b)));=09\
+=09memcpy(&(b), swap_buffer_, sizeof(a));=09=09=09\
+} while (0)

One idea to address the concern that not all C compilers people use to
build Git may optimize away those memcpy()s: we could also introduce a
SWAP_PRIMITIVE_TYPE (or SWAP2 or SIMPLE_SWAP or whatever) that accepts
only primitive types. But since __typeof__() is not portable...

Ciao,
Dscho
--8323329-1215542427-1485792119=:3469--
