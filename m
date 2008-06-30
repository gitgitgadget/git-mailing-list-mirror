From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] Make default expiration period of reflog used for stash
 infinite
Date: Tue, 01 Jul 2008 01:45:16 +0200
Message-ID: <4869700C.6060803@free.fr>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org> <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.o
 rg> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7v3amweiaz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 01:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDT4K-00035T-FV
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 01:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbYF3XpD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 19:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbYF3XpD
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 19:45:03 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:51711 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbYF3XpC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 19:45:02 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 0232F12B6C6;
	Tue,  1 Jul 2008 01:45:01 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id CDAE212B6C5;
	Tue,  1 Jul 2008 01:45:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7v3amweiaz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86970>

Junio C Hamano a =E9crit :
> This makes the default expiration period for the reflog that implemen=
ts
> stash infinite.

I did not read the whole thread so maybe I missed something but I thoug=
h you
wanted to apply Nanako's patch before?

The patch: http://article.gmane.org/gmane.comp.version-control.git/8505=
5

Olivier.
