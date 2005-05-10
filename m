From: "Eduardo Teixeira Dias" <eduardo@tendencies.com.br>
Subject: Re: Core and Not-So Core
Date: Tue, 10 May 2005 19:33:48 -0300 (BRT)
Message-ID: <62633.200.158.14.67.1115764428.squirrel@www.tendencies.com.br>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
        <1115739511.16187.432.camel@hades.cambridge.redhat.com>
        <17115.200.158.14.67.1115740220.squirrel@www.tendencies.com.br>
        <1115740844.16187.445.camel@hades.cambridge.redhat.com>
        <26021.200.158.14.67.1115741989.squirrel@www.tendencies.com.br>
        <20050510234501.79eea7a4.diegocg@gmail.com>
Reply-To: eduardo@tendencies.com.br
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <eduardo@tendencies.com.br>, <dwmw2@infradead.org>,
	<jon@blackcubes.dyndns.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 00:27:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVdBj-00071b-41
	for gcvg-git@gmane.org; Wed, 11 May 2005 00:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVEJWeK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 May 2005 18:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVEJWeK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 18:34:10 -0400
Received: from tendencies.com.br ([72.29.102.143]:44684 "EHLO
	tendencies.com.br") by vger.kernel.org with ESMTP id S261808AbVEJWeE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 18:34:04 -0400
Received: from tendencies.com.br (localhost [127.0.0.1])
	by tendencies.com.br (8.12.11/8.12.11) with ESMTP id j4AMXm7n014207;
	Tue, 10 May 2005 18:33:48 -0400
Received: (from apache@localhost)
	by tendencies.com.br (8.12.11/8.12.11/Submit) id j4AMXmIt014206;
	Tue, 10 May 2005 19:33:48 -0300
X-Authentication-Warning: tendencies.com.br: apache set sender to eduardo@tendencies.com.br using -f
Received: from 200.158.14.67 (proxying for 200.158.14.67)
        (SquirrelMail authenticated user etdias)
        by www.tendencies.com.br with HTTP;
        Tue, 10 May 2005 19:33:48 -0300 (BRT)
To: <diegocg@gmail.com>
In-Reply-To: <20050510234501.79eea7a4.diegocg@gmail.com>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'm a Java programmer and I was thinking like one (Culture thing).

The reuse argument is very Strong.

The git-core are ready and it's a very good idea to reuse it. Any chang=
e
in the core or in the internal representation of git repository will
benefit the Git-Java implementation...

I think that a growing utilization of GCJ and ClassPath will contribute=
 to
a Gradual Culture Change in the Java Land and promote a beter
reutilization among all GCC languages...

Write Once Run Everywhere that GCJ Runs (Sounds Good).

Eclipse will be compiled with GCJ in Fedora 4. Let's see how it works..=
=2E

Cheers!

> El Tue, 10 May 2005 13:19:49 -0300 (BRT),
> "Eduardo Teixeira Dias" <eduardo@tendencies.com.br> escribi=F3:
>
>>   - Just a .jar download
>>   - Installation without external dependencies
>
>
> Someone who is going to hack the kernel can very well install more
> things. And anyway, git is "the linux SCM tool" so all distros will
> package it. Also, people who hacks the linux kernel usually runs it, =
so
> "git is not ported to win32" is not a big problem.
>
> ...and I don't think people who use eclipse wants to have the fastest
> tool on earth, so "java-invoking-C is slower than pure java" is not a
> great excuse either...
>
> Code reuse =3D=3D good. Java programmers should know that. Anyway, pe=
ople is
> free to do whatever they want with their time :)




