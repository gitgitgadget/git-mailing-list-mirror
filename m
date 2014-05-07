From: Jim Garrison <jim.garrison@nwea.org>
Subject: RE: Beginner question on "Pull is mostly evil"
Date: Wed, 7 May 2014 20:30:32 +0000
Message-ID: <0C723FEB5B4E5642B25B451BA57E2730751C2AB2@S1P5DAG3C.EXCHPROD.USA.NET>
References: <0C723FEB5B4E5642B25B451BA57E2730751C2642@S1P5DAG3C.EXCHPROD.USA.NET>
 <xmqq4n119wgk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:31:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8Ue-0006TV-E4
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbaEGUbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:31:05 -0400
Received: from gwo3.mbox.net ([165.212.64.25]:53619 "EHLO gwo3.mbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbaEGUbC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2014 16:31:02 -0400
Received: from gwo3.mbox.net (localhost [127.0.0.1])
	by gwo3.mbox.net (Postfix) with ESMTP id 3gP8Zs3sY2zxjfYR;
	Wed,  7 May 2014 20:31:01 +0000 (UTC)
X-USANET-Received: from gwo3.mbox.net [127.0.0.1] by gwo3.mbox.net via mtad (C8.MAIN.3.82G) 
	with ESMTP id 745seguE69600Mo3; Wed, 07 May 2014 20:30:57 -0000
X-USANET-Routed: 5 gwsout-gwsd Q:gwsd
X-USANET-Routed: 3 gwsout-vs Q:bmvirus
X-USANET-GWS2-Tenant: nwea.org
X-USANET-GWS2-Tagid: NWEA
Received: from S1P5HUB1.EXCHPROD.USA.NET [165.212.120.254] by gwo3.mbox.net via smtad (C8.MAIN.3.96E) 
	with ESMTPS id XID977seguE64859Xo3; Wed, 07 May 2014 20:30:57 -0000
X-USANET-Source: 165.212.120.254 OUT  jim.garrison@nwea.org S1P5HUB1.EXCHPROD.USA.NET TLS
X-USANET-MsgId: XID977seguE64859Xo3
Received: from S1P5DAG3C.EXCHPROD.USA.NET ([169.254.3.187]) by
 S1P5HUB1.EXCHPROD.USA.NET ([10.120.223.31]) with mapi id 14.03.0181.006; Wed,
 7 May 2014 20:30:33 +0000
Thread-Topic: Beginner question on "Pull is mostly evil"
Thread-Index: Ac9qCIDoQWjB4uHUT6CmMgphMC+2gwAKKRkGAABDnDA=
In-Reply-To: <xmqq4n119wgk.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.98.171.2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248360>

> -----Original Message-----
> From: Junio C Hamano
> Sent: Wednesday, May 07, 2014 1:16 PM
> Subject: Re: Beginner question on "Pull is mostly evil"
> 
> No.  This is most often true for people who use a single repository as a
> place for everybody to meet, in the same way as SVN.
[snip lots of excellent detail]
> HTH.

Wow.  That helps tremendously, and should be incorporated somewhere in the
Git documentation.  Thank you for your immensely detailed response.

Apologies about not breaking lines... I'll remember that in future.
	
