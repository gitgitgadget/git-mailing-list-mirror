From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Summer of Code project ideas due this Friday
Date: Fri, 11 Mar 2011 14:52:59 +0200
Message-ID: <20110311125259.GA777@LK-Perkele-VI.localdomain>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110303185918.GA18503@sigill.intra.peff.net>
 <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
 <20110303203323.GA21102@sigill.intra.peff.net>
 <20110309174956.GA22683@sigill.intra.peff.net>
 <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net>
 <4D7A1325.1090003@miseler.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Alexander Miseler <alexander@miseler.de>
X-From: git-owner@vger.kernel.org Fri Mar 11 13:50:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py1no-0000s1-SJ
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 13:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229Ab1CKMuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 07:50:35 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:38899 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225Ab1CKMuf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 07:50:35 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id DD42613BBF8;
	Fri, 11 Mar 2011 14:50:33 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0678BDB989; Fri, 11 Mar 2011 14:50:33 +0200
Received: from LK-Perkele-VI (a88-112-55-20.elisa-laajakaista.fi [88.112.55.20])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id CF3862BD49;
	Fri, 11 Mar 2011 14:50:23 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <4D7A1325.1090003@miseler.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168895>

On Fri, Mar 11, 2011 at 01:18:45PM +0100, Alexander Miseler wrote:
> On 09.03.2011 22:58, Jeff King wrote:
> >If you have any ideas, please add them to the page! Whether you are
> >available to mentor the project, or simply think it would make a good
> >project and want to inspire others to mentor it, it's appropriate to go
> >there.
> 

> Resumable clone

This is very very hard. Not so much to implement but to design the way it
can be done without assuming things (like object sort orders) that aren't
stable.

-Ilari
