From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: error opening
Date: Sat, 12 Sep 2015 11:56:52 +0200
Organization: gmx
Message-ID: <ace58f6b47c9c7096f8f30a4472433e8@dscho.org>
References: <CAF2U6N0HzgWK-4D2Ednt46u_R+eL2-2C9g9GpczyAvj+pKv-EQ@mail.gmail.com>
 <loom.20150911T232244-141@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adrian Ang <adrian.c.ang@gmail.com>,
	Renato Akaboci <renato.akaboci@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 11:57:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZahYL-0005P2-BE
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 11:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbbILJ45 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 05:56:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:62815 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023AbbILJ44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 05:56:56 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M8axL-1YeSGc2AJX-00wAKG; Sat, 12 Sep 2015 11:56:53
 +0200
In-Reply-To: <loom.20150911T232244-141@post.gmane.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:MPpoYFbzfQIq7wPKVRCkD08uusVN98bASuUCwj3bpGTFWfukSgW
 j0If8uWUNULCwc9tbP3zTn2MmZepAJAXgjbe3viqTUmYh4bHWU5/JWgCAd00kveeD/FZwkg
 0ZurBI7RRUwihDEZLKXWHVHSgdj1TxU1asI78py/X7qADudiQhSqYzSfK/2kjnotpkWtRRh
 vePHVFprfQfGUJE08AlpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4jVPcT31Mwk=:e5BoTdhYibcL63wkXCsoXE
 pOR0UN8Mqavy+Djer+DOymeJ3aDGADaeBLN5Bvwpk73xbXVxpQTpHiRPVn7PzWYdGrrOCyJtZ
 odpm4DK5ZzvycxHDJo0TER0fsY57Ipf9ter4XPezqmht3QDpm/r1irKrfo91GyJudMFahqxLZ
 tHGA5HgZ+rKmkvVsDjorrROSmbwamZEngfr4QK89ojCDvx+czOkmael1fhbJmo0jLpDqz2QZg
 hykv7Evyz8MVCTPsy3fh2hUuV7vruLpgHytgglZ0nR2Ey8eFiwxivnP9GXwerxg+qo0rttMfG
 zEGBp0Z9nt8SZ3zJhAtcA0uaC/0Jeuop1KKfhACAbg1/4mCYt8HN4u7uTfPsTpyzAA/9sdGie
 AFyjdLd1AM4hlYq6+E5GOoKwP+XH4pMwBuQw6zB9AhfStfPzdrbba/sFtxnpvTqxhs2XSsay6
 P54aQBnIuPymwmr2OohTn8aq/SdYrkvvJ3+IkbeQRuhRalktvWkXlhNXpB7xEk80UtwT6hy29
 QJUQcZEut9VJXuKVLpnyc31ODJTr8BZfJlrDIskgFQ/00ufdq8kMFBi0ANS5GdJGziSDhweBr
 5IbxpW10ENQdOgbjkSdhF7jGM3GOin4j8dg+qQZZ/YTGt1sNv0wc1nr5jAkocgr9D75XBxpnW
 ZeShQVKYop214DrjwWGVg2VQ+GhZWGWPjjOaBrFPsJ48enaEuz49r/TflsPhyzhxEP7Z6zuww
 XVR4OP1H1iwKoG36jGYy+iz0fo9gPXMnRQSxeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277719>

Hi Adrian,

please note that Renato never got your mail (you should always use repl=
y-to-all). I re-Cc:ed him, please do not forget to reply-to-all next ti=
me.

On 2015-09-11 23:33, Adrian Ang wrote:
> Renato Akaboci <renato.akaboci <at> gmail.com> writes:
>>
>> I=C2=B4m in trouble just after installation of my Git for Windows.
>> I get a box with error saying:
>>
>> couldn=C2=B4t read file "C:\Program
>> Files\Git\cmd\mingw64\libexec\git-core\git-gui": no such file or
>> directory
>=20
> I'm having the exact same problem.=20

Please see the corresponding ticket: https://github.com/git-for-windows=
/git/issues/376

In short: I will release an updated installer soon, with other fixes. I=
n the meantime, as a work-around you could right-click on the Git GUI s=
hortcut (you can right-click the icon in the Windows menu and open the =
file location to get there), select Properties... and change the Target=
: from

"C:\Program Files\Git\cmd\git-gui.exe"

to

"C:\Program Files\Git\cmd\git.exe" gui

It will open an ugly, unnecessary console until the next Git for Window=
s version is available, but at least it will work until then.

Out of curiosity: how did you go about finding the best place to report=
 this bug?

Ciao,
Johannes
