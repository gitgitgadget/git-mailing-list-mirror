From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [git-for-windows] Case insensitive branch names
Date: Mon, 21 Dec 2015 19:22:03 +0100
Message-ID: <5678434B.5040506@web.de>
References: <D350A5BC87B74A53B5BE4B10BC658208@PhilipOakley>
 <CACsJy8CEYaf9NA4J_2u1cqsikYvtR7nz=FEiwAxsKMLSREDhCg@mail.gmail.com>
 <xmqqa8p3hfej.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>,
	git-for-windows <git-for-windows@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 19:22:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB56D-00048D-Tq
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 19:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbbLUSWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 13:22:17 -0500
Received: from mout.web.de ([212.227.17.12]:64010 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbbLUSWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 13:22:16 -0500
Received: from macce.local ([87.146.129.103]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MSai0-1Zlkio2aeq-00Ra8j; Mon, 21 Dec 2015 19:22:07
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <xmqqa8p3hfej.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:xR3JeJRuPoK8rFIE3ZVW2eKdt1Z6HonPYAPXfX49zowaer5sly9
 GkGQVJVtt5LtsMII9//VgmJXmZnmusLfPeuQlTndO+Wl4T282Qa8eLN6Bt/TKEs3avxB7TK
 BwKbRnW08KUJP+6zIzFpBKkPJMV6gi0X7K8TP0yWPqAj+KDmmRNhxGFk+edAvBOaJTrTljm
 /12uWc7JFSmqcP997CN3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P8j9K66Wxbs=:2QfCCf4Tk9NpEh5ud7+FoP
 NsyTx2gl/XstyGdOF5CU4/JkrmaqO23YNzUKaJgVyvquAlhDD2jeKLnF/TLuDwM6tVQKJ5b+l
 o5f14mQMnlRjNvXsnArFYjCLohiGYJBRZ/f0bb3m/MTlD8NME8G3JgLvCH4zP4JzWRZWvtu+D
 2lx6eWGlaNl3dEyWqvZ9iTwXlblWuOaCyDErwq9H7v/cC1KRRNYJDqv0urPJyS/Ywbo+ASb6o
 aJKI6+IMYGm6nQ5LtxtRSzifNnbIt89XHSWAR65N5/JAvLvML/A9Wqu8W8w5TtD0JVczM1P3f
 PLHHuaYShjM5z2b8FPL6jOPf19fuQZQzaf/fLJXxuHBrPCeKYmUgIKixEruOZGoImMYTSIz2W
 I66G9HX/j+snk+WL0pW9zPET5VsMjJj6azwinRxqQCACWjpnq0ChtpEI5Tl6Ez5fvmpaCtRm7
 JbziDafNAdE6SrH+e9Auyp2nc0m5453HF5RIFPSVPUSQvrX1oqTtuXLpi9ZGGYLkHPbAle+yw
 tXRgGWbKRn1RT0YRcNR59YpJJbfJKwOvAERuj4E+6MCvVF50s8oba9HHuAuiAz06h7c1tyCSZ
 5IAY0A6yIT/bm7lhe+4lv9Z37szM49GZxZv4ENldu1szlJWSi/+u2/eZ+v+0Oak+0OCZVbkUI
 lh8kFZDpO0Z/ugp2PftpZIQ2zoCed3j6IVj3dGuWqk1JXB1XJWpH6tBgkazcwmUkO0GmGYZ5z
 Df2AqlcLaL8NbwKqczqlUFQu2ADxs1/SV760HbPgiroY4d1V78Tp0HycZzkk18zGrZ7hqs50 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282806>



On 2015-12-21 18.37, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Mon, Dec 21, 2015 at 6:01 PM, Philip Oakley <philipoakley@iee.org> wrote:
>>> On the Git User's list, Diego J. reported that:
>>>
>>> 'When I "checkout" a branch using different Upper Case/Lower Case than the
>>> original, the branch doesn't show in "git branch [--list]"' [1]
>>>
>>> While case sensitivity for filenames is a common issue on Windows and the
>>> like, I haven't seen any discussion regarding ref name sensitivity - any
>>> pointers to past discussions?
>> Multiple ref backend [1] should solve this.
> Yup, I had the same reaction.  Instead of restricting the namespace
> of branches even on systems that do not have this problem, use a ref
> backend that is not limited by the underlying filesystem.  A much
> better solution.
>
> In addition to the LMDB backend, it might not be a bad idea to add
> another filesystem-based backend that encodes the refnames safely on
> case insensitive or case destroying filesystem.  That way, those who
> do not want an extra dependency but do want case sensitive refnames
> would have an option, and having two non-default backends with quite
> different semantics may be a good way to ensure that the API for
> refs backend is kept sane.

This has been reported (probably a couple of times),
one copy I have here was under "Branch Name Case Sensitivity"
around Feb/March 2014.

The lstat() in refs.c can not be fixed, as the underlying OS/FS thinks
that lstat("nocase") == lstat("NoCase") and
open("nocase") == NoCase").

The the "real name" will not be detected, unless somebody does
opendir(), readdir() and closedir().
This is expensive (in terms of execution time), and nobody
has tried to do something.


One cheap solution would be to run "git pack-refs" internally,
either from C-code inside Git itself, or from a script.
