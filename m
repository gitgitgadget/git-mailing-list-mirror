From: Mike Hommey <mh@glandium.org>
Subject: Re: is this a bug of git-diff?
Date: Wed, 15 May 2013 12:31:32 +0200
Message-ID: <20130515103132.GA19425@glandium.org>
References: <CABwUO_X8oTzuJh8+v3Oqca2W4ht-cQRNGQ+a1DbEruq5jY+vgA@mail.gmail.com>
 <CALWbr2z338CJgavC9sVGffHSoqr0Sb9nCsr4LKURDYpkOog2TQ@mail.gmail.com>
 <CABwUO_Wyq34S=CwbLeAqmzaFLxORkvGEvrjUzMXjkJdE1jnbhA@mail.gmail.com>
 <CALWbr2z2jB53=2UsEneqymU2peiL4OW9Tyace_8BN3=1gA9jNg@mail.gmail.com>
 <vpqhai4y4b2.fsf@grenoble-inp.fr>
 <20130515095025.GV2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Antoine Pelisse <apelisse@gmail.com>,
	eric liou <accwuya@gmail.com>, git <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed May 15 12:52:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcZK5-0000hL-U6
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 12:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284Ab3EOKw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 06:52:27 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19]:59923
	"EHLO jigen.glandium.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751699Ab3EOKw0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 May 2013 06:52:26 -0400
X-Greylist: delayed 1249 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2013 06:52:26 EDT
Received: from mh by jigen.glandium.org with local (Exim 4.80)
	(envelope-from <mh@glandium.org>)
	id 1UcYzc-00059G-HL; Wed, 15 May 2013 12:31:32 +0200
Content-Disposition: inline
In-Reply-To: <20130515095025.GV2299@serenity.lan>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224397>

On Wed, May 15, 2013 at 10:50:25AM +0100, John Keeping wrote:
> On Wed, May 15, 2013 at 11:34:41AM +0200, Matthieu Moy wrote:
> > Antoine's answer is correct. In addition, I'd say that you may want to
> > enable color in the output to make it clearer (the @@ ... @@ part would
> > be colored, but not the function name):
> > 
> >   git config --global color.ui auto
> 
> I wonder if that should be the default.  I've advised a lot of people to
> turn it on and it seems to me that a user is much more likely to go
> looking for a "turn color off" option than realise that color is an
> option at all.

+1. My settings have been there for so long that I thought it was the
default.

Mike
