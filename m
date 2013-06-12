From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH v5 00/31] Follow perlcritic's recommandations
Date: Wed, 12 Jun 2013 23:15:58 +0200
Message-ID: <51B8E50E.9070202@ensimag.fr>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr> <vpqr4g7owyi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 23:16:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmsOg-0003O2-Ol
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 23:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab3FLVP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 17:15:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57468 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755908Ab3FLVP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 17:15:58 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5CLFrRR012854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 23:15:53 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CLFuPf029884;
	Wed, 12 Jun 2013 23:15:56 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CLFtZN022266;
	Wed, 12 Jun 2013 23:15:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <vpqr4g7owyi.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 23:15:53 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227682>

Le 12/06/2013 23:12, Matthieu Moy a =E9crit :
> Which commit is this based on?
>=20
> "git am" fails, whether I try from Junio's master, next or pu. My bes=
t
> try was from da608b124c76f8f7dba8a9d8f0bc8174b9744176. It seems you'r=
e
> based on a local commit which doesn't exist on Junio's end.

Indeed, we worked on branch master of a common repository before
starting doing things properly. :/

> Most commit in-flight are in next, so I guess rebasing the series on
> next would make it easier for Junio (we normally send patches against
> master as much as possible, see SubmittingPatches for more details).

I will try to do this.


--=20
C=E9lestin Matte
