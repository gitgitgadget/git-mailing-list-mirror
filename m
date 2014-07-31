From: Yue Lin Ho <yuelinho777@gmail.com>
Subject: Re: [PATCH v2 2/2] Make locked paths absolute when current
 directory is changed
Date: Wed, 30 Jul 2014 20:01:13 -0700 (PDT)
Message-ID: <1406775673399-7616119.post@n2.nabble.com>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com> <1405858399-23082-1-git-send-email-pclouds@gmail.com> <1405858399-23082-2-git-send-email-pclouds@gmail.com> <53CD1529.9080102@ramsay1.demon.co.uk> <CACsJy8AXc4jvLPNpGyGdY9uzrnN-SbEeiksLDpS_=29gJ1KMnQ@mail.gmail.com> <xmqqr41ek5hl.fsf@gitster.dls.corp.google.com> <CACsJy8B6JpqOnbGZuKQPGrY1y8SyKzg+4aSP2iiM-Gb=3Jv5sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 05:01:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCgcI-00008J-B2
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 05:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbaGaDBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2014 23:01:14 -0400
Received: from sam.nabble.com ([216.139.236.26]:46302 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755880AbaGaDBO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2014 23:01:14 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <yuelinho777@gmail.com>)
	id 1XCgcD-0005Xr-D5
	for git@vger.kernel.org; Wed, 30 Jul 2014 20:01:13 -0700
In-Reply-To: <CACsJy8B6JpqOnbGZuKQPGrY1y8SyKzg+4aSP2iiM-Gb=3Jv5sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254537>

Hi:

> 2014-07-23 19:55 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
> On Tue, Jul 22, 2014 at 12:04 AM, Junio C Hamano <gitster@pobox.com>
> wrote:
> > Duy Nguyen <pclouds@gmail.com> writes:
=E2=80=8B[snip]=E2=80=8B
> > OK, we should center these efforts around the strbuf_getcwd() topic=
,
> > basing the other topic on realpath() and this one on it then?
>=20
> OK.
> --
> Duy

=E2=80=8BExcuse me.
How do I trace these patches applied?

I just fetch from https://github.com/gitster/git.git
Then tried to find these patches if it is applied.
(Seems not.)

Then, I took a look at
http://git.661346.n2.nabble.com/What-s-cooking-in-git-git-Jul-2014-04-T=
ue-22-td7615627.html
seems no related information there.

So, could you please tell me how to trace it?

Thank you. ^_^

Yue Lin Ho
=E2=80=8B



--
View this message in context: http://git.661346.n2.nabble.com/PATCH-Mak=
e-locked-paths-absolute-when-current-directory-is-changed-tp7615398p761=
6119.html
Sent from the git mailing list archive at Nabble.com.
