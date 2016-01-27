From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git install Windows Server supported?
Date: Wed, 27 Jan 2016 08:32:32 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601270830080.2964@virtualbox>
References: <BEE1E8BD2C386E468098C656AB586520196D5E@ppsvr2.PP1.LOCAL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Sulzberger, Carl" <csulzberger@pandp.co.nz>
X-From: git-owner@vger.kernel.org Wed Jan 27 08:32:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOKat-0006aa-R7
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbcA0Hcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:32:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:58212 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851AbcA0Hcn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:32:43 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mecqq-1ai3Kc2GD2-00ODun; Wed, 27 Jan 2016 08:32:34
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <BEE1E8BD2C386E468098C656AB586520196D5E@ppsvr2.PP1.LOCAL>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:6piq+AASabVUp82ZdsK925pOcpvKn7yCGCvdM3H1dfRwZrt2oXm
 SpcGU7aE3C6MmAUIXB8LWl83Sot1bJtp1F3BOxc+L06DYoh8zVJcO6NXdWHdT6HY4nvfmnP
 9/OwgvCVP4+4ESlPmo7EJMPm60SqqyyVcyEK0vToByhQe7I7EjEdLy7SfFXy5k2hXKY9tw+
 b0xpSnowbn54Jv6ZKY4vA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yyawQKSseOg=:k2HIoq+c/fBYmQUqgglFnB
 JO/peVB+ITCs9sE3aHk02eZfbVZHdbmjnspDVBnyXSjulY/RSn+8PmQSV4IXL3vya8v3DrR6J
 6YRpNqBHdpfiRyonpl/P5wVh8kX6iVgjLz2M4i2XA+5gxeEOy9ZbRnUGGy4lxggzkKIPzfz9E
 8A9LNlHI2E7BzLW7CZw2teut55XBFDafnEH+nA0DA5SLZRSXz+BU8ufzMHflft985UTtw3TeS
 eFIy1HDTTZnHSTlxrfYtHZ9skdqGbVxwn/uI/EUDikO6sir0WNrR4vW7l2y0NKxSm6A5w/8wK
 c4emwef/BbPhbITgAOZH5M5bXLk7yQiBfUc6RsKrJoLxIydw/PvUOQJGe4i+4zZg7sccPPgEm
 T5bjgFWJ5s+7VeiZ7kvCyMA6m63DWQ39OlxJjK+SoyqRwss4+F3pwGCEBOwZtEE1McSOK5bNS
 UzY2k+YO+pdvhNA6OTYHnncZhvuvOPXNTwmO1E006C9RaTpeCZBuKox/rW9Y1AgrJXdhNwtWC
 hCHpzxWRQcX9gGAF7R4fJxuiX10ntz82bycU5gC3sjRfDzFKyCe6pnRyb0vIyZbUc7EwLSDwx
 XGUUp3UdpEutJZSM6X+O7SKjLPMGVL34nlex2ZvyLj/2C0KxUqxkesWXnLQ3KK62oB37rBJLQ
 O4nEKLa/OWY/n0fNiiSoJuZ1DStX5fHKQUhR363BgUcMJuahTPOgzX/zV3hy0NIBg3bgToSyT
 LvSXqMeFhBu7KOFLwPxw7lXMAA5ca4gVMIwDaPrYbTppgh+kgQHet8TTARDELA0mA5TJn8/S 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284889>

Hi Carl,

On Wed, 27 Jan 2016, Sulzberger, Carl wrote:

> Does Git support being installing on Windows Server 2008 R2 or Server
> 2012 R2 platforms as it does not list what is supported at download it
> just says Windows.

In general, we try to support every Windows version that is not past its
end-of-life. So Server 2008 R2 is supported.

There is a tiny exception to this rule: even if Windows XP is past
end-of-life, we still try to keep things working (no guarantee, though).
Note: if you need support for a certain Windows version, the safest bet is
to help support it.

Ciao,
Johannes
