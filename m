From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 08:20:28 -0500
Message-ID: <CAMP44s192hzh8AWU-Eg1VVVXjZ9qyNqHw99X6y48MXJn3DHw+Q@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
	<CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
	<CAMP44s08V1=nVbeo6r8UVT3Fd0=iSpRohinqf77Tmu4=xpDHeg@mail.gmail.com>
	<CACsJy8DTKr5Fy3-+8ShUrWQrKC2_7EmLHwyVgQ9Aq5JDOFBAqA@mail.gmail.com>
	<CAMP44s0GUrQqXCj97Ay+0CsA1z=96BPYfyADbTaHH7fc7HL0sQ@mail.gmail.com>
	<CACsJy8D8xD3mdC2gsBpU74Faa+CUfEWEgh5fhwPoRjz46-hjcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 15:20:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJ4U-0001EA-A8
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 15:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab3FHNUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 09:20:37 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:40252 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab3FHNUg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 09:20:36 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so2334346lbi.26
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AkXrrj7vbaIFziX/+Ntdq/YayRsx7L5r4IuXcLeu+Qo=;
        b=voIlO6tBXFl0m/ZGAx5xdOFwHX/N96KbfkibZNKftSIUbakPlKKDWbT0XnEsGnSF1d
         mZ+FnfYyknSEMJdLoxMXutuz5xTsH1ZlyikjIY2ixwrBWUR0xNYRft2NapZVPrH/IQU2
         ft6W/wfZOIRlTXQKZU/Xv5j9RUtreCS1ezcGXCUwenJwv7FdT3fwAUlqyj2BeKkMFz/d
         wf8ifdT3RHeP7sITvKmQOLHgjJdTeMrgiYdtI5rqK+QPddmT+gwtOATfeDZWC1wyq66r
         2BssNPJal0NuGhCmbYBak/p3U5zOISkkC5eUn12VfkuLt5o62wWva2vw8rTo71aB3/wU
         0rFw==
X-Received: by 10.112.219.133 with SMTP id po5mr3011646lbc.80.1370697628961;
 Sat, 08 Jun 2013 06:20:28 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 06:20:28 -0700 (PDT)
In-Reply-To: <CACsJy8D8xD3mdC2gsBpU74Faa+CUfEWEgh5fhwPoRjz46-hjcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226817>

On Sat, Jun 8, 2013 at 7:07 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 8, 2013 at 6:56 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sat, Jun 8, 2013 at 6:28 AM, Duy Nguyen <pclouds@gmail.com> wrote:

>>> but how many people on this
>>> list understand git design and limits _and_ ruby's good enough to spot
>>> the bugs?
>>
>> Now you are changing the subject. Does that mean that you accept that
>> 'fork' wouldn't be a problem when writing Ruby scripts?
>
> There are a lot of static variables in builtin/ (and outside too),
> which make it non-entrant, or at least not safe.

So?

> fork provides a process space isolation, some depend on that.

Process space isolation from what?

> And there are die() everywhere. Good luck controlling them.

Done.

--- a/ruby/git.c
+++ b/ruby/git.c
@@ -1,6 +1,7 @@
 #include <builtin.h>
 #include <cache.h>
 #include <fcntl.h>
+#include <ucontext.h>

 #undef NORETURN
 #undef PATH_SEP
@@ -8,6 +9,8 @@
 #include <ruby.h>

 static VALUE shellwords;
+static ucontext_t main_context;
+static int status;

 struct cmd_struct {
 	const char *cmd;
@@ -73,7 +76,14 @@ static VALUE git_rb_backticks(int o_argc, VALUE
*o_argv, VALUE ctx)
 	if (cmd->option & RUN_SETUP)
 		prefix = setup_git_directory();

-	i = cmd->fn(argc, argv, prefix);
+	getcontext(&main_context);
+	if (status == 0) {
+		status += 1;
+		i = cmd->fn(argc, argv, prefix);
+	} else {
+		i = 1;
+	}
+	status = 0;
 	rb_last_status_set(i, getpid());

 	fflush(stdout);
@@ -87,9 +97,19 @@ static VALUE git_rb_backticks(int o_argc, VALUE
*o_argv, VALUE ctx)
 	return rb_str_new(buf, i);
 }

+static void bye(void)
+{
+	if (status != 1)
+		return;
+	status += 1;
+	setcontext(&main_context);
+}
+
 void Init_git(void)
 {
 	rb_require("shellwords");
 	shellwords = rb_define_module("Shellwords");
 	rb_define_global_function("`", git_rb_backticks, -1);
+
+	atexit(bye);
 }

>> As for the people that know Git and Ruby; they can learn. Didn't you
>> just said that you didn't see any problem with the community learning
>> a new language?
>
> I said nothing about the community being ready _now_, did I?

If they can learn Ruby five years from now, then can learn it now.

> When you have the support for Ruby in Git, sure go ahead.

You are going in circles.

>>> If a bug is found and requires major restructuring in
>>> libgit.a, how are you sure it's worth the effort and does not
>>> destablize the rest of git?
>>
>> There is no need to destabilize anything. I just showed you 100 lines
>> of code that are able to run git commands without forks, and without
>> changing anything in libgit.a.
>
> And how do you deal with, for example die(), or thread safety?

See above for die(), and I don't see many perl or shell scripts with
multiple threads, why should the Ruby scripts have more than one
thread?

-- 
Felipe Contreras
