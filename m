From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 05:58:30 -0700
Message-ID: <86k5iib0g9.fsf@blue.stonehenge.com>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
	<20080427064250.GA5455@sigill.intra.peff.net>
	<739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com>
	<slrng1be8l.25r.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 14:59:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqSwy-0004Jq-On
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 14:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765802AbYD1M6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 08:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765910AbYD1M6c
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 08:58:32 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:36780 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765763AbYD1M6c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 08:58:32 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 748FB1DE277; Mon, 28 Apr 2008 05:58:31 -0700 (PDT)
x-mayan-date: Long count = 12.19.15.5.2; tzolkin = 9 Ik; haab = 5 Uo
In-Reply-To: <slrng1be8l.25r.joerg@alea.gnuu.de> (=?iso-8859-1?Q?J=F6rg?=
 Sommer's message of "Mon, 28 Apr 2008 11:46:29 +0000 (UTC)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80530>

>>>>> "J=F6rg" =3D=3D J=F6rg Sommer <joerg@alea.gnuu.de> writes:

J=F6rg> What about using a shell function and a *big* variable or an in=
termediate
J=F6rg> file?

What makes you think that's any more faster or efficient than calling P=
erl
at this point?

--=20
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 =
0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl tra=
ining!
