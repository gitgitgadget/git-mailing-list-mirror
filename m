Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323D01F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 12:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeK0Xro (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 18:47:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:51857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeK0Xrn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 18:47:43 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOCSm-1gM6VH2Hn2-005br2; Tue, 27
 Nov 2018 13:49:51 +0100
Date:   Tue, 27 Nov 2018 13:49:35 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, svnpenn@gmail.com
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo'
 is working (again)
In-Reply-To: <20181126173252.1558-1-tboegi@web.de>
Message-ID: <nycvar.QRO.7.76.6.1811271346550.41@tvgsbejvaqbjf.bet>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181126173252.1558-1-tboegi@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+qZPEcO5m24v9unrISvsVL9EAQyJbTdnq31A3D1Bnqx7pRXrJKR
 JsNGTAZyZKNzYVsLmEtW1GHSJ3pvbRwkQHQma7TmklTRHGEocuprq6A3uVS3j/PXuiVSkAT
 v7FT9KfEx1+wp3U5FeQu+XZWjL3X+ayIwRVta76Zx+z04nL9+ABweqvYrZev8aD6YeWD0xN
 /T3//K1tpZl0IjkayPdaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hlP5UZhLhIE=:hMdjEIu5D8jKcSO/2/a5oD
 knXEVXF5E9qIkOrLjmGMu10zQ2KKXYi4lRd5r+ZVG84RNqZ5WvbIPZqxGHWHWqxZYAW9FaeRZ
 K+Is+iSapWzpDEVv98YFuOxOu5IKdqH5oj/fUsncqNrD9Y5sDiuw/GG9i1UET0bpTJqfEojrS
 I/OjwiMyZRf6I9xEpqE4B+jBGOJJ14Ef1CDjGikNuRuuTSHIsJmIZ6SwEGx/l2tXPYzgFYnhU
 ITrUZSwg5VkSM0mj2lB6j3NTOxqI6Cp5/yKq9bJsUFLRvu8kvGxKmXQF5seA94M4QKfbVp5uY
 YdCTKAG54z1xrDMUWEq/X08reMFUQ7TIddDR1BDsXE6JQuQ5wPcdsYcGVKe5uc2IZKsQs6wIv
 A5dlxj5CdiTwiAJCssYrSx83h7ttKM6nJHtDjs1BIs3ptsjmRbTg6FcDSSQ5lqSIpdFtZLOgV
 WCIanxI/DUTMNPa6WcLTYYEt3GVQa0fPtKDa+tC7pxf3yToulZ4BYaAZ4V9z8l0NpsSs+CTVW
 kzR23q020fZXjEaueFZkSx9imYXDjAf0ojj7QVxBQ/1PdBCWOg2N4Iqbp4JRMYYaD4kCrgTVo
 Q1Elf4TAfHi2FFVXdtzLv2Wla9trl+3Wr8cAqQgTcb0iEbyFFFnzrTIGL8Y+FrvSto3IDLQu8
 2bOzU9UZkbae5Rpv8DK7SHxoY3+sirUsSALTcNy9VeVO1biwRbwHiqmkYQqMbuP2VFwc87asZ
 ohy8ZIT9hMleKEAc6bYnCnbk/rThzvmIyF8kbxqgGhCPJ31IjcSIVrf2POE0Z1ycoNBwyyhmM
 0dam4Tt98+poQjexph/ucV8OqEcKlQChqGjWru42D3xdXv/cMcipYre7Y6MycnughKKTpeO07
 DdWMDlb5IhRloRVWJQ6G9DdveIel9UtHb7C7kYVKn0WFYF9NxAq5lqVQhKvd96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten,

On Mon, 26 Nov 2018, tboegi@web.de wrote:

> diff --git a/compat/cygwin.c b/compat/cygwin.c
> index b9862d606d..c4a10cb5a1 100644
> --- a/compat/cygwin.c
> +++ b/compat/cygwin.c
> @@ -1,19 +1,29 @@
>  #include "../git-compat-util.h"
>  #include "../cache.h"
>  
> +int cygwin_skip_dos_drive_prefix(char **path)
> +{
> +	int ret = has_dos_drive_prefix(*path);
> +	*path += ret;
> +	return ret;
> +}
> +
>  int cygwin_offset_1st_component(const char *path)
>  {
> -	const char *pos = path;
> +	char *pos = (char *)path;
> +
>  	/* unc paths */
> -	if (is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
> +	if (!skip_dos_drive_prefix(&pos) &&
> +			is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {

It takes a little folding and knotting of the brain to understand that
this `!skip_dos_drive_prefix(&pos)` has *nothing* to do with the comment
`unc paths` nor with the test whether the paths starts with two directory
separators.

As a consequence, I would highly suggest to turn this into:

	if (skip_dos_drive_prefix(&pos))
		; /* absolute path with DOS drive prefix */
  	/* unc paths */
	else if (is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {

That makes the code a lot easier to understand, and as a consequence a lot
harder to mess up in the future.

Thanks,
Dscho

>  		/* skip server name */
> -		pos = strchr(pos + 2, '/');
> +		pos = strpbrk(pos + 2, "\\/");
>  		if (!pos)
>  			return 0; /* Error: malformed unc path */
>  
>  		do {
>  			pos++;
> -		} while (*pos && pos[0] != '/');
> +		} while (*pos && !is_dir_sep(*pos));
>  	}
> +
>  	return pos + is_dir_sep(*pos) - path;
>  }
> diff --git a/compat/cygwin.h b/compat/cygwin.h
> index 8e52de4644..46f29c0a90 100644
> --- a/compat/cygwin.h
> +++ b/compat/cygwin.h
> @@ -1,2 +1,34 @@
> +#define has_dos_drive_prefix(path) \
> +	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
> +
> +
> +int cygwin_offset_1st_component(const char *path);
> +#define offset_1st_component cygwin_offset_1st_component
> +
> +
> +#define has_dos_drive_prefix(path) \
> +	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
> +int cygwin_skip_dos_drive_prefix(char **path);
> +#define skip_dos_drive_prefix cygwin_skip_dos_drive_prefix
> +static inline int cygwin_is_dir_sep(int c)
> +{
> +	return c == '/' || c == '\\';
> +}
> +#define is_dir_sep cygwin_is_dir_sep
> +static inline char *cygwin_find_last_dir_sep(const char *path)
> +{
> +	char *ret = NULL;
> +	for (; *path; ++path)
> +		if (is_dir_sep(*path))
> +			ret = (char *)path;
> +	return ret;
> +}
> +static inline void convert_slashes(char *path)
> +{
> +	for (; *path; path++)
> +		if (*path == '\\')
> +			*path = '/';
> +}
> +#define find_last_dir_sep cygwin_find_last_dir_sep
>  int cygwin_offset_1st_component(const char *path);
>  #define offset_1st_component cygwin_offset_1st_component
> -- 
> 2.19.0.271.gfe8321ec05
> 
> 
