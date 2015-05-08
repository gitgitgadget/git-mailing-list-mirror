From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] command-list.txt: group common commands by theme
Date: Fri, 08 May 2015 15:02:09 +0200
Organization: gmx
Message-ID: <14b541cabe4f1051859364eada40d153@www.dscho.org>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
 <b89d3fec640cb6fb01aa32ad50bae4e064528220.1430770308.git.sebastien.guimmara@gmail.com>
 <CAPig+cTHQikgOvPrjxikUNjQoWCv2hdubJ55OG0SqpGUs_3Pow@mail.gmail.com>
 <554A8084.10506@gmail.com>
 <CAPig+cQ2e4c5hYsRbZhgyvLcMPsqshqRUZGNLwhJd57YP9JEFA@mail.gmail.com>
 <554BBBAF.30705@kdbg.org> <0eb58475c6238be314eb4f0be08f8ae6@www.dscho.org>
 <87egmrth00.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri May 08 15:02:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqhv2-0005Ik-Ba
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 15:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbbEHNCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 09:02:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:63909 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbbEHNCP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 09:02:15 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lp3x6-1ZT3P403AS-00eql0; Fri, 08 May 2015 15:02:10
 +0200
In-Reply-To: <87egmrth00.fsf@igel.home>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Hiz1FZRKPQNcuS+eopJQB2mWK6g1rRvBzQY+YcnbO7VM3I20RfM
 57fx9gq527MDGtujC3X/t5XAxZVUsl++CnpOlK+m9UD2/yJPYK+5HBkrkfZoe5xPuBx4zyo
 ZGIJ0BdWKo9+jEv0d9MxbKxZy3cdhddl6PWelCblmT7ZFXagMrOE/YIWoogCBbf36FRwslU
 kYq4tc6pvg13jZbHpdZ5Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268615>

Hi Andreas,

On 2015-05-08 14:01, Andreas Schwab wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> It's probably my failure for not finding the documentation on that, but I really would like to be educated. Do you have an authoritative source for that statement?
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html
> 
> 3.206 Line
> A sequence of zero or more non- <newline> characters plus a terminating
> <newline> character.
> 
> 3.397 Text File
> A file that contains characters organized into zero or more lines. The
> lines do not contain NUL characters and none can exceed {LINE_MAX} bytes
> in length, including the <newline> character. Although POSIX.1-2008 does
> not distinguish between text files and binary files (see the ISO C
> standard), many utilities only produce predictable or meaningful output
> when operating on text files. The standard utilities that have such
> restrictions always specify "text files" in their STDIN or INPUT FILES
> sections.

Thanks!
Dscho
