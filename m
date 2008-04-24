From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: How to fetch missing pack
Date: Thu, 24 Apr 2008 08:01:13 +0200
Message-ID: <200804240801.13674.chriscool@tuxfamily.org>
References: <slrng019fg.nd8.joerg@alea.gnuu.de> <20080413094131.GA9437@xp.machine.xx> <slrng0v8h8.ujv.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?J=C3=B6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Thu Apr 24 07:57:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JouRy-0006xC-QH
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 07:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbYDXF4G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Apr 2008 01:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbYDXF4F
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 01:56:05 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:40845 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660AbYDXF4E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Apr 2008 01:56:04 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 164001AB2E3;
	Thu, 24 Apr 2008 07:56:01 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E9F001AB2DD;
	Thu, 24 Apr 2008 07:56:00 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <slrng0v8h8.ujv.joerg@alea.gnuu.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80290>

Le mercredi 23 avril 2008, J=C3=B6rg Sommer a =C3=A9crit :
> Hi Peter,
>
> Peter Baumann <waste.manager@gmx.de> wrote:
> >
> > Try using git fsck --full to check you repo. If you are missing som=
e
> > objects, you could just grab them from another valid repo which sti=
ll
> > has them.
>
> How can I exctract single objects from a pack?

Please have a look at this:

http://git.or.cz/gitwiki/GitFaq#head-ac11406480d09e2df98588e800e41b7256=
602074

Regards,
Christian.
