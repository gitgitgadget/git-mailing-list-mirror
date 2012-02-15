From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Bulgarian translation of git
Date: Wed, 15 Feb 2012 11:28:28 +0800
Message-ID: <CANYiYbF-M0SLP=XFkD+nEVRth05pf3hohPLyqQ75qjtNGqANMA@mail.gmail.com>
References: <75009f1d7c4aba4d62bb226ab122932c@192.168.122.10>
	<CANYiYbGr3zN-kJwq_MCnttNZP6Cc0aj-fsZjd4V=4z+BA5TvUw@mail.gmail.com>
	<7vy5s7idxb.fsf@alter.siamese.dyndns.org>
	<20120213133957.GA4838@burratino>
	<7vehtyftwf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 04:28:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxVXm-0001ed-H7
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 04:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180Ab2BOD23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 22:28:29 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53915 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757594Ab2BOD23 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 22:28:29 -0500
Received: by yenm8 with SMTP id m8so439221yen.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 19:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=45zLJE6oP3XSqC7zVQI7k0OrKb+OjJEd8xoZ8QpJoAA=;
        b=wv9gitsZDjPn0udypNflOQ6CBUxXLRcwsAc54bmdrV2dxn5MG24iYD18NsXF+RApeD
         GiFGv2UvK/NbCd/qNo2sNYwJjrOIk0E8VP7yFb1OLysBB2asAg0K2Quk2fGsI4dApO8B
         EOe6MSQ5vyVP6OUIReRIEhGtejON0y/Rvx7eE=
Received: by 10.236.139.193 with SMTP id c41mr30546339yhj.24.1329276508325;
 Tue, 14 Feb 2012 19:28:28 -0800 (PST)
Received: by 10.236.153.195 with HTTP; Tue, 14 Feb 2012 19:28:28 -0800 (PST)
In-Reply-To: <7vehtyftwf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190808>

I squash the following in the pot initial commit, and update the commit=
 log.
commit:  https://github.com/gotgit/git-po/commit/master%5E

diff --git a/Makefile b/Makefile
index 87fb3..88268 100644
--- a/Makefile
+++ b/Makefile
@@ -2576,7 +2576,6 @@ dist-doc:

 distclean: clean
        $(RM) configure
-       $(RM) po/git.pot

 clean:
        $(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o
xdiff/*.o vcs-svn/*.o \


2012/2/14 Junio C Hamano <gitster@pobox.com>:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Hopefully that would make it easier for translators to keep both
>> tracks well maintained at the same time.
>
> I somehow think it is not such a big deal if l10n messages are not
> maintained for maintenance tracks at all, actually, given that our cy=
cles
> for the master track have been 8-10 weeks long, which is not a long t=
ime
> to wait, compared to 5 years people survived without any ;-).
>



--=20
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=B2=A9=BF=CD: http://www.worldhello.net/
=CE=A2=B2=A9: http://weibo.com/gotgit/
=B5=E7=BB=B0: 010-51262007, 18601196889
