From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 13:14:59 -0700
Organization: Linux Kernel Organization, Inc.
Message-ID: <48B46443.6000800@kernel.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>	<1219664940.9583.42.camel@pmac.infradead.org>	<alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>	<7vy72kek6y.fsf@gitster.siamese.dyndns.org>	<20080826145719.GB5046@coredump.intra.peff.net>	<1219764860.4471.13.camel@gaara.bos.redhat.com>	<1219766398.7107.87.camel@pmac.infradead.org> <20080826182349.0a1a75e2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	=?UTF-8?B?S3Jpc3RpYW4gSMO4Z3Ni?= =?UTF-8?B?ZXJn?= 
	<krh@redhat.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 22:21:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY52W-00044d-Bm
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 22:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbYHZUUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 16:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbYHZUUL
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 16:20:11 -0400
Received: from terminus.zytor.com ([198.137.202.10]:55423 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbYHZUUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 16:20:09 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7QKF7VS012197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Aug 2008 13:15:07 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7QKF7eB010173;
	Tue, 26 Aug 2008 13:15:07 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7QKExhc003239;
	Tue, 26 Aug 2008 13:15:00 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080826182349.0a1a75e2@hyperion.delvare>
X-Virus-Scanned: ClamAV 0.93.3/8093/Tue Aug 26 09:01:30 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93812>

Jean Delvare wrote:
> 
> Reducing /usr/bin in size was totally worthwhile. Maybe not to you, but
> to the silent majority I am a proud member of, it was. (I'm not saying
> that the path that was taken to get there was optimal, just that the
> goal was sound.)
> 

You keep trying to use the Nixon argument ("silent majority.")  You *do* 
know that it was a rhetorical device used by Nixon's speechwriters to 
push ahead with policies despite compact opposition, don't you?

As far as I can tell, most of the arguments in favour came from fanbois 
of $OTHER_SCM which went along the lines of "why does git need all this 
stuff in /usr/bin, when $OTHER_SCM doesn't?"  It had nothing to do with 
reality, of course; it was just a difference between git and $OTHER_SCM 
which they choose to pick on.

	-hpa
