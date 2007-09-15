From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] rev-list --bisect: Bisection "distance" clean up.
Date: Sat, 15 Sep 2007 13:47:43 +0200
Message-ID: <200709151347.43744.chriscool@tuxfamily.org>
References: <20070915130016.eac885f4.chriscool@tuxfamily.org> <Pine.LNX.4.64.0709151215090.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 15 13:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWW0u-0005Re-Qo
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 13:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbXIOLkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Sep 2007 07:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbXIOLkg
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 07:40:36 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:59963 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbXIOLkf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2007 07:40:35 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id ACE9D1AB2E1;
	Sat, 15 Sep 2007 13:40:34 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 90F4C1AB2BC;
	Sat, 15 Sep 2007 13:40:34 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0709151215090.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58238>

Hi Dscho,

These are a bunch of cleanup patchs that I had already sent.

See:
http://thread.gmane.org/gmane.comp.version-control.git/54345
http://thread.gmane.org/gmane.comp.version-control.git/54346
http://thread.gmane.org/gmane.comp.version-control.git/54344
http://thread.gmane.org/gmane.comp.version-control.git/54347

Yeah, I should have said it somewhere, sorry about that.

Christian.

Le samedi 15 septembre 2007, Johannes Schindelin a =E9crit :
> Hi Christian,
>
> you did not provide any meaningful commit message.  I feel that this
> would be needed in this case, _especially_ since there was no cover
> letter to describe what the heck this patch series fixes.
>
> Ciao,
> Dscho
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
