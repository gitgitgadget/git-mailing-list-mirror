From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] l10n: de.po: translate 11 new messages
Date: Mon, 28 Jan 2013 20:52:05 -0000
Organization: OPDS
Message-ID: <F873F54C3F2C49CC9640F35F5626717B@PhilipOakley>
References: <1359353699-3987-1-git-send-email-ralf.thielow@gmail.com> <ke69ta$1e4$1@ger.gmane.org> <20130128181315.GB2926@rath-ubuntu>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <jk@jk.gs>, <stimming@tuhh.de>,
	<trast@inf.ethz.ch>, "Thomas Ackermann" <th.acker@arcor.de>
To: "Ralf Thielow" <ralf.thielow@gmail.com>,
	"Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Jan 28 21:52:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzvgl-0000cO-Q6
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 21:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab3A1Uv7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2013 15:51:59 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:20358 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752181Ab3A1Uv6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 15:51:58 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhYKAIbkBlFcHKA3/2dsb2JhbABEjAOxUwN8F3OCGQUBAQUIAQEdCwEFHgEBIQsCAwUCAQMVAQIJJRQBBAgSBgcXBgESCAIBAgMBh24DE7ZIDYlVjBCBH4MVYQOILIVShjmNDIUSgnc
X-IronPort-AV: E=Sophos;i="4.84,554,1355097600"; 
   d="scan'208";a="60991088"
Received: from host-92-28-160-55.as13285.net (HELO PhilipOakley) ([92.28.160.55])
  by out1.ip07ir2.opaltelecom.net with SMTP; 28 Jan 2013 20:51:56 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214871>

=46rom: "Ralf Thielow" <ralf.thielow@gmail.com>
Sent: Monday, January 28, 2013 6:13 PM
> On Mon, Jan 28, 2013 at 05:39:27PM +0100, Joachim Schmitz wrote:
>> Ralf Thielow wrote:
>> >Translate 11 new messages came from git.pot update
>> >in 46bc403 (l10n: Update git.pot (11 new, 7 removed
>> >messages)).
>> >
>> >Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> >---
>> > po/de.po | 37 ++++++++++++++++++-------------------
>> > 1 file changed, 18 insertions(+), 19 deletions(-)
>> >
>> >diff --git a/po/de.po b/po/de.po
>> >index 3779f4c..ed8330a 100644
>> >--- a/po/de.po
>> >+++ b/po/de.po
>> >@@ -5,7 +5,7 @@
>> > #
>> > msgid ""
>> > msgstr ""
>> >-"Project-Id-Version: git 1.8.1\n"
>> >+"Project-Id-Version: git 1.8.2\n"

Just noticing. Should this be s/git/Git/ to match the
* ta/doc-no-small-caps (2013-01-22) 10 commits
which is cooking?

>>
>> Not "Projekt-Id-Version ..."?
>>
>
> I don't think that we need to translate this.
>
>> > #: builtin/reset.c:33
>> > msgid "mixed"
>> >@@ -7916,9 +7915,9 @@ msgid "reset HEAD but keep local changes"
>> > msgstr "setzt Zweigspitze (HEAD) zur=FCck, beh=E4lt aber lokale
>> >=C4nderungen"
>>
>> Not "reset -> setze" and "keep" -> halte (imperativ)?
>> Or is the enlish text wrong and should be "resets" and "keeps"
>>
>
> All translations which describe an option shown by "git <command> -h"
> are (or should be) like this. The reading is like "This option..."
> followed by such a messages. That's at least how it's done. I don't=20
> think
> it sounds bad.
>
> According to the glossary, the translation here is wrong because=20
> "reset" is
> not "*zur=FCck* setzen" but "neu setzen". I'll fix this (and perhaps=20
> other
> messages) on a commit on top.
>
>> Bye, Jojo

Philip Oakley=20
