From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 0 bot for Git
Date: Sun, 24 Apr 2016 09:15:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604240908200.2896@virtualbox>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com> <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com> <vpq60vnl28b.fsf@anie.imag.fr> <CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
 <vpqoa9ea7vx.fsf@anie.imag.fr> <xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com> <88CF8CB5-4105-4D0C-8064-D66092169111@gmail.com> <xmqqa8kxlbix.fsf@gitster.mtv.corp.google.com> <BF9D5A7E-CB73-4F82-8D5F-42E120D07A3B@gmail.com>
 <CAGZ79ka4WmT8NjD-04WqwczuCuJZcoKMyDRQKkRH1sT5xoqRhQ@mail.gmail.com> <DB5772D2-89D4-4D14-8FD1-4AF6DDFD77AC@gmail.com> <xmqq60vh77pt.fsf@gitster.mtv.corp.google.com> <7F130640-40F1-454F-BC00-ACC5364404B8@gmail.com>
 <xmqqr3dxpn4f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 09:19:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auEKB-0005z2-Kr
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 09:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbcDXHPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 03:15:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:54274 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbcDXHPl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 03:15:41 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M5a9E-1beUC90Rh2-00xc20; Sun, 24 Apr 2016 09:15:13
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqr3dxpn4f.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:vHcGXSEZvVPygqJwWNF17/P33IyCRZ0hLHLT9H/EfKK6N8seI81
 91hpJRj4suPOuQeaLcqVYjrln0OIANxlFtXwYX1CzNc2waA266bQ5/LkTB1IHCiELPoMkzQ
 KWVe42DYJAyn5efUez7dzS8TuPQxBOOLiRzTGX9pkHlDtnvQ4QhZyzvvAxa+k5bliQl0TeZ
 rsycEH5r1NGiOTeT8eRxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eBoh68QJizc=:rxRNQLP98ulT9DdaXd957t
 U0PXwnnwu5vGwpFCCpXbNV/OUuYcXPQ4iSXLcud6Hji8vEkidzkwvSmStfZrWZiGi+NP6KIMT
 hxqkVOj8lpY6a1kH5BFGLwzX2Gg3CtDhWBF45h/J+woFdOek7IWmNvUOkHsYOMVCxG3RCDzjg
 QHGCehkWL6W+gAkZ0ZtnariQoCu2L0/HpMXKIkp/kzpnDpYXVGTdbN1Z/RfjYMW6M39I/rHdy
 2FmFUk4OWLha0aR59qsKOpWY9g3mYKZrX743sWhtstRt3N8dnm33O553UtZIVAtVNs7euP3aM
 vha0N3QVYSRJ/YcyfuXm3cC0uPSLFbGS0A4pBTya2PaTgZBDCjVk9Ms7854KNPSJcYvFGBC97
 rXuYvcHUizSc7R0UoRqgVo6yNQ3ssO0roFC60xsjWCmvFQzq0A/BfuIl/EqN6jvO1qADAq5Z3
 83Cuv07Zn8vU+OmQu4GMt+0o3bs+Uey7hEjl7trDWo2LkYfV7WQBI94dtpSlZAEx0+3i+LsCW
 2byGUBHCXoqAo5BmIXdQ3c5ZHdW4ddh4BwOt9TzvHLdqBdt993XUU3NHHoPCfi6jQB8d0fMDR
 hGBvnxvTZhuJVpxJvMQ2QQU2rKNZrz1Ixq4ndECHOuLjIb66UT8WfjNcUayunZ0yVeb9Apy2n
 eEMtnNhDuz4x104zFxaaXmKEKwvjBeeQ+CRRrRofqNwH0SoymvgXmXheUAWlggX7Dsb7JSvT3
 fa6cFlqWcNPPqG3m+h4vjS+VSgi/gkfkcuad9O/4eKLNcBlPi7QI3nYTS9n/SOn8HLLbPzx+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292317>

Hi Lars & Junio,

On Fri, 22 Apr 2016, Junio C Hamano wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > Thanks for the explanation. My intention was not to be offensive.
> > I was curious about your workflow and I was wondering if the
> > Travis CI integration could be useful for you in any way.
> 
> Don't worry; I didn't feel offended.  The Travis stuff running on
> the branches at http://github.com/git/git would surely catch issues
> on MacOSX and/or around git-p4 (neither of which I test myself when
> merging to 'pu') before they hit 'next', and that is already helping
> us greatly.

I agree that it helps to catch those Mac and P4 issues early.

However, it is possible that bogus errors are reported that might not have
been introduced by the changes of the PR, and I find it relatively hard to
figure out the specifics. Take for example

	https://travis-ci.org/git/git/jobs/124767554

It appears that t9824 fails with my interactive rebase work on MacOSX,
both Clang and GCC versions. I currently have no access to a Mac for
developing (so I am denied my favorite debugging technique: sh t... -i -v
-x), and I seem to be unable to find any useful log of what went wrong
*specifically*.

Any ideas how to find out?

Ciao,
Dscho
