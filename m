Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215F01F404
	for <e@80x24.org>; Mon,  5 Mar 2018 16:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeCEQz3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 11:55:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:39139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeCEQz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 11:55:28 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQ2Wx-1eokWb37w3-005Is6; Mon, 05
 Mar 2018 17:55:26 +0100
Date:   Mon, 5 Mar 2018 17:55:26 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Birger Skogeng Pedersen <birgersp@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Add hotkeys to change focus between ui
 widgets
In-Reply-To: <20180228121052.10642-1-birgersp@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803051749060.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAGr--=LZ9TSM9v0SZOi_mj1t8se0Ck-nDHkwum3kC8uz9HKW6A@mail.gmail.com> <20180228121052.10642-1-birgersp@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LrpKIxxI4KbWUKW1LV5D2l+T/GYO7MC8P7pds99m/oYhmldJ5N7
 jFlSD13OP90rxWfDX1WjnmHSv6FYXfvo4cAgGQfAGA4OizHf5Iv7QXl9EcjXQPLF63OXKtI
 jp3q6DWqOYhqaeHY5wIEAIC5ZfyxPw1KIDutgK4mgKRIkvTD+fV45oXEbCiR9ESERCPDS4o
 Xoo6VPuIxRJGRfDdaJ1AQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fus8W84PRa0=:BhTDu95yPc+v+mhV/5MOKp
 WO4Y1d64+DJNn9UMgJ3GVHo9i629EijdRM7Gcw4V/bhKNZ08bI0lLsmhjzQqXyc423J/AuaOH
 a1myDXMsaeftsalDGzrdQqXjNDczjGbm/oHfIv5eYp7R0kcZPK8BNw5uy7c6U6/7M+JoeTKu+
 JffZcfpe7zG0ouPI5X99Z1zSMMe6n2XRLXd2xhItUl9ZbppQ0wy1U0GTRpp2sJ/ld15JbrMPD
 BlXXnSXBR86lUUfvxNhypGLm9G5i7hcc5CpjjvWeMvqaz2tvXS0LdOQS1lp8P1pf6Wfi+7mbT
 ChG4BZonoVbwUwBWTq/1YlqfEfu2VbDPQn7HrIBB8n7DWjMlTQluykZhM3iF/DaxBL8JgKkN8
 B8KUYH0fTyo/wWISO/UJ0HHo6rlO78bosXzgDCtkLknQRHaIeuAQIFxYpSRflgz1so5LJTv4+
 26A6vqnlod1hjAeXQ/6QKD/mYP8S+voT0Rs/lALPhUKsg/DAnkqBVpi/yRYZJIwCE5WM0mfAT
 0CeoF9UZAquoMS97KXz1SlM9P7BX2qB1sBp8I0i4ZQBk/ExYE+nX06JmPefE9h52VbK0UZYLR
 3afxogVJIq3C1NgrASvgVSIacdN4kHXzYSkGRbUiVZ5T1FRgXiRj6H/TL9dBG+5pfeffxQMog
 pQ71RHQxUu6DfS+S68giGlOBjAOudyHivKEzl/MfjeKfoaUSZfL+ZPARo+Y3ZMH9LFKFlQ52S
 hKoGxslvdCAhP8a+FNtheVy6KK6Y2bLWFk6n73wzSdJH4z5K/4hTdtdBOEHhwS1PtncK9hp2L
 kTze/hArk516mYmrohJvriTlLjl/uLuyLF1V3Ci3hzGMNDp9N5KlnAAMfbtB1IP44xe3cw3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Birger,

On Wed, 28 Feb 2018, Birger Skogeng Pedersen wrote:

> The user cannot change focus between the list of files, the diff view
> and the commit message widgets without using the mouse (clicking either of
> the four widgets ).
> 
> Hotkeys CTRL/CMD+number (1-4) now focuses the first file of either the
> "Unstaged Changes" or "Staged Changes", the diff view or the
> commit message dialog widgets, respectively. This enables the user to
> select/unselect files, view the diff and create a commit in git-gui
> using keyboard-only.

I like this!

> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 91c00e648..f96c0a6b8 100755
> 
> (This is my first patch ever, any feedback is highly appreciated)

I am not an expert in Tcl/Tk, but I'll do my best to comment on this
patch.

> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -2664,6 +2664,38 @@ proc show_less_context {} {
>  	}
>  }
>  
> +proc select_first_path {w} {
> +	global file_lists last_clicked selected_paths
> +	if {[llength $file_lists($w)] > 0} {
> +		focus $w
> +		set last_clicked [list $w 1]
> +		set path [lindex $file_lists($w) 0]
> +		array unset selected_paths
> +		set selected_paths($path) 1
> +		show_diff $path $w
> +	}
> +}

Do you think there is a way to focus on the last-selected path? That would
make this feature even more convenient, I think.

I am not sure that this information is still there if switching back from
another component...

> +proc select_first_unstaged_changes_path {} {
> +	global ui_workdir
> +	select_first_path $ui_workdir
> +}
> +
> +proc select_first_staged_changes_path {} {
> +	global ui_index
> +	select_first_path $ui_index
> +}
> +
> +proc focus_diff {} {
> +	global ui_diff
> +	focus $ui_diff
> +}
> +
> +proc focus_commit_message {} {
> +	global ui_comm
> +	focus $ui_comm
> +}
> +
>  ######################################################################
>  ##
>  ## ui construction
> @@ -3876,6 +3908,11 @@ foreach i [list $ui_index $ui_workdir] {
>  }
>  unset i
>  
> +bind . <$M1B-Key-1> {select_first_unstaged_changes_path}
> +bind . <$M1B-Key-2> {select_first_staged_changes_path}
> +bind . <$M1B-Key-3> {focus_diff}
> +bind . <$M1B-Key-4> {focus_commit_message}
> +
>  set file_lists($ui_index) [list]
>  set file_lists($ui_workdir) [list]

Looks good!

We are currently without an active Git GUI maintainer, so I hope that
Junio (the Git maintainer) will pick this up.

Ciao,
Johannes
