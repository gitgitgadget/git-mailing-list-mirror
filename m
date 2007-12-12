From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] git-help: add "web_or_man" and "web_or_info" config vars.
Date: Wed, 12 Dec 2007 08:17:33 +0100
Message-ID: <200712120817.33308.chriscool@tuxfamily.org>
References: <20071212063325.92cd29a8.chriscool@tuxfamily.org> <7v1w9sbhlg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 08:11:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Lkm-0006Nj-Tm
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 08:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbXLLHLO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 02:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbXLLHLO
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 02:11:14 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:54099 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbXLLHLO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 02:11:14 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 08CC11AB2BA;
	Wed, 12 Dec 2007 08:11:13 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id DFCBD1AB2B8;
	Wed, 12 Dec 2007 08:11:12 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7v1w9sbhlg.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68001>

Le mercredi 12 d=E9cembre 2007, Junio C Hamano a =E9crit :
> I personally feel this is going a bit overboard.=20

The main problem without it is for people who like web browser, but oft=
en=20
use ssh without -Y. In this latter case, they may enter into "manly" mo=
de,=20
you know, and don't want to be bothered to install or use some kind of =
text=20
based web browser.

Christian.
