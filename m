From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/5] Header includes cleanup
Date: Tue, 31 Mar 2009 08:59:35 +0200
Message-ID: <200903310859.36035.chriscool@tuxfamily.org>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com> <49D0A3DF.4000203@viscovery.net> <20090330173319.GC25950@eiku.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 09:03:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoY05-00083A-9T
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 09:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbZCaHBh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 03:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbZCaHBh
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 03:01:37 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:44436 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbZCaHBg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 03:01:36 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id BDB68D480F9;
	Tue, 31 Mar 2009 09:01:27 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id D3C2BD480EE;
	Tue, 31 Mar 2009 09:01:24 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090330173319.GC25950@eiku.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115228>

Le lundi 30 mars 2009, Nathaniel P Dawson a =E9crit :
> I'm sorry, I must have misunderstood the task on the janitor
> list. Could you explain it a bit better so I would be able to do it
> properly?

Actually I added this task to the Janitor page on the wiki because I wa=
s=20
tired of having to find which other includes are needed each time I=20
include "revision.h". And I think there are other worthwile include cle=
anup=20
that could be done.

I think it's a good thing that you started working on it even if in the=
 end=20
we decide that we want these cleanup to be done otherwise. At least we =
will=20
hopefully have clarified our include header policy.

Thanks,
Christian.
