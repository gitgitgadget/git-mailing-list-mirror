Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB0BC433F5
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 19:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhL0TvI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 27 Dec 2021 14:51:08 -0500
Received: from elephants.elehost.com ([216.66.27.132]:41897 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhL0TvH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 14:51:07 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BRJp0dQ086912
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Dec 2021 14:51:00 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'zhiyiren2009-subscription'" 
        <zhiyiren2009-subscription@protonmail.com>
Cc:     <zhiyiren2009@protonmail.com>, <snakamoto1975@protonmail.com>,
        <git@vger.kernel.org>
References: <7w7c2MDOBpV9yIlD5yZZb801w-eaz0qhErkCN-De51h892xRFL14N-LCXH0O8wvDp_51A3hC86EMXonBkjNdoTZ-iy8xzoKLVecN6D6Zpq4=@protonmail.com> <004601d7fb3c$c9d359c0$5d7a0d40$@nexbridge.com> <J-VncZqqtXGSpnkopiYEtOET-oeVZX1tk3jBX9c3oSaOrcH1N_ciDdzQFvk50CkibrWFCboQNDeegBNMGZ247duUXwnPFY_0HbFvEWI0hVg=@protonmail.com> <000001d7fb3e$7c0e8730$742b9590$@nexbridge.com> <FKMNcEoH2PMBw4wcDkxzCDdl41kpWkZyh5SkiRlDi6seiVchbCuBbMmc38SFYR8gAgDhk_vo3xJSCiPSdYRIvhOQ1cB4uoZksClDYey2LXs=@protonmail.com>
In-Reply-To: <FKMNcEoH2PMBw4wcDkxzCDdl41kpWkZyh5SkiRlDi6seiVchbCuBbMmc38SFYR8gAgDhk_vo3xJSCiPSdYRIvhOQ1cB4uoZksClDYey2LXs=@protonmail.com>
Subject: RE: Quick login of git
Date:   Mon, 27 Dec 2021 14:50:54 -0500
Organization: Nexbridge Inc.
Message-ID: <000801d7fb5b$12ec49f0$38c4ddd0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLwDr+U6wAuL69FdVqNmXykk0g36wIUmq15AbK6nYYCAu5wvgJYe5V8qdWBy5A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: zhiyiren2009-subscription <zhiyiren2009-
> subscription@protonmail.com>
> Sent: December 27, 2021 2:16 PM
> To: rsbecker@nexbridge.com
> Cc: zhiyiren2009@protonmail.com; snakamoto1975@protonmail.com;
> git@vger.kernel.org
> Subject: RE: Quick login of git
> 
> Visit the url provided by IDE in the browser, and then click "Auth" to login.
> Wait a moment, GitHub will return a token to the program, and you can easily
> login to GitHub. Popular IDEs have this login method.
> This configuration is much faster than the terminal, and it takes less than 1
> minute.  But it takes 5-10 minutes to configure by terminal for the new users.
> 
> Zhiyi Ren / Subscription Mail
> zhiyiren2009@protonmail.com / zhiyiren2009-subscription@protonmail.com
> 
> Sent with ProtonMail Secure Email.
> 
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> 
> On Tuesday, December 28th, 2021 at 00:26, <rsbecker@nexbridge.com>
> wrote:
> 
> > On December 27, 2021 11:24 AM, zhiyiren2009-subscription wrote:
> >
> > > On Tuesday, December 28th, 2021 at 00:14, rsbecker@nexbridge.com
> > >
> > > wrote:
> > >
> > > > On December 27, 2021 11:07 AM zhiyiren2009-subscription wrote:
> > > >
> > > > > Why not add a quick login method like VSCode and CLion in git? Login
> to
> > > > >
> > > > > GitHub/ GitLab with one click, without privete key.
> > > >
> > > > I am not sure this has anything to do with git itself. One does not "login"
> to
> > > >
> > > > git. You might want to take this up with the GitHub/GitLab support
> forums.
> > > >
> > > > However, one-click login is being replace with MFA.
> >
> > > Did you mean Multi-Factor Authentication？
> >
> > Yes. And please place replies at end on this mailing list. Thanks.

Please use the proper place for suggesting changes.

For GitHub: https://github.community/
For GitLab: https://about.gitlab.com/support/#contact-support


