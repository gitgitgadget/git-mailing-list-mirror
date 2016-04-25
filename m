From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 0 bot for Git
Date: Mon, 25 Apr 2016 16:07:00 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604251603590.2896@virtualbox>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com> <BF9D5A7E-CB73-4F82-8D5F-42E120D07A3B@gmail.com> <CAGZ79ka4WmT8NjD-04WqwczuCuJZcoKMyDRQKkRH1sT5xoqRhQ@mail.gmail.com> <DB5772D2-89D4-4D14-8FD1-4AF6DDFD77AC@gmail.com>
 <xmqq60vh77pt.fsf@gitster.mtv.corp.google.com> <7F130640-40F1-454F-BC00-ACC5364404B8@gmail.com> <xmqqr3dxpn4f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1604240908200.2896@virtualbox> <CAE5ih7-fyuEvSDzmHVfXta3hd_7ZRp1+_VtytDM+u0372Kyidg@mail.gmail.com>
 <CAE5ih7_fabo7DyZyHoxdp1Y4ygby2qwKA8E1N6MuGzHa60Wf4w@mail.gmail.com> <CAE5ih7-DzFe_3=kyan=E17zCo-iNdNdH7DE5ZwYVHmFvUBkDkA@mail.gmail.com> <CAE5ih7-d9ow0dF6wfWCkmx+HAQOzVBONGCC_U4-2bkDUZGPecQ@mail.gmail.com> <CAE5ih7_OEAWjYm9LwMAwBCtnvG+KgGo1aFuT9CyQjeN6nFmC5w@mail.gmail.com>
 <CAE5ih7-z8K5Z7HuBa=pF53b6obU60ZCxrEkTLWbaSMsg0G1Ctg@mail.gmail.com> <CAE5ih78arC2V76XR7yUoXk77c0d_z3Hzupw6MA1+saS3faXjTw@mail.gmail.com> <1C553D20-26D9-4BF2-B77E-DEAEDDE869E2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Luke Diamand <luke@diamand.org>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 16:07:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auhAm-0004XF-ED
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 16:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663AbcDYOH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 10:07:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:61350 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbcDYOH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 10:07:26 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LdHLB-1bd4TO292H-00iSlJ; Mon, 25 Apr 2016 16:07:03
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1C553D20-26D9-4BF2-B77E-DEAEDDE869E2@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:6b5z+liV501FsFVBE3sUOxs9F8HA4QcdTDceJW+w26/BLT9/F+k
 6oy28iX7xYRhI3hTk6HKGbnOH8YQcPC7pwL8OJf5TZ6Qri9gY7XltKC+xQXE2RA+HyN9sg7
 xdFg8E4cepimpQAU+zXFofLl5wSMr+0n2C+JZZ3cl74qgsdOUxQ80XIfNHfiaP9WBk9C6FH
 ydx297Nhh4F1Oqdjg+xLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zn5qw61gUoA=:/O29yuc8jpvQSkW4lb5BtG
 +FCT1bxEOaanmc9vNEdGiN75q8x5Rf2kfUBS6zvkF5Rxv4NvaoDzxH6mKIB9gXkZkbst7s9pS
 zqxLhSIUir9oIDmNMRhdo94zUjNb4xcwJOz9oeumdiZsgjO0z3tdumtgkoib0r8EdjPnZjQVU
 ve0ywTcxDauMRtUOIeCbb4uE8dsAsNfi2lWzWO01PjiNP57uhH5U+3H1lFFX1eNDNhpNcfM+a
 FLSOfqfCCCTl96oeJTHFyJvD1nUvD1kTbvcBMBBEq37t0XZp/k7q0/zDPxt/7zJHnoudOe5m2
 IupXQCtpQa9AxbeIn8xmUviucgpUZTh5OAKWJKfcLR/qn4o0e+XhHISGdAHN2hdftkwZBIG5v
 7bF3Q9COfoq7Z1dtFZJ/+lps1Mvdw3J9iCFWT8XBiSp7gNaibOpCFIZst93kPsVG7pbiLgpHR
 SooQK5qO1OGxd2+c9+xLPoVl7Y4eh9vpFbgT7i5QLPBh/T9xG9Qmjf1EFAaeBn8b2z7I1r43D
 mZr/MOCjmW2VvrK9ndKJQTJ5hBdYSRGlHIpgF3dv4gsFGz1Fh4FBShgSEDe9u5NR2DA2HjDJJ
 3CbWW+TeGKiB/R/iPQyQ8/ufp6zPqFr+DZCf5MTwFNEENvlAOkhIWV4kcYOLSCUn+ELGcfN6g
 3Of2XGi7XW/wNUtM2RAGW7rSh+1BKAyxN+5uTNqTymWHCwRPPFFx/mDYnsOJklXptR+F9hHkz
 kZIC/MJeF+noyMA0vD1/6v7+aajLHPTt40DRe8NhBoSy7/rqeJ8tHJx8IhyBk3fulRXtJGsb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292479>

Hi Lars,

On Sun, 24 Apr 2016, Lars Schneider wrote:

> [...] the current Git Travis CI OSX build always installs the latest
> versions of Git LFS and Perforce via brew [1] and the Linux build
> installs fixed versions [2].  Consequently new LFS/Perforce versions can
> brake the OS X build even if there is no change in Git.
> 
> You could argue that this is bad CI practice because CI results should
> be reproducible.  However, it has value to test the latest versions to
> detect integration errors as the one with Git LFS 1.2. We could add
> additional build jobs to test fixed versions and latest versions but
> this would just burn a lot of CPU cycles... that was the reason why I
> chose the way it is implemented right now. I will add a comment to the
> OSX build to make the current strategy more clear (Linux fixed versions,
> OS X latest versions).
> 
> What do you think about that? Do you agree/disagree? Do you see a better
> way?

I agree with your reasoning.

Ciao,
Dscho
