From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-blame.el
Date: Wed, 31 Jan 2007 10:22:51 -0800
Message-ID: <864pq7839g.fsf@blue.stonehenge.com>
References: <87iren2vqx.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Jan 31 19:23:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCK78-0005pq-B0
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 19:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbXAaSWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 31 Jan 2007 13:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbXAaSWx
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 13:22:53 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:27858 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030503AbXAaSWw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Jan 2007 13:22:52 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 290141DEC88; Wed, 31 Jan 2007 10:22:51 -0800 (PST)
x-mayan-date: Long count = 12.19.14.0.9; tzolkin = 11 Muluc; haab = 2 Pax
In-Reply-To: <87iren2vqx.fsf@morpheus.local> (David =?iso-8859-1?Q?K=E5ged?=
 =?iso-8859-1?Q?al's?= message of "Wed, 31 Jan 2007 14:04:06 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38282>

>>>>> "David" =3D=3D David K=E5gedal <davidk@lysator.liu.se> writes:

David> Here's another version of git-blame.el that automatically tries =
to
David> create a sensible list of colors to use for both light and dark
David> backgrounds.  Plus a few minor fixes.

If this gets traction, this should be what vc-annotate uses on a git fi=
le.

--=20
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 =
0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl tra=
ining!
