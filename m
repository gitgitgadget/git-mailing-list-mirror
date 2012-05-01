From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Newbie grief
Date: Tue, 1 May 2012 22:56:29 +0000
Message-ID: <CAMOZ1BuiznhrzEOHe0N+uu=mLEw5wWTQyDpnwG8PuF1f_aNaXw@mail.gmail.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>
 <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
 <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
 <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com>
 <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com>
 <7v62cf8v2d.fsf@alter.siamese.dyndns.org> <4FA054BA.80601@palm.com>
 <86ipgfmw05.fsf@red.stonehenge.com> <4FA05C66.2060608@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	git@vger.kernel.org
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Wed May 02 00:57:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPM0L-0005Ur-C5
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 00:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819Ab2EAW5D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 18:57:03 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63552 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564Ab2EAW5C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 18:57:02 -0400
Received: by qcro28 with SMTP id o28so18360qcr.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 15:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=roxom1IIESJUsfgJ/RW8f5WMcI55rqNgmW4K506eVjM=;
        b=SpS37SUbxTN5FmPhn/J03i5VtUfGtZx/ggXvkz/M0BbcgsL7DazAXkWimSSIFFKuk7
         cU7FzQ9wW5HqGckdFSJ2mQf708PmU4ViXXSq1iWoGBe8ofPCpBK0uX4y/StSkVBIcNTk
         UUwwoMIC2S2+7ikJTlWAmZutD3+fiJP75ze6tXRjfDBn1oBC1D/txshDpweMzmF4EUPF
         nGl2jhdEc+IRbd5h9hzaCRUYlEUIFOpMs0VNxx8O8L+uyDSKfriGb/5XdsDhT9iYLu88
         2MiTjjCOMcSg/CA9ZJuCRhi5LrRYGroke+jk4L0eRPbQAstbyzz4mFONbTvzPb96sJ73
         qdEQ==
Received: by 10.224.115.208 with SMTP id j16mr22712000qaq.84.1335913019603;
 Tue, 01 May 2012 15:56:59 -0700 (PDT)
Received: by 10.229.122.13 with HTTP; Tue, 1 May 2012 15:56:29 -0700 (PDT)
In-Reply-To: <4FA05C66.2060608@palm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196766>

On Tue, May 1, 2012 at 9:57 PM, Rich Pixley <rich.pixley@palm.com> wrot=
e:

> In contrast, I was up and using mercurial in about a day and a half,
> including all of the stuff we've discussed, and all of the things I'v=
e even
> read about in git. =C2=A0Learning mq's only took about 20 minutes.

=46ortunately, git is based on extremely simple principles.
Unfortunately, git grew out of really bright people hacking stuff
together in order to get sh!t dun; the result is not approachably or
even well documented, the UI is sometimes a bit of a kludge, the API
is probably nonexistent, and the terminology is so loosely thrown
about that it's easy to forget which way is up in discussions.
(Note, though, that Junio has done a laudable job of keeping the
whole experiment going strong).

Having recognized these deficiencies, I suggest that you provide
at least one tiny little use case that doesn't work as you'd
like; it should be in the form of a command line example that we
can all reproduce and discuss precisely.
