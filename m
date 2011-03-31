From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] system_path: use a static buffer
Date: Fri, 01 Apr 2011 01:23:34 +0200
Message-ID: <1301613826.26974.11.camel@centaur>
References: <1301582187-20340-1-git-send-email-cmn@elego.de>
	 <7voc4qhpyk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 01:24:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5RDb-0000ys-1U
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 01:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759438Ab1CaXXy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 19:23:54 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:52602 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab1CaXXx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 19:23:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 54BD11B4CC0;
	Fri,  1 Apr 2011 01:23:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PIjcBgifmAuk; Fri,  1 Apr 2011 01:23:46 +0200 (CEST)
Received: from [192.168.1.25] (brln-4db9fb82.pool.mediaWays.net [77.185.251.130])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 96C181B4CC5;
	Fri,  1 Apr 2011 01:23:45 +0200 (CEST)
In-Reply-To: <7voc4qhpyk.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.0.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170543>

On Thu, 2011-03-31 at 15:42 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> >  Slightly changed version of the patch in pu with the error strings
> > changed. Junio, do you want this patch at all. I think in your "wha=
t's
> > cooking" messages, you said you don't like this type of band-aid? A=
s
> > it's not that big a deal, I'll drop it if you don't want it.
>=20
> The "band-aid" refers to the topic listed after your topic, I think. =
 I
> didn't even have a comment on your topic in the message.

 OK, I misunderstood.

>=20
> We'll be in pre-release freeze for 1.7.5 soon, and I want to see patc=
hes
> that deal with internal clean-up held for now and resubmit after 1.7.=
5 is
> released.  This cycle lasted a bit too long but hopefully we can conc=
lude
> it by the mid April.

 Fair enough. I'll re-send after the release.

   cmn
