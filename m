From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Update git-gui/po/ja.po (Git-gui Japanese)
Date: Thu, 18 Jul 2013 11:27:33 -0700
Message-ID: <7v4nbr3eqy.fsf@alter.siamese.dyndns.org>
References: <CAPM==HJy65+LoJZ3A_DUuyq0LZhZQ_XpB0djMKbeSnY_PAUasw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: =?iso-2022-jp?B?GyRCMC1LYkxuNkxDY0w1GyhC?= 
	<devil.tamachan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 20:27:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzsvV-0001Fu-0N
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 20:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933262Ab3GRS1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 14:27:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932749Ab3GRS1g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 14:27:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A46A83247F;
	Thu, 18 Jul 2013 18:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1DsjDGWtJek8X9RE5gW2MAF3Yco=; b=PPYsNy
	aaKrzZOf1qKI0lMWq9zvFxPA4tiPtP7KHQ/acIJY3YbbS/raFLhO6oe9R5eRJP3x
	0rIGXbzFBmQnaLD1PmM5KPuIbJDR8yAx/OcVT5zUDa7Wn/7t9XfYiK5D9WmZ20nV
	p98fvw5PBLzduayVjPwPcPNFsQ6Co/EzgDabk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JToRXRpvEAW4WyNB3OeMoJTuQSmrWMUz
	laFLamjVI8mR+Ayo/XqEw0PYuFf/riG7VseeXrmNxtZinTRumYxxEBlO1t3cmTJZ
	F4wu+714t/kVB+OecKu/Ot7PY4IcPnjCH0XqNCgvMxJfVibtonBc4mXRPrC54z2B
	hSKpCSdFl7Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 983D13247E;
	Thu, 18 Jul 2013 18:27:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0F6B3247D;
	Thu, 18 Jul 2013 18:27:34 +0000 (UTC)
In-Reply-To: <CAPM==HJy65+LoJZ3A_DUuyq0LZhZQ_XpB0djMKbeSnY_PAUasw@mail.gmail.com>
	(=?iso-2022-jp?B?IhskQjAtS2JMbjZMQ2NMNRsoQiIncw==?= message of "Fri, 19 Jul
 2013 02:14:40 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B75F3468-EFD7-11E2-8CED-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230720>

悪魔野玉茶無  <devil.tamachan@gmail.com> writes:

I suspect that is not a name (and I somehow have suspicion that the
S-o-b is not real, either), but if you send patches as somebody that
does not match your sign-off, please add

	From: Yamada Saburo <devil.tamachan@gmail.com>

followed by a blank line at the very beginning of the e-mail body.
That will override the e-mail From: line your MUA puts in your
message and record the commit as authored by "Yamada Saburo".

> Signed-off-by: Yamada Saburo <devil.tamachan@gmail.com>
> ---

Thanks.

>  git-gui/po/ja.po | 1066 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 583 insertions(+), 483 deletions(-)
>
> diff --git a/git-gui/po/ja.po b/git-gui/po/ja.po
> index 9aff249..0bbe504 100644
> --- a/git-gui/po/ja.po
> +++ b/git-gui/po/ja.po
> @@ -7,41 +7,42 @@ msgid ""
>  msgstr ""
>  "Project-Id-Version: git-gui\n"
>  "Report-Msgid-Bugs-To: \n"
> -"POT-Creation-Date: 2010-01-26 15:47-0800\n"
> +"POT-Creation-Date: 2013-07-10 02:45+0900\n"
>  "PO-Revision-Date: 2010-02-02 19:03+0900\n"
>  "Last-Translator: しらいし ななこ <nanako3@lavabit.com>\n"

山田三郎 would be the last translater, no?

>  "Language-Team: Japanese\n"
> +"Language: \n"

What is this about????

>  "MIME-Version: 1.0\n"
>  "Content-Type: text/plain; charset=UTF-8\n"
>  "Content-Transfer-Encoding: 8bit\n"

> -#: git-gui.sh:1921
> +#: git-gui.sh:2088 git-gui.sh:2089
> +#, fuzzy
> +msgid "File type changed, old type staged for commit"
> +msgstr "ファイル型変更、コミット未予定"

If this is no longer fuzzy, please resolve it by removing "#, fuzzy"
marker.

Also, this translation seems to be incomplete.  It may be OK for
some strings (e.g. "RegExp" that seems to be a label of a checkbox
or something) to be the same as the original, but some others may
need a bit more work.

I wonder if there is a mechanism in *.po files to differentiate
between "I looked at this entry and using the original string as the
template is fine" and "I didn't translate this string, but it should
be".  I think the following entries seem to fall into the latter
category.

> -#: lib/commit.tcl:272
> +#: lib/commit.tcl:269
> +msgid ""
> +"You are about to commit on a detached head. This is a potentially dangerous "
> +"thing to do because if you switch to another branch you will lose your "
> +"changes and it can be difficult to retrieve them later from the reflog. You "
> +"should probably cancel this commit and create a new branch to continue.\n"
> +" \n"
> +" Do you really want to proceed with your Commit?"
> +msgstr ""

No translation???

> -#: lib/index.tcl:398
> +#: lib/index.tcl:380
> +#, tcl-format
> +msgid "Stage %d untracked files?"
> +msgstr ""

No translation???

> -#: lib/option.tcl:149
> +#: lib/option.tcl:151
> +msgid "Use Textconv For Diffs and Blames"
> +msgstr ""

No translation???

> -#: lib/option.tcl:153
> +#: lib/option.tcl:156
> +msgid "Additional Diff Parameters"
> +msgstr ""

No translation???

> +#: lib/option.tcl:160
> +msgid "Warn before committing to a detached head"
> +msgstr ""

No translation???

> +#: lib/option.tcl:161
> +msgid "Staging of untracked files"
> +msgstr ""

No translation???

> +#: lib/transport.tcl:25
> +msgid "fetch all remotes"
> +msgstr ""

No translation???
