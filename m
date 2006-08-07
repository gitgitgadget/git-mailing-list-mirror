From: "Tziporet Koren" <tziporet@mellanox.co.il>
Subject: RE: Problem with clone hanging
Date: Mon, 7 Aug 2006 21:57:19 +0300
Message-ID: <6AB138A2AB8C8E4A98B9C0C3D52670E301FA761E@mtlexch01.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Aug 07 20:52:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAAD0-0005Rl-JK
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 20:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWHGSwL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 14:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWHGSwL
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 14:52:11 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:27803 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S932138AbWHGSwK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 14:52:10 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id adb87d44.2156309424.33397.00-020.p02c11o141.mxlogic.net (envelope-from <tziporet@mellanox.co.il>);
	Mon, 07 Aug 2006 12:52:10 -0600 (MDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with clone hanging
Thread-Index: Aca6RrDQtdc6NTUiSVug4PL3g69iGwAC5Bow
To: "Bryan O'Sullivan" <bos@serpentine.com>,
	"Erik Mouw" <erik@harddisk-recovery.com>
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <tziporet@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25028>

OK we will upgrade our git installation (but it will be only tomorrow)
You are correct - we have not set HTTP interface. Really we wanted that
this git will be hosted by Sandia server but their system admin has not
yet set it up.

Meanwhile I can send you all sources in a tarball if you want.

Tziporet

-----Original Message-----
From: Bryan O'Sullivan [mailto:bos@serpentine.com] 
Sent: Monday, August 07, 2006 8:22 PM
To: Erik Mouw
Cc: git@vger.kernel.org; Tziporet Koren
Subject: Re: Problem with clone hanging

On Mon, 2006-08-07 at 19:12 +0200, Erik Mouw wrote:

> Looks like the same problem that kernel.org used to have. The other
> side probably runs git-1.4.0, they should upgrade to 1.4.1.

OK, thanks for the helpful response.

>  In the mean
> time, you could clone using http and later on switch to git transport.

It seems like Mellanox doesn't publish that repository over HTTP, so I'm
stuck.  Tziporet, can you upgrade your git installation, please?

	<b
