From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date: Mon, 14 May 2007 14:39:31 -0400
Message-ID: <20070514183931.GC23090@fieldses.org>
References: <20070514181943.GA31749@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon May 14 20:39:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnfSR-0003sG-Hw
	for gcvg-git@gmane.org; Mon, 14 May 2007 20:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757746AbXENSjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 14 May 2007 14:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758454AbXENSjf
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 14:39:35 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57746 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757783AbXENSje (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 14:39:34 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HnfSF-00081k-AU; Mon, 14 May 2007 14:39:31 -0400
Content-Disposition: inline
In-Reply-To: <20070514181943.GA31749@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47284>

On Mon, May 14, 2007 at 08:19:43PM +0200, Karl Hasselstr=F6m wrote:
> On 2007-05-14 11:21:20 -0400, J. Bruce Fields wrote:
>=20
> > It includes modifications as suggested by J. Bruce Fields, Karl
> > Hasselstr=C3=B6m and Daniel Barkalow.
>=20
> Agh! utf8/latin1 confusion! Your mail is in latin1, but you've used
> the utf8 byte sequence for my name.
>=20
> Hmm. Maybe I should keep quiet, so people won't start dropping my nam=
e
> completely just to get rid of my complaints. :-)

No, I appreciate the complaint, I just don't know what to do about
it--as far as I can tell, I've chosen utf-8 everywhere I can: my commit=
s
are in utf-8, and "locale" run from the shell reports everything as
"en_US.UTF-8".  But I suspect the problem is on my end somewhere--do I
need to do something to make sure mail I send gets a header identifying
it as utf-8 and not iso-8859-1?  I'll investigate some more tonight if =
I
get the chance; any advice welcomed.

--b.
