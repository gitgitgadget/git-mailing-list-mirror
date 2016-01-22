From: Ashish Yadav <ashish.yadav@firemon.com>
Subject: Re: git versions
Date: Fri, 22 Jan 2016 22:52:47 +0000
Message-ID: <D2C80EAC.13C5A%ashish.yadav@firemon.com>
References: <vpqk2n1z15o.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 23:52:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkZY-0003dX-OO
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbcAVWwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 17:52:49 -0500
Received: from smtp74.ord1c.emailsrvr.com ([108.166.43.74]:57714 "EHLO
	smtp74.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753686AbcAVWws convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:52:48 -0500
Received: from smtp18.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp18.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id E25EF28019F;
	Fri, 22 Jan 2016 17:52:47 -0500 (EST)
Received: from smtp192.mex05.mlsrvr.com (unknown [184.106.31.85])
	by smtp18.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTPS id D6BDC28018A;
	Fri, 22 Jan 2016 17:52:47 -0500 (EST)
X-Sender-Id: ashish.yadav@firemon.com
Received: from smtp192.mex05.mlsrvr.com ([UNAVAILABLE]. [184.106.31.85])
	(using TLSv1 with cipher AES256-SHA)
	by 0.0.0.0:25 (trex/5.5.4);
	Fri, 22 Jan 2016 17:52:47 -0500
Received: from ORD2MBX05E.mex05.mlsrvr.com ([fe80::d47d:20ff:fe52:4153]) by
 ORD2HUB16.mex05.mlsrvr.com ([fe80::be30:5bff:feee:c7c4%15]) with mapi id
 14.03.0235.001; Fri, 22 Jan 2016 16:52:47 -0600
Thread-Topic: git versions
Thread-Index: AQHRVWY0qcxDeHVG902CnDTpSsWe0Z8IJGsA
In-Reply-To: <vpqk2n1z15o.fsf@anie.imag.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [64.126.49.102]
Content-ID: <A8E03F4621F68E42821C2557676F691C@mex05.mlsrvr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284606>

Thanks.

I just wanted to know if I can upgrade straight from v1.7.1-3 to v2.7 or
do I need to upgrade to an intermediate version.


On 1/22/16, 4:42 PM, "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr> wrote:

>Jeff King <peff@peff.net> writes:
>
>> On Fri, Jan 22, 2016 at 05:15:23PM +0000, Ashish Yadav wrote:
>>
>>> I am using git v1.7.12.4 w CentOS 6.5. Can I upgrade 1.7.1-3 to 2.7?
>>
>> Probably. :)
>
>Surely ;-).
>
>I have a CentOS 6.5 with Git 2.6 on it. It was installed from source
>(I'm not the one who installed it, but I think the installation was
>rather painless).
>
>On the other hand, I don't think you'll find an RPM package, you'll need
>to compile it yourself.
>
>-- 
>Matthieu Moy
>http://www-verimag.imag.fr/~moy/
