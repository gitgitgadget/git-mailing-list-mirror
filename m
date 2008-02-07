From: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 18:55:24 +0000
Message-ID: <20080207185524.GB28753@bit.office.eurotux.com>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LFD.1.00.0802070949460.2732@xanadu.home> <20080207155946.GA20459@bit.office.eurotux.com> <alpine.LFD.1.00.0802071133230.2732@xanadu.home> <alpine.LSU.1.00.0802071651440.8543@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Cc: Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 19:56:28 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNBun-0003QG-8d
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 19:56:05 +0100
Received: by yw-out-2122.google.com with SMTP id 4so5142811ywc.37
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 10:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=GlSnykkun0+jFn4ES/SPXBHaNjEJNKhGvVaTKOQQ99E=;
        b=5TVpR8U3Ewgs05LTU6Hp8by+IMf8FE63FD51ZyP9CADZNyBfgPdsbbvM0M0d75V1unLzTtUGtuZO9aqSyjOA13oQk7yShY7wCDV10FbIlDf2R56LQOZ09kyObQiWZNPynn744H8fL+tXOlR1zmIQqBXcz9jHcomTnfSex/b5qB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=0TyalOqSCTlV7cZI3jvy7DDf5l9QSeGmQka23fP2UzUbO2WvyL15G1TkA2kpkT8DE/rGhd7lelbKDonfaKd95z5vz5NmQh0FAS+HvNszSS8P1GC+mudYcoKnUICMpRub6E5XpN60AnLz3qSFx8T6d2kHNueN9qU7CM2hcm4OI0U=
Received: by 10.143.34.11 with SMTP id m11mr225466wfj.23.1202410531532;
        Thu, 07 Feb 2008 10:55:31 -0800 (PST)
Received: by 10.106.78.1 with SMTP id a1gr1661prb;
	Thu, 07 Feb 2008 10:55:31 -0800 (PST)
X-Sender: luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.124.20 with SMTP id b20mr5480104pyn.5.1202410531329; Thu, 07 Feb 2008 10:55:31 -0800 (PST)
Received: from os.eurotux.com (os.eurotux.com [216.75.63.6]) by mx.google.com with ESMTP id a28si7198717pye.0.2008.02.07.10.55.30; Thu, 07 Feb 2008 10:55:31 -0800 (PST)
Received-SPF: pass (google.com: domain of luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org designates 216.75.63.6 as permitted sender) client-ip=216.75.63.6;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org designates 216.75.63.6 as permitted sender) smtp.mail=luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org
Received: (qmail 11596 invoked from network); 7 Feb 2008 18:55:29 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano-IvQC36bfUK4FrjaEzgZ1Mw@public.gmane.org) by os.eurotux.com with AES256-SHA encrypted SMTP; 7 Feb 2008 18:55:29 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802071651440.8543-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72987>



--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2008 at 04:53:43PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 7 Feb 2008, Nicolas Pitre wrote:
>=20
> > Then, simply changing the button text from "I accept" to "Continue"=20
> > should be OK?
>=20
> I consider this bike-shedding, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org being the wrong mailin=
g=20
> list to discuss this (and as a matter of fact, the msysgit list is also=
=20
> not the correct forum for discussing such legal/personal issues), and=20
> besides, the msysgit installer will not be changed in this respect.

I don't care much about that. I only installed the msysgit to have a
binary copy on my pen for using on friends' computers.

I only thought it an unnecessary step, and w/o it the barrier-to-entry
would decrease slightly, as some people are put off by EULA.

I never expect this level of hostility and I apologize if my question
sounded as offensive.

I respect the msysgit author/packager, and I thank him for his work.

--=20
Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHq1QcinSul6a7oB8RAm9uAJ9R+V7XJuQG68pM5DXYbbBK0CzitgCeOmF9
RpoqKmVshJ/8+6JU/65JUBk=
=Ib73
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
