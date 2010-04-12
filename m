From: Eric Raymond <esr@thyrsus.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Sun, 11 Apr 2010 20:46:26 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100412004625.GA19373@thyrsus.com>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
 <l2jfabb9a1e1004111635v16e4dc86g405883ca12d316b9@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
	Jakub Narebsk <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 02:46:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O17nX-00027u-B0
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 02:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab0DLAq1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 20:46:27 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:42527
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab0DLAq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 20:46:26 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 09BC720CD3D; Sun, 11 Apr 2010 20:46:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <l2jfabb9a1e1004111635v16e4dc86g405883ca12d316b9@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144700>

Sverre Rabbelier <srabbelier@gmail.com>:
> On Mon, Apr 12, 2010 at 01:21, Julian Phillips <julian@quantumfyre.co=
=2Euk> wrote:
> > Probably the biggest change from v1 is an expanded aim. =A0Now the
> > output library is aimed at controlling _all_ plubming
> > output. =A0This series includes a patch for ls-tree that has all
> > it's output going through the library, and a patch for status that
> > has all the --porcelain output going through the library.
>=20
> I like where this is going, a lot, especially since we don't have to
> convert everything in one go, but we can do it as desired, similar to
> optparsification.

Speaking as a major customer for the new capabilities it will enable,
I strongly concur.
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>
