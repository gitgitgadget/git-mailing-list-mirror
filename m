From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Migrate from svn to git
Date: Thu, 27 May 2010 08:22:11 +0200
Message-ID: <4BFE0F93.4050600@fechner.net>
References: <4BFD3AAF.4080403@fechner.net> <AANLkTikD6Op5TO0EtQWLQ0N6zD0Kr-pltW76rY1Dvx5D@mail.gmail.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 27 08:23:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHWUu-0005tX-E4
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 08:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967Ab0E0GXK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 02:23:10 -0400
Received: from anny.lostinspace.de ([80.190.182.2]:40827 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab0E0GXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 02:23:09 -0400
Received: from server.idefix.lan (ppp-93-104-103-160.dynamic.mnet-online.de [93.104.103.160])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.3/8.14.3) with ESMTP id o4R6MuL3051721
	for <git@vger.kernel.org>; Thu, 27 May 2010 08:23:00 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (unknown [127.0.0.1])
	by server.idefix.lan (Postfix) with ESMTP id C6A1463B3
	for <git@vger.kernel.org>; Thu, 27 May 2010 08:22:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at server.idefix.lan
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FIxQ5Xp32WEx for <git@vger.kernel.org>;
	Thu, 27 May 2010 08:22:11 +0200 (CEST)
Received: from dhcp-10-27-1-64.internal.epo.org (unknown [192.168.20.6])
	by server.idefix.lan (Postfix) with ESMTPA id 972506382
	for <git@vger.kernel.org>; Thu, 27 May 2010 08:22:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTikD6Op5TO0EtQWLQ0N6zD0Kr-pltW76rY1Dvx5D@mail.gmail.com>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.5 (anny.lostinspace.de [80.190.182.2]); Thu, 27 May 2010 08:23:01 +0200 (CEST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147830>

Am 26.05.10 18:23, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> There are a lot of these scripts available in contrib and elsewhere.
>   =20

thanks, i will start then in the contrib folder.
Is it possible in git to attach script like hooks in svn if someone pul=
l=20
content to the repo?

Matthias

--=20
"Programming today is a race between software engineers striving to bui=
ld bigger and better idiot-proof programs, and the universe trying to p=
roduce bigger and better idiots. So far, the universe is winning." -- R=
ich Cook
