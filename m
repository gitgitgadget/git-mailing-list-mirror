Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8081F404
	for <e@80x24.org>; Thu, 16 Aug 2018 06:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbeHPJUM (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 05:20:12 -0400
Received: from mout.web.de ([212.227.17.12]:47531 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388974AbeHPJUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 05:20:11 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEVhF-1fevHz1MSX-00Flic; Thu, 16
 Aug 2018 08:23:18 +0200
Date:   Thu, 16 Aug 2018 08:23:17 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Hadi Safari <hadi@hadisafari.ir>
Cc:     git@vger.kernel.org
Subject: Re: "Changes not staged for commit" after cloning a repo on macOS
Message-ID: <20180816062317.GA5080@tor.lan>
References: <6022fbe8-0e07-f561-5e66-eeb4bc92704d@hadisafari.ir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6022fbe8-0e07-f561-5e66-eeb4bc92704d@hadisafari.ir>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:lDLt/VttTQuJdLhGeA2Sn51KZurxvRupIT72nDCxE9aHcfIWrf2
 ucGK4ojfAUCvvvSZ1X4RgoKyVEVMsttUL/2ge3Lran4zXO79Gwza24muQKHF4yo78L1ZcjB
 xFmMsllOYCK5WSdktRXGwz1+Br+4FvRSRwpGTDhD2lQaI/tH90ToDMwMmT28Lmki/ia9ltP
 DeMrxYxnG079iIVqWZVfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V639jMLT9gc=:eniqtgKU3BWHXlZgjA/XGB
 zwll98g6L5HpK5hjmQNPKwqIVMAJZkzo4dCeN/kULSdQYGf5hqSQ3C0KQJH6yeib8yYEPziat
 E92dm+/faMDfULraEHGOf3wdoLjgW6GQqrLj0xjCCKzqZig4LRKxKVxHh9sZicXq0kthcZNJN
 C0uj6hflf72cqLDGmZBichCNrYVraebTgTAahRIEZIUSSYUQnU7VGziIJWGda0ine5Ptt/V7y
 sQCGN2JCMMOPm9hVdJNaKiGZeybtavUgV77GKDU09NmrYLkjxNtcd981NGqyw0yMbhDnFTbTy
 tuxjT2dfg0QLckOAnPz5d+kmREMpbantKdy7zl1q0fdyVcKqQRIo3SWf0FsI05rC2r1Vqzpir
 vgbmJseZKppFZ7OT+Ms5DIbdLTuDcBaALK19Za4m5ao1eIJWXn7z6Wv5PL4ueqVnACSX+ahfb
 kz7fG/xDDn1YmUt4+zGaFHmrveA7b1kOhvuEVBea7WmYQKLy15wbjvexwSkUgC+SBASea5C1V
 vSwJ10puhHGDXMHCTQav9K8wMsFsm084MYzDpqRht+bJfmcb9CH4ppW1mCweL1BYd0bE0ouSx
 yfWn7z0p2nQ/7/lmdcanEmJsbZrwEKDdrXQXlX5MMPqIBGE9YL3CnthQW+9pTX7HdZuoZ+rv2
 g9p00M+p+bCs1OAhXhLAJSd29LyO0f38lhnQmpBqH4dwwUAdWS4Ei+Tt/uHbdFQT61ZkoT0ew
 sSHqQ7GFE2WY4e+tnvh9Gyheccp3c0wT/J2k5LY/w5bF5HKXAUxV39sHIUY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 12:25:24AM +0430, Hadi Safari wrote:
> Hi everyone!
> 
> I encountered a strange situation on OS X recently. I cloned a repository
> (https://github.com/kevinxucs/Sublime-Gitignore.git), went to folder, and
> saw "Changes not staged for commit" message for four specific files. It
> happened every time I repeated the procedure. I even was able to commit
> those to the repo.
> At first I thought there's something wrong with repo, but I cloned it on
> Ubuntu 16.04 and everything was OK; no "Changes not staged for commit"
> message.
> 
> Does anyone have any idea?
> 
> Thank you.
> 
> Log:
> 
> ```
> $ git clone https://github.com/kevinxucs/Sublime-Gitignore.git
> Cloning into 'Sublime-Gitignore'...
> remote: Counting objects: 515, done.
> remote: Total 515 (delta 0), reused 0 (delta 0), pack-reused 515
> Receiving objects: 100% (515/515), 102.14 KiB | 48.00 KiB/s, done.
> Resolving deltas: 100% (143/143), done.
> $ cd Sublime-Gitignore/
> $ git status
> On branch master
> Your branch is up to date with 'origin/master'.
> 
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
> 
>     modified:   boilerplates/Nanoc.gitignore
>     modified:   boilerplates/OpenCart.gitignore
>     modified:   boilerplates/SASS.gitignore
>     modified:   boilerplates/WordPress.gitignore
> 
> no changes added to commit (use "git add" and/or "git commit -a")
> ```
> 
> The rest of the log is available at
> https://github.com/kevinxucs/Sublime-Gitignore/issues/6. (I don't want this
> email to become too long.)
> 
> -- 
> Hadi Safari
> http://hadisafari.ir/


This repo seams not ment to be cloned onto a file system, which is case-insensitive.
For example, (see below), this 2 files a different in the repo, but the file system
can not have 'WordPress' and 'Wordpres's as different files or directories at the same
time.
This affects typically Mac OS and Windows users.

There is actually some work going on right now to inform the user about this problem.
(Thanks Duy !)
If I clone it with a patched Git, I get the following:


git clone https://github.com/kevinxucs/Sublime-Gitignore.git
Cloning into 'Sublime-Gitignore'...
remote: Counting objects: 515, done.
remote: Total 515 (delta 0), reused 0 (delta 0), pack-reused 515
Receiving objects: 100% (515/515), 102.16 KiB | 35.00 KiB/s, done.
Resolving deltas: 100% (143/143), done.
warning: the following paths have collided (e.g. case-sensitive paths
on a case-insensitive filesystem) and only one from the same
colliding group is in the working tree:

  'boilerplates/Gcov.gitignore'
  'boilerplates/Nanoc.gitignore'
  'boilerplates/OpenCart.gitignore'
  'boilerplates/SASS.gitignore'
  'boilerplates/Sass.gitignore'
  'boilerplates/Stella.gitignore'
  'boilerplates/WordPress.gitignore'
  'boilerplates/Wordpress.gitignore'
  'boilerplates/gcov.gitignore'
  'boilerplates/nanoc.gitignore'
  'boilerplates/opencart.gitignore'
  'boilerplates/stella.gitignore'

Would this text help you ?

I am asking because the development is still ongoing, so things can be improved.
