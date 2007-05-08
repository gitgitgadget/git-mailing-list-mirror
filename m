From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-clean fails to remove a file whose name contains \\, ",   or  \n, TAB, etc.
Date: Tue, 08 May 2007 16:29:07 -0700
Message-ID: <86sla699oc.fsf@blue.stonehenge.com>
References: <87ps5bhx8t.fsf@rho.meyering.net>
	<86k5vj9gzu.fsf@blue.stonehenge.com>
	<20070508231115.GA14900@efreet.light.src>
	<86wszi9a5r.fsf@blue.stonehenge.com>
	<20070508232702.GB5866@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Hudec <bulb@ucw.cz>, Jim Meyering <jim@meyering.net>,
	git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed May 09 01:29:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlZ7K-0007Go-T3
	for gcvg-git@gmane.org; Wed, 09 May 2007 01:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968622AbXEHX3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 19:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969124AbXEHX3L
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 19:29:11 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:42228 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968845AbXEHX3J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2007 19:29:09 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E85AD1DE5B6; Tue,  8 May 2007 16:29:07 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.5.6; tzolkin = 4 Cimi; haab = 14 Uo
In-Reply-To: <20070508232702.GB5866@diana.vm.bytemark.co.uk> (Karl
 =?iso-8859-1?Q?Hasselstr=F6m's?= message of "Wed, 9 May 2007 01:27:02
 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46637>

>>>>> "Karl" =3D=3D Karl Hasselstr=F6m <kha@treskal.com> writes:

Karl> Have you seen this?

Karl>   http://xkcd.com/c224.html

Yes.  You would be, oh, the 92nd person to point that out to me. :)

--=20
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 =
0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl tra=
ining!
