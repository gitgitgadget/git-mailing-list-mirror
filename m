From: =?ISO-8859-1?Q?Gr=E9goire_Barbier?= <devel@gbarbier.org>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more user-friendly
Date: Mon, 21 Jan 2008 11:27:37 +0100
Message-ID: <47947399.3000507@gbarbier.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org>	<7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>	<47946F67.5060601@gbarbier.org> <7vmyqzzdhf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 11:28:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGtt0-0004up-7k
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 11:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758354AbYAUK1m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 05:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758281AbYAUK1m
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 05:27:42 -0500
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:46236 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbYAUK1l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 05:27:41 -0500
Received: from localhost (mfilter3-v.gandi.net [217.70.178.37])
	by relay4-v.mail.gandi.net (Postfix) with ESMTP id 3E801BA1F;
	Mon, 21 Jan 2008 11:27:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter3-v.mgt.gandi.net
Received: from relay4-v.mail.gandi.net ([217.70.178.78])
	by localhost (mfilter3-v.mgt.gandi.net [217.70.178.37]) (amavisd-new, port 10024)
	with ESMTP id OSMoawsEJWxV; Mon, 21 Jan 2008 10:51:14 +0100 (CET)
Received: from [192.168.79.1] (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by relay4-v.mail.gandi.net (Postfix) with ESMTP id A894CBA26;
	Mon, 21 Jan 2008 11:27:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7vmyqzzdhf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71255>

Junio C Hamano a =E9crit :
> Thanks for correction.  I need to update Release Notes...

Curl 7.16 has been released in october 2006=20
(http://curl.haxx.se/changes.html), rather than 2003 like for 7.10.

The consequences is that a lot of not so old distributions may be=20
concerned. I only checked Fedora, which does not provide curl > 7.15=20
before Fedora 7 (issued late may 2007).

(BTW you may guess well that I'm using a Fedora Core 6 for my git=20
patches...)

--=20
Gr=E9goire Barbier - gb =E0 gbarbier.org - +33 6 21 35 73 49
