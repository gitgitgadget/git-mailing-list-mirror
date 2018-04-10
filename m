Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2A311F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeDJVCm (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:02:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:54547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbeDJVCl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:02:41 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbxQO-1eebfd2H1o-00jIBH; Tue, 10
 Apr 2018 23:02:37 +0200
Date:   Tue, 10 Apr 2018 23:02:21 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: git-gui branches, was Re: What's cooking in git.git (Apr 2018, #01;
 Mon, 9)
In-Reply-To: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804102301200.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gQ58+tWE3e6+EaSVGZdevqhYtIDHgS3svzl8g39zG7U9XoijYVr
 L3esc+I8v275R6aAI+6di/E4erBn/WAofsY8wpzZk9YmHnEUvRNoH8c2kUcugotvO+vdgiY
 f8d02WBXUfa3B2R/gbCmvNBctT2PdbCZKU8nGnFnHQVIbyeq+95+7PeYBJFvdcuibxX+idH
 502tGo1H15QElKQkIlgEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YLRPxHQF+V8=:ANOaZWO4mdRKKG8f5UuIcz
 /AQs2OPXSavNbEGu2k2vFIl+u5V/ioH8BHQIZ8WEaG9fQEC1wBgLLLB0K9mf99eDFfZI+6PG6
 UrDGuhpjllStj5E2lOJCzSyeGcK6Y/gpz0RGByuufDXs826lbzztdOoP7zL+1fp/wrlvS06C+
 ehsYzztJysrwwXTKehJd+s9w9HG2W25f8h1loWc/yz7fRWhp47b9u6i6cbxnxjIjOiXIFXo07
 9ddzwWoh4vfmDyw2N3vXfGs/mLCYXE2AmngWpOTT9loRZCPrrMZzCT1Q78DoKhoD+Lal/0Pup
 ZcRFbsj+eAOgwOKUNbGU7HsydDvOQ6yDb352bYFqA8BHoc5pmqKS/z9vkVDufToyW3CdDG3Dz
 MylJo6Gf7PBhI6KFIqPf2FnSqHh8SPOmd2/WGLqdpVgPGjiqFv52MAUts5JtXH59pIv/Jlfb8
 XWt29ZHJv+Sp8x811xBh7W3R2jJyib+ZCi51e1q5bnEbJ5ONeAIZY3ZOkde1lnSAp64QGmUCZ
 TzI2v3blL07DgVRXfbfwkczfQC2eao+oc4sAyF42oClwxaHjTmRkyLS2fYfzzzGdNpAc242JT
 9H3SO1XGgcvfkmsRoy5uAcLTRLQ3WGYvbbAviCYjmPU5sQphqPVztMDjIjRDLzB3qx29Dk/+n
 95kd8WtoFcSoKiJpDValSyI+9t7RSieaPM6ECV9SSdNumdvEqsalS7uPapHgVOwYbPZlRsxAq
 s5nGh/vykdkRYVQEIZHyxVwWGSAd16Yj2dLxNYOTMVFEsGMC5mPvB8kx9f7jO+1fyhvotlSu+
 e85FGwmFf8cgNwh/ls4ElbZvAMC0NJHGw9nawYyeRGBgSE0wQc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Apr 2018, Junio C Hamano wrote:

> * bb/git-gui-ssh-key-files (2018-03-02) 2 commits
>  - Merge branch 'bb/ssh-key-files' of git-gui into bb/git-gui-ssh-key-files
>  - git-gui: search for all current SSH key types
> 
>  "git gui" learned that "~/.ssh/id_ecdsa.pub" and
>  "~/.ssh/id_ed25519.pub" are also possible SSH key files.
> 
> 
> * bp/git-gui-bind-kp-enter (2018-03-02) 2 commits
>  - Merge branch 'bp/bind-kp-enter' of git-gui into bp/git-gui-bind-kp-enter
>  - git-gui: bind CTRL/CMD+numpad ENTER to do_commit
> 
>  "git gui" performs commit upon CTRL/CMD+ENTER but the
>  CTRL/CMD+KP_ENTER (i.e. enter key on the numpad) did not have the
>  same key binding.  It now does.
> 
> 
> * cb/git-gui-ttk-style (2018-03-05) 2 commits
>  - Merge branch 'cb/ttk-style' of git-gui into cb/git-gui-ttk-style
>  - git-gui: workaround ttk:style theme use
> 
>  "git gui" has been taught to work with old versions of tk (like
>  8.5.7) that do not support "ttk::style theme use" as a way to query
>  the current theme.

What is your plan with those? I thought they were on track for v2.17.0,
but now I see that they are not even in `next`...

Ciao,
Dscho
