Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AAC92095E
	for <e@80x24.org>; Sat, 25 Mar 2017 19:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdCYTlu (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 15:41:50 -0400
Received: from mout.web.de ([212.227.17.11]:56152 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751503AbdCYTlu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 15:41:50 -0400
Received: from [192.168.209.18] ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MMmx9-1coJ3l0sHf-008afS; Sat, 25
 Mar 2017 20:41:46 +0100
Subject: Re: t1503 broken ?
To:     Duy Nguyen <pclouds@gmail.com>
References: <fad6ea92-0a44-de30-48e8-09e7c567cd4d@web.de>
 <CACsJy8B1DWL9uHPZoQEO+ytkt1M+qV-x0F5CWFLFSG1utxO9EQ@mail.gmail.com>
 <CACsJy8CZdZuxpwbfB+TgHdH9YneeUxUhkF7XuLhWw6Lp9ZLPDQ@mail.gmail.com>
 <20170325130549.GA20618@ash>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <d2c587c4-18ca-a685-a53f-02106b1527ee@web.de>
Date:   Sat, 25 Mar 2017 20:41:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170325130549.GA20618@ash>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:7zhLFcrdmKR/kNMZpfslryGBZkilye6TYBinJ5JyB2S6bLqnR6p
 zwB64cl6/XDF2AK2ebPgqZuJ6bEK24hGg7EgyZvmcngicq6BTYXWSJDXXAtg36YfNyyvbtz
 Yamh9cymrV/UK5w0EwAJDd8wQZCU2aFKT83WR5BOTpM4xH/SQawli76BPTPZszO5ILs1g5Q
 5ggmd5rGKOajdDNB6al2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yv6v0w/BX7w=:H/ksGA7/9I00e79hd9edoH
 X3ulNy+jAKBQ2s8LB2Y6W8neFZvbnV/CU8NSUWhlRuO9FOfSaMkTZ+teJvsSh5ffs85GxCEyk
 FjsGarbwp2oug+Hj+Jbfapf77afY3XED/7ney3rFOznFgHzSClGUF+EuN+WlP4BZyuyihvaax
 DrMo2lKqA6AKoy1Yi8039MdfNzf8p2LZQVbZ5uwj3ZFRqRDG0WdLohu5WlWub4O1xTqTmFcet
 ptFWHh3jaesOr+fH5A5hMqXwwxo1pGiaT7lRSd9j1+WWV620+26nKwKSj9xjUCDCS7ADM1suq
 tUORpTzKnQBfwjN46ritEpZrRJ8AOcf7lZ6U3qufZK/8udrLZDqdrsHaR8XT9i3LRK5EesbFZ
 RvF405qQao3DCDzaLVSWTbGzw5HJQUGlD3pNQzLiQqdm+BW8mVYpt6R705gpfKhgOsbmrMIK8
 GShmUZIufmFx0p9cQfmxKR7zK/dgX8JcUIeD57re4j0A/7HgQFzcof9wh2q+fWujd2O2apXqL
 sGW6Yj5bJ+AJinOc6UsAjVTgHwownSsJ6pzqfrI96t2FrMW6q0N6VQhc3y4AtbnLuoqLyo8rg
 Tqp1omZShl3+XrBMMKNTw2besgRzYdHf/JLkAyERYqWqsAlC6PGXRBIDZMpuU7R86lCWcEFSZ
 yAQU2h+YjZTS3QCvAgC5NtLI+PJ63jXVa4C8Y4DoxZIAk7qrS0uaaf6tBKJvkd/+gvyuxrG9q
 AiivwRxNVXRAHIbNl0wmRCAQnbJaNW6WmEEAkWFVm8qrHWftOC6PbbIJfvltnWFPZB83cNuw8
 ah+S/0z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/25/2017 02:05 PM, Duy Nguyen wrote:
> On Sat, Mar 25, 2017 at 07:26:14PM +0700, Duy Nguyen wrote:
>> On Sat, Mar 25, 2017 at 6:46 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sat, Mar 25, 2017 at 5:46 PM, Torsten Bögershausen <tboegi@web.de> wrote:
>>>> ./t1305-config-include.sh
>>>> seems to be broken:
>>>> not ok 19 - conditional include, $HOME expansion
>>>> not ok 21 - conditional include, relative path
>>> let me guess, your "git" directory is in a symlink path?
>> Yes I could reproduce it when I put my "git" in a symlink. There's a
>> note in document about "Symlinks in `$GIT_DIR` are not resolved before
>> matching" but failing tests is not acceptable. I'll fix it.
> The fix may be something like this. The problem is $GIT_DIR has symlinks
> resolved, but we don't do the same for other paths in this code. As a
> result, matching paths fails.
>
> I'm a bit concerned about the change in expand_user_path() because I'm
> not quite sure if it's a completely safe change. But at least could
> you try the patch and see if it passe the tests on your machine too?
>
> -- 8< --
> diff --git a/config.c b/config.c
> index 1a4d855..fc4eae9 100644
> --- a/config.c
> +++ b/config.c
> @@ -191,7 +191,7 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
>   			return error(_("relative config include "
>   				       "conditionals must come from files"));
>   
> -		strbuf_add_absolute_path(&path, cf->path);
> +		strbuf_realpath(&path, cf->path, 1);
>   		slash = find_last_dir_sep(path.buf);
>   		if (!slash)
>   			die("BUG: how is this possible?");
> @@ -213,7 +213,7 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
>   	struct strbuf pattern = STRBUF_INIT;
>   	int ret = 0, prefix;
>   
> -	strbuf_add_absolute_path(&text, get_git_dir());
> +	strbuf_realpath(&text, get_git_dir(), 1);
>   	strbuf_add(&pattern, cond, cond_len);
>   	prefix = prepare_include_condition_pattern(&pattern);
>   
> diff --git a/path.c b/path.c
> index 2224843..18eaac3 100644
> --- a/path.c
> +++ b/path.c
> @@ -654,7 +654,7 @@ char *expand_user_path(const char *path)
>   			const char *home = getenv("HOME");
>   			if (!home)
>   				goto return_null;
> -			strbuf_addstr(&user_path, home);
> +			strbuf_addstr(&user_path, real_path(home));
>   #ifdef GIT_WINDOWS_NATIVE
>   			convert_slashes(user_path.buf);
>   #endif
> -- 8< --

Thanks for the fast reply.
Yes, my path is a softlink - into a directory under NoBackup/ - to make 
the backup shorter.
And I had forgotten about this :-(
And yes, your patch fixes it- tested under Linux.



