From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 3/4] remote prune: print the list of pruned branches
Date: Thu, 12 Jun 2008 13:07:46 +0200
Message-ID: <48510382.9000302@free.fr>
References: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr> <1213109495-6974-1-git-send-email-dkr+ml.git@free.fr> <7v63sf9lye.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 13:08:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6kfJ-00065F-Gx
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 13:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbYFLLHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 07:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbYFLLHa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 07:07:30 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:52773 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636AbYFLLHa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 07:07:30 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 048A312B6F1;
	Thu, 12 Jun 2008 13:07:29 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 9CAB212B6E6;
	Thu, 12 Jun 2008 13:07:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7v63sf9lye.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84742>

Junio C Hamano a =E9crit :
>=20
> Thanks.  I've queued the series (with minor fixups and rewording) to
> 'next' already, hoping that we can merge this fix to 'master' before
> 1.5.6.

Thanks. I find your "would prune/pruned" better.

> But I am very tempted to also apply the following on top.  Thoughts?

Actually, I did that to stay consistent with "git remote update" and, a=
s
a user, I prefer to see something. That said, I not opposed to your pat=
ch.

Olivier.
