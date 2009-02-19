From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 6/6] Mention to the user that they can reorder commits
Date: Thu, 19 Feb 2009 11:16:38 +0100
Message-ID: <20090219101638.GA20707@neumann>
References: <200902190737.01121.johnflux@gmail.com>
	<53F7BA4C-6F63-4993-A959-E67E4FB4F456@frim.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pieter de Bie <pieter@frim.nl>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5yw-0003Jg-Ph
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbZBSKQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2009 05:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbZBSKQr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:16:47 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:58328 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbZBSKQq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 05:16:46 -0500
Received: from [127.0.1.1] (p5B133A54.dip0.t-ipconnect.de [91.19.58.84])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1La5xS1mTu-0006gs; Thu, 19 Feb 2009 11:16:44 +0100
Content-Disposition: inline
In-Reply-To: <53F7BA4C-6F63-4993-A959-E67E4FB4F456@frim.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1+/5oaDnEjNc3dJRFdf79bmrWguHN5haCl+RUf
 2P/LMCLMX9dOsGbUpgFLvyx7fLTYOdUWuC02AdQ5jm9+vfkQ2X
 mpVQdxxO6bu088NoXYrxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110666>

On Thu, Feb 19, 2009 at 09:13:49AM +0000, Pieter de Bie wrote:
>
> On 19 feb 2009, at 07:37, John Tapsell wrote:
>
>> Signed-off-by: John Tapsell <johnflux@gmail.com>
>> ---
>
> Yes, this has been raised many times in #git now, so it makes
> sense to include it.

A similar idea came around last week, and in turn Dscho explained why
such a change is not a good idea.  I think he is fully right here.


<alpine.DEB.1.00.0902092228470.10279@pacific.mpi-cbg.de>
http://article.gmane.org/gmane.comp.version-control.git/109136

  On Mon, Feb 09, 2009 at 10:31:56PM +0100, Johannes Schindelin wrote:
  > If we start along those lines, we also have to add documentation ho=
w
  > to
  >=20
  > - split commit,
  >=20
  > - change authorship of commits,
  >=20
  > - deal with commits where --cherry-pick did not detect that they we=
re=20
  >   applied already,
  >=20
  > - deal with merge commits, and
  >=20
  > - possibly a lot more.
  >=20
  > I do not think that this is a good way to spend valuable screen
  > estate; I=20
  > think that is what the man page should cover.
  >=20
  > I only made an exception for the deletion of lines, as people were=20
  > actively burnt.  Yes, they should have read the man page.  But the=20
  > consequences of not doing so were bad.


Regards,
G=E1bor
