From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: testing vger handling of charsets (part 1)
Date: Tue, 15 May 2007 10:58:53 -0400
Message-ID: <20070515145853.GA6794@fieldses.org>
References: <20070515test.1@coredump.intra.peff.net> <20070515083235.GE9096@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 15 16:59:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnyUP-0005qQ-SB
	for gcvg-git@gmane.org; Tue, 15 May 2007 16:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139AbXEOO64 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 10:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756177AbXEOO64
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 10:58:56 -0400
Received: from mail.fieldses.org ([66.93.2.214]:55482 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756139AbXEOO64 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 10:58:56 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HnyUH-0001tZ-Kf; Tue, 15 May 2007 10:58:53 -0400
Content-Disposition: inline
In-Reply-To: <20070515083235.GE9096@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47346>

On Tue, May 15, 2007 at 10:32:35AM +0200, Karl Hasselstr=C3=B6m wrote:
> On 2007-05-15 03:12:05 -0400, Jeff King wrote:
>=20
> > This is a test message to check how vger reacts to seeing 8bit
> > characters (like Hasselstr=C3=83=C2=B6m) in a message without the r=
ight mime
> > header. Previous attempts were eaten by the list because of a lack
> > of a message id.
>=20
> This was broken when I got it via the list, but looked good when I go=
t
> it directly.

Ditto here.  And the copy from the list had the same big warning as
before in the headers.

--b.
