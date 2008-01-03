From: =?UTF-8?B?R3LDqWdvaXJlIEJhcmJpZXI=?= <gb@gbarbier.org>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Fri, 04 Jan 2008 00:29:29 +0100
Message-ID: <477D6FD9.20608@gbarbier.org>
References: <477822C3.9060002@gbarbier.org> <477D3401.2010005@gbarbier.org> <20080103211521.GA4225@efreet.light.src> <200801032247.02323.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 00:29:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAZVd-0004Vo-70
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 00:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbYACX3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2008 18:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbYACX3b
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 18:29:31 -0500
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:60084 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbYACX3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 18:29:30 -0500
Received: from localhost (mfilter1-v.gandi.net [217.70.178.35])
	by relay4-v.mail.gandi.net (Postfix) with ESMTP id 17B24B9FB;
	Fri,  4 Jan 2008 00:29:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter1-v.gandi.net
Received: from relay4-v.mail.gandi.net ([217.70.178.78])
	by localhost (mfilter1-v.gandi.net [217.70.178.35]) (amavisd-new, port 10024)
	with ESMTP id IpqnRRwIIe25; Fri,  4 Jan 2008 00:29:25 +0100 (CET)
Received: from [192.168.79.1] (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by relay4-v.mail.gandi.net (Postfix) with ESMTP id 082D0BA17;
	Fri,  4 Jan 2008 00:29:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <200801032247.02323.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69543>

Jakub Narebski a =C3=A9crit :
> Perhaps we could use AJAX (XMLHttpRequest for communication, plain HT=
TP or
> IFRAMES for sending data) or something like this for git protocol tun=
neling?
>  =20
well... I think I may manage to avoid javascript... ;-)
more seriously, I was thinking of using http in an automated,=20
un-human-browsable manner, not a full html user interface.

--=20
Gr=C3=A9goire Barbier - gb =C3=A0 gbarbier.org - +33 6 21 35 73 49
