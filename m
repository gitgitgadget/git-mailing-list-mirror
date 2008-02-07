From: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 18:59:23 +0000
Message-ID: <20080207185923.GC28753@bit.office.eurotux.com>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site> <7v1w7ooes3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802071831520.8543@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 20:00:11 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.248])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNByd-0004qI-8e
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 20:00:03 +0100
Received: by wa-out-0708.google.com with SMTP id n36so6619404wag.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 10:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=mnA/YXp78pYG5OsQlyAGORByY98/ZPBBUGZJypykdAo=;
        b=xMcAEcmyRRT/Ys2airykdxGBxnKBbgVjzDL3Mgwso0NOx3DBGS5Z7OlKmCtu3/QRJaQJHQ2d0j875QAxHYIlTT7j40iloZzDugZ+5sod98/kBB3jmr1x48BKguBFM4e2EeSF8tg1VYZbihzx7vN6o2bRget88BgX23J/txUVdpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=ioKBWDIFNqZOSioMeelrSUQItfBP/BxxHHLkYnNPFWzzpVZblPxa1BU8wbaFWJ5dbka4TY7nt6pa/bFQ2uilVLrFqYDKlnBsftoOpDYx7BD8GbVP+a0H8E4cwm3TgnuVUHS0KpsbGp6R6kbZTkE4Box9XgwUhpWF2C0V5xfO0rY=
Received: by 10.114.113.1 with SMTP id l1mr818051wac.23.1202410771092;
        Thu, 07 Feb 2008 10:59:31 -0800 (PST)
Received: by 10.107.168.22 with SMTP id v22gr1662pro;
	Thu, 07 Feb 2008 10:59:31 -0800 (PST)
X-Sender: luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.108.12 with SMTP id k12mr25577366pym.3.1202410770887; Thu, 07 Feb 2008 10:59:30 -0800 (PST)
Received: from os.eurotux.com (os.eurotux.com [216.75.63.6]) by mx.google.com with ESMTP id z53si7226537pyg.1.2008.02.07.10.59.30; Thu, 07 Feb 2008 10:59:30 -0800 (PST)
Received-SPF: pass (google.com: domain of luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org designates 216.75.63.6 as permitted sender) client-ip=216.75.63.6;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org designates 216.75.63.6 as permitted sender) smtp.mail=luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org
Received: (qmail 14619 invoked from network); 7 Feb 2008 18:59:28 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano-IvQC36bfUK4FrjaEzgZ1Mw@public.gmane.org) by os.eurotux.com with AES256-SHA encrypted SMTP; 7 Feb 2008 18:59:28 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802071831520.8543-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72988>



--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2008 at 06:40:28PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 7 Feb 2008, Junio C Hamano wrote:
>=20
> > Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org> writes:
> >=20
> > > Besides, if you do not like that our installer shows the GPL, just go=
 and=20
> > > make your own (but be sure to shell out money to your lawyer of choic=
e to=20
> > > confirm that the GPL allows you to do that).
> > >
> > > The Git installer of msysGit will always show the GPL, and have the u=
ser=20
> > > accept it.
> >=20
> > I may be missing the details because I do not do Windows myself,
> > but if you are discussing the "end user binary distribution"
> > one, then I think:
> >=20
> >  * It is a mistake if you do not to show GPL, as you are
> >    redistributing GPL code in a binary form and you need to tell
> >    the end user his rights (e.g. he can request source for it,
> >    the source is found at a well known location, etc.)
> >=20
> >  * The restriction on redistribution of modified program would
> >    probably not apply (unless the receiver hacks binary) to most
> >    casual users, so making the label say "I Accept" feels a bit
> >    silly (but still is technically correct).  As Nico suggested,
> >    "Continue" may be fine here, as long as the message already
> >    says "this program is distributed under this license you are
> >    looking at".
> >=20
> > I recall you had another installer that gives the full
> > development environment for hack on "git" with a clone of the
> > git repository.  I do not know if you still offer that
> > installer, but "I Accept" would be very appropriate for that
> > one.
>=20
> Yes, the full installer does not (yet) ask for acceptance of the GPL,=20
> basically because I am too lazy, and also because I expect developers to=
=20
> actually read the notices in the copyright section in the source code,=20
> should they modify the source.
>=20
> The reasoning for showing the GPL in the Git installer I cannot explain,=
=20
> because I was not part of it.  However, I am very much in favour, for two=
=20
> reasons:
>=20
> - the end users should really know that the software is licensed in a=20
>   pretty free way.  Most of the users will have read about "the GPL", and=
=20
>   know what it says without reading it.  Others may see it for the first=
=20
>   time, and be astonished that such a license exists, and actually covers=
=20
>   a useful program.
>=20
> - _every_ serious Windows program comes with a click-through license.  We=
=20
>   just don't want to be left behind.
>=20
> - even if it would be not necessary to accept the license (which I am not=
=20
>   at all sure about, but do not care enough to learn about it, either), I=
=20
>   am not amused by somebody I do not know of, and who did not share=20
>   anything with me that I know of, asking me to remove that license=20
>   dialog.

I beg your pardon? I never asked you such thing. My first e-mail was,
verbatim:
-- begin --
Why do I have to accept the GPL to install msysgit?

Only the "NO WARRANTY ..." should be required, GPL is only required for
distribution (and you could make that information available at install).
-- end --

Any next e-mail in reply to this thread, from me, were only suggestions
and reasonings for *not requiring acceptance*, not for removing the
screen.



>   If you are not okay with accepting a tit-for-tat license, well... I'll=
=20
>   not give you "tat".

I never said I was. I mean, would I had sent a patch to this list if I
wasn't OK with the license?

> So there is really nothing that I can think of, which would change my min=
d=20
> about that "issue".

I was asking for the reasons for the installer being like it is, not for
you to change your mind.

--=20
Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHq1ULinSul6a7oB8RAnWQAKCI2PUbR9p0hyFW0UQveW3Tj7+n9gCfSV6X
jxenJxXHqq+wT9722QPE1yc=
=HgLg
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
