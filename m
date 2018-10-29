Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785AC1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 15:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeJ3AoI (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 20:44:08 -0400
Received: from mout.web.de ([212.227.17.12]:35763 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbeJ3AoH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 20:44:07 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXpdL-1g25BB0pqJ-00WlW7; Mon, 29
 Oct 2018 16:54:54 +0100
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXpdL-1g25BB0pqJ-00WlW7; Mon, 29
 Oct 2018 16:54:54 +0100
Date:   Mon, 29 Oct 2018 16:54:53 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Pete <pietro.cagnoni@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Prevent warning
Message-ID: <20181029155453.GA9819@tor.lan>
References: <01020166c07adf27-0c2cb5ac-2292-4ce3-808e-b627202fd45f-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01020166c07adf27-0c2cb5ac-2292-4ce3-808e-b627202fd45f-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:Wl7u2zhgvdee+8aO7gErshbszBRnGATSJV9XpvrwAMKbAJmW7K/
 EZpjya/mEn0OZ3cndiSCQlg7uaPaTq5VxHYm2BlwiKm00ckPW3NmdDX8MPVIP8XzKaiwnNG
 J4vN2ns6+gKm+HyFHfxP+l0taU/mIcxnOdPQMCiyZ6znAAMJhsdhCwPW0RapeF8aY20CW7l
 XXcU7Ku0AoyjXl0Fz3+BQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AXIcHaVjiqk=:p7lsGCSNPe2Io8Hv9YATbD
 XtoWD7CZwBLHnW3gBLJ8wGPNMjGGykIteu/CU3jCHcIIxPKGR6CZAWBtJn6NKGTvIaiX2rMDq
 31KU8YN3lcYWV1HClCK3Uz6DTdPZtOjU/VeRN/nvOOrSs7LaBIw1imR+Anbc0r50W7kueYZKx
 sdaWQUCNvR7am7PzzbkFqu+/OMdbCC6WtHIseNUTQF2LviVcpUbTlgMgRttr1Bu5JzM4EvrVk
 ulOWTmpRv2HVUzZK1maLCdCTKHgLZcIW9R8S0OCZYikucwjJz9AAVtvPW7cAari+Oi106Er2T
 D+PgJOccFeD7DRZKhRZpihnML/DBj6UC0iTZuke8Ct74W8lpkrtkbKHVBmIdEYKXH45wv8FJQ
 VbHYUHho/3N6muFGpqHY2qMrd1kMlmHGu3VEq1U74q5ADh068Ezhh9b3KFYCFK1OWDpNcuE+I
 fH5efqfQtU2MxS1EkWZMkc5ZHS8+QEBa0SSugD8wrznJZKQxYxlW4CvOToDCmfFvEagWF3Tng
 oVVukT7NIT/th2PK0U8r5zb9YwwM5FQ9L5Q8KmDTBLBQ5ntN7Gz0BaelhUl9hOzdNajoZ3dI4
 39/r38pqioFNqrrpxEuBCow2AdpRW4P7Gdo+kg+0j49zdvnFgA8x4ur4gE5lDHejb4qb+AmXd
 Lo4C7wIFVRJww5VXr9C57thSKjSghPEYsdMFsQsc3y4zL5bbl1+fNhxNhxxFQILLl0ThbtmZZ
 rmmX8US64P9/s2v7lGUSMz9wIdo6MI4gsLpEl2/GS5h+AuouQ75n4xVXqIno2S+f2SwpWIy2W
 bvlE2U/50KT6b13C/I/cHjYqICjrw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the patch.
Could you please sign it off ?
The other remark would be if the header line could be written longer than
just
"Prevent warning".
to give people digging into the Git history an initial information,
where the warning occured and from which module it was caused.
May be something like this as a head line ?

gitweb.perl: Fix Odd number of elements warning



On Mon, Oct 29, 2018 at 03:39:30PM +0000, Pete wrote:
> Prevent the following warning in the web server error log:
> gitweb.cgi: Odd number of elements in anonymous hash at /usr/share/gitweb/gitweb.cgi line 3305
> ---
>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 2594a4badb3d7..200647b683225 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3302,7 +3302,7 @@ sub git_get_remotes_list {
>  		next if $wanted and not $remote eq $wanted;
>  		my ($url, $key) = ($1, $2);
>  
> -		$remotes{$remote} ||= { 'heads' => () };
> +		$remotes{$remote} ||= { 'heads' => [] };
>  		$remotes{$remote}{$key} = $url;
>  	}
>  	close $fd or return;
> 
> --
> https://github.com/git/git/pull/548
