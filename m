From: Ronan Keryell <Ronan.Keryell@hpc-project.com>
Subject: Re: Branches & directories
Date: Sun, 02 Oct 2011 19:31:57 +0200
Message-ID: <87botznvua.fsf@an-dro.info.enstb.org>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
	<CAE1pOi3OEFg7-OeQM0fvD69gf-5oPQ239CGy9nN0Waas8EM3Bg@mail.gmail.com>
	<CAMOZ1BvHKTPPmfB7Jx+y4OeRv-uwjmQkscXaRr-vEEy30G_Kdw@mail.gmail.com>
	<CAE1pOi0b2w8t53U7PSvVwVxZF9O0HTyfCR4vy+-baBjqCDeNJA@mail.gmail.com>
	<CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com>
	<CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com>
	<CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
	<CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
	<CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
	<CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
	<CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
	<CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
	<CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
	<4E889813.8070205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 19:46:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAQ7n-0007jH-SE
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 19:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736Ab1JBRqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Oct 2011 13:46:48 -0400
Received: from minou.info.enstb.org ([193.50.97.146]:60390 "EHLO
	minou.info.enstb.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab1JBRqq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2011 13:46:46 -0400
X-Greylist: delayed 868 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Oct 2011 13:46:46 EDT
Received: from an-dro.info.enstb.org (localhost [127.0.0.1])
	by minou.info.enstb.org (8.14.4/8.14.4/Debian-2) with ESMTP id p92HVxtH015861;
	Sun, 2 Oct 2011 19:32:01 +0200
In-Reply-To: <4E889813.8070205@gmail.com> (Robin Rosenberg's message of "Sun,
	02 Oct 2011 18:57:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182607>

>>>>> On Sun, 02 Oct 2011 18:57:55 +0200, Robin Rosenberg <robin.rosenb=
erg@gmail.com> said:

    Robin> Hilco Wijbenga skrev 2011-08-22 22.10:
    >> [...] I just wish there was at least an option to keep the
    >> timestamp (and possibly other such things). Even Subversion can
    >> do that... ;-) After all, not everybody uses C& make.

    Robin> What tools do you use that need the benefits from retaining
    Robin> timestamps?  The only one I can think of is clearmake, but
    Robin> then that tool goes with another SCM. Eclipse, for example,
    Robin> will be just as confused by timestamps that travel backwards
    Robin> in time, as make is.

I think of tools called "humans", very common indeed on Earth. :-)

The reward of git success is that it is not only used to develop the
Linux kernel. :-)

We use also git as a very smart repositories to store administrative
documents. It is very convenient to look at the real modification or
creation dates to figure out some historical aspects for example.

metastore is a nice tool providing a begin of this on top of git (or
whatever) but :
- this is not very convenient, needing to deal manually with these
  aspects ;
- the metadata is binary and not textual (=C3=A0 la YAML ?) so we loose=
 the
  classical textual merging candies when conflict arises on metadata
  (ouch).

It is one of my future project to do a more textual version of
metastore, but I'm afraid it is an unbound future... :-/
--=20
  Ronan KERYELL                      |\/  Phone:  +1 408 844 HPC0
  HPC Project, Inc.                  |/)  Cell:   +33 613 143 766
  5201 Great America Parkway #3241   K    Ronan.Keryell@hpc-project.com
  Santa Clara, CA 95054              |\   skype:keryell
  USA                                | \  http://hpc-project.com
