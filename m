From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH V4] git on Mac OS and precomposed unicode
Date: Wed, 25 Jul 2012 22:45:31 +0200
Message-ID: <50105AEB.9050905@dewire.com>
References: <201201212036.57632.tboegi@web.de> <7vsjj8acmh.fsf@alter.siamese.dyndns.org> <CACsJy8BKQHLdoXfSKsULkWWbWjWEuZgr=bVNKmgCSArvwbf2UA@mail.gmail.com> <CACsJy8AucS9ez=-zej=72dr+0AVvGFR_eZgQcabitXgmQTJOCA@mail.gmail.com> <4FE73675.2000901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:45:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su8Sh-0008Jx-7v
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 22:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab2GYUpe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jul 2012 16:45:34 -0400
Received: from mail.dewire.com ([83.140.172.130]:14067 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304Ab2GYUpe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 16:45:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A93DA8FC74;
	Wed, 25 Jul 2012 22:45:32 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QCU8cBNrycg3; Wed, 25 Jul 2012 22:45:32 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (h102n2fls33o828.telia.com [213.67.12.102])
	by dewire.com (Postfix) with ESMTP id 604E48FC73;
	Wed, 25 Jul 2012 22:45:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:15.0) Gecko/20120717 Thunderbird/15.0
In-Reply-To: <4FE73675.2000901@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202194>

Torsten B=C3=B6gershausen skrev 2012-06-24 17.47:

> Do we have a motivation for pushing a solution that ignores
> the unicode composition ?

I say we do. I tried your patch and it worked fine.

> I'll send a V5 version with hopefully a better motivation

-- robin
