Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F711FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 17:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760897AbcLARFj (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 12:05:39 -0500
Received: from mout.gmx.net ([212.227.17.20]:52860 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760807AbcLARFh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 12:05:37 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MN604-1cJ4N12vgO-006bwG; Thu, 01
 Dec 2016 18:05:23 +0100
Date:   Thu, 1 Dec 2016 18:05:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     stefan.naewe@atlas-elektronik.com
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.11.0
In-Reply-To: <77d1fa5d-869c-546e-357b-cd1e6ffee48d@atlas-elektronik.com>
Message-ID: <alpine.DEB.2.20.1612011803070.117539@virtualbox>
References: <20161201123130.7608-1-johannes.schindelin@gmx.de> <77d1fa5d-869c-546e-357b-cd1e6ffee48d@atlas-elektronik.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rzD2oHSDUu4MT/zLuTkCQVed6L+Fyby6cmMALjf/rIqHk/9YXzv
 +fBEtGLk9DgNh2JHjkauPbV4Xzya3KMFxICJ28UCKsiRHRe2S1/+WDwzBpvKKMFxYEwAK9t
 EI5QbInUSR3HIw6hMvX7ShyWyiSBzbA277lBL8MOhjY4S3LcT4/h/XJU94JZu8knj0Qrpda
 qzfP8ptJiW5qFngCT5XHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KGi2b+8TOmM=:czncwTe8w1r88yFh1QL8cs
 j9n8katW9/HFMdlBoGNzuBM9c+b4aAfm8Q8UwUtBlG/Ei3meEdJg8qpSVgaPq7BnKFE9xUMcI
 MffJkAPXzEaQx2czJR9QsH8wN5d979+mR6w3taTqlPEyWQsmKs1tOieTTikNR8Gc1n1E9Wz44
 yw/FSOg0njRQYhzMo+jlWgnM3Ix956OPU7uJA0jwXYFTCrZ4L6N6ejJNqOsHW7cZyAB69aHxJ
 jO203Pjl7Z3aVd/UgFZzvGAgAjpyQvJjt7R4dYC4s6NSvn87NjCaXXNZeY5ZIuaVv0oEuuyt7
 bVq63qGYEBauksedCYGgd96BLfKXV/62HlEFfSeWYQ+sX9BkpVzMQahneEzqhn9AoSQq6L33t
 wUwiLSHWlh0HRFe72Yn42H1SDTGNOqQblCfk1OC/BnrzA7qVbcQhXUBkn6oD1z6dqhYh9L2Nf
 +tzFIGccF/10V7b7/ptYZPg1Pp+XGSsiqSdDf5MkEOi9UJo/cdfhBS6BivK+VNp2c6PsiovZQ
 /mDdeYomyza3kNca7EpHYJlPXJDKz5Alv6clT4S/pYCjMbP/Mx7gUCamifWbl8unu1ykFtaMo
 LGy/r/NZ8sb7pCCr9mO+Qc4qXfqx0I3PqOvuohFvdrD1lWloGTx6/w40L9LQ7st4ubEr8mjGb
 EN6g7Gs4qCGFzWpyLvxSwV2lkOVnTDH48WT5AHL5OD4n/PiA2NhtBParJ5mTzqxfnyprX7wNf
 jK90A6uVff17KF2SBEh41PjVmPi6H0py5zilPh7h7L2tuMqHG6cpbDV0MyptjhpLYXGtddAB1
 BHIvUOJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 1 Dec 2016, stefan.naewe@atlas-elektronik.com wrote:

> Am 01.12.2016 um 13:31 schrieb Johannes Schindelin:
>
> >   * Support has been added to generate project files for Visual Studio
> >     2010 and later.
> 
> That's not really a new feature of Git-for-Windows, is it ?

Yes it is. We had a script to generate project files for Visual Studio <
2008, but they were broken.

This script has been partially fixed, and support has been added to
generate the .vcxproj used by Visual Studio 2010 and later.

Further, compile errors have been addressed.

After that, I worked on being able to run the tests in a regular Git Bash
(i.e. *without* installing Git for Windows' SDK, just a regular Git for
Windows will do).

Took a lot of effort and time, too,
Johannes
