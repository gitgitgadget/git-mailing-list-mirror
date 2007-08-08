From: Pavel Roskin <proski@gnu.org>
Subject: Re: 'pu' branch for StGIT
Date: Wed, 08 Aug 2007 01:03:53 -0400
Message-ID: <1186549433.2112.34.camel@dv>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 07:04:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIdiD-0001VI-6y
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 07:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbXHHFD5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 01:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753031AbXHHFD5
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 01:03:57 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:54803 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbXHHFD4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 01:03:56 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1IIdkx-0004ey-EV
	for git@vger.kernel.org; Wed, 08 Aug 2007 01:06:51 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1IIdi5-0000wF-Lk; Wed, 08 Aug 2007 01:03:53 -0400
In-Reply-To: <20070807022043.GA8482@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.10.3 (2.10.3-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55301>

On Tue, 2007-08-07 at 04:20 +0200, Karl Hasselstr=F6m wrote:
> So I finally got my act together and published a 'pu'-like branch for
> StGIT. Get it at git://repo.or.cz/stgit/kha.git; gitweb at
> http://repo.or.cz/w/stgit/kha.git.

Just a word of warning.  This version converts all branches to version
3, so that the standard StGIT won't work with them anymore.

Also, "stg import" commits the patch, which seems wrong to me.

--=20
Regards,
Pavel Roskin
