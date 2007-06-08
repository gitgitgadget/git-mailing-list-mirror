From: Matthijs Melchior <mmelchior@xs4all.nl>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Sat, 09 Jun 2007 00:39:20 +0200
Message-ID: <4669DA98.9070603@xs4all.nl>
References: <1181338730800-git-send-email-krh@redhat.com> <Pine.LNX.4.64.0706082249040.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 09 00:39:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwn7L-0006UE-68
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 00:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032330AbXFHWj2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Jun 2007 18:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032325AbXFHWj2
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 18:39:28 -0400
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:1933 "EHLO
	smtp-vbr5.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032100AbXFHWj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 18:39:27 -0400
Received: from [10.0.0.3] (zwaan.xs4all.nl [213.84.190.116])
	by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id l58MdLxF099477;
	Sat, 9 Jun 2007 00:39:22 +0200 (CEST)
	(envelope-from mmelchior@xs4all.nl)
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <Pine.LNX.4.64.0706082249040.4059@racer.site>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49517>

Hi,

Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 8 Jun 2007, Kristian H=C3=B8gsberg wrote:
>=20
>> A more or less straight-forward port of git-tag.sh to C.
>=20
> It is somewhat unfortunate that you did not say that you were working=
 on=20
> this stuff; we have a Google Summer of Code project going on, which t=
ries=20
> to port many scripts to builtins.
>=20
> As it happens, I am working with jasam on exactly the same script.
>=20
> Pity,
> Dscho

Please consider the idea of showing (part of) the tag annotation with
git-tag as well.

See message archived at:
   http://permalink.gmane.org/gmane.comp.version-control.git/48962

Thanks,
	Matthijs Melchior.
