From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 13:43:11 -0700
Organization: Linux Kernel Organization, Inc.
Message-ID: <48B5BC5F.4070209@kernel.org>
References: <20080826164526.GM26610@one.firstfloor.org>	<48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>	<B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu>	<20080827195019.GA9962@sigill.intra.peff.net> <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:49:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRx5-0007Fa-Q1
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603AbYH0Urg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753133AbYH0Urg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:47:36 -0400
Received: from terminus.zytor.com ([198.137.202.10]:50491 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbYH0Ure (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:47:34 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7RKhLc0028858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Aug 2008 13:43:21 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7RKhLnW019003;
	Wed, 27 Aug 2008 13:43:21 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7RKhB4h021464;
	Wed, 27 Aug 2008 13:43:12 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu>
X-Virus-Scanned: ClamAV 0.93.3/8100/Wed Aug 27 10:58:36 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93948>

Perry Wagle wrote:
>> Did you miss the part of the thread about how it's not exactly the  
>> same thing, but rather substantially fewer commands (and there is even
>> additional discussion about _which_ commands)?
> 
> I guess I did.  Being an optimist, I wouldn't expect the tab  
> completion to *lie* and leave things out.

Yes, that sounds, ahem, rude.

	-hpa
