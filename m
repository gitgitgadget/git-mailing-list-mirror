From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Git in nutshell Inbox
Date: Tue, 9 Jul 2013 19:38:57 +0200
Message-ID: <20130709173857.GF7038@paksenarrion.iveqy.com>
References: <CABpATRsi-Akyv_d4xHsa0AdOdw4_P5VBpoWgx=ViWpA2Q0itPw@mail.gmail.com>
 <vpq4nc3g5l5.fsf@anie.imag.fr>
 <CABpATRt1wffDN7tC3fQpqLcHgf1M6NdhANjx+jxLhN2oa2xEZQ@mail.gmail.com>
 <20130709170239.GC7038@paksenarrion.iveqy.com>
 <CABpATRsG=n1MzpPLc2u_gOmOM9G8Ym=O0j9bTuwwkUS6F6f1mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Muhammad Bashir Al-Noimi <mbnoimi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 19:38:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwbrn-0006RL-7A
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 19:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab3GIRiP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 13:38:15 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:62761 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab3GIRiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 13:38:14 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so4890491lab.7
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vDxTa+uF7QaYjgu2feTOJwl/RMHTUzy2lR0RASlXmQk=;
        b=XYvJU6Fe8IQada2UYEluXgDE/9nKjXfrBKb40YVhKsBOlYq4sZSNWfTQRs+fMKNhF/
         ML3ImmVWI1yY1917JEJjp+QKBzXRsGEv9/7B0jbHoP9gKThcRttx8Lj5IM+pqWyanULh
         AHhkdf2rqFxhHDMrkq7UHnU9ZyATPai0fLHxNOjKoFdFTXLNr3QMJO/v2D0lj2GOlfcb
         hNkv5wca0VN0EsQjPGFSDv8axgs8U+ehJMvewhCkoK5BkxeXn/3jTNJLdYN85Wf8QltQ
         JUh+sV9NTCDgkZAhBAMy6YiooUUsaVlEdesxbwdL66X578z5hu6KmAmmn35TYXwDhkX7
         F+AA==
X-Received: by 10.112.140.231 with SMTP id rj7mr13600538lbb.16.1373391492934;
        Tue, 09 Jul 2013 10:38:12 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id rx1sm9423738lbb.0.2013.07.09.10.38.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 10:38:12 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UwbsP-0006ZP-2v; Tue, 09 Jul 2013 19:38:57 +0200
Content-Disposition: inline
In-Reply-To: <CABpATRsG=n1MzpPLc2u_gOmOM9G8Ym=O0j9bTuwwkUS6F6f1mQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229972>

On Tue, Jul 09, 2013 at 07:26:57PM +0200, Muhammad Bashir Al-Noimi wrot=
e:
> On Tue, Jul 9, 2013 at 7:02 PM, Fredrik Gustafsson <iveqy@iveqy.com> =
wrote:
> > You don't need the terminal to create a new repository. When starti=
ng
> > git-cola from a non-git directory you get a menu where you can open=
 an
> > existing git-repository, clone an existing git-repository or create=
 a new one
>=20
> I'm using git-cola 1.4.3.5-1 it doesn't create a new repository it
> just open or clone. Its interface doesn't appear unless the user
> launched git repository folder

Well, I can't speak for such old version.

git-cola is about six years old and you're using a two year old release=
=2E
You miss 1/3 of all development that has been done on git-cola. I
suggest you update to a newer version. Too bad that ubuntu shipped such
old version.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
