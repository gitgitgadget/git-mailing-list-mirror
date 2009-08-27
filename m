From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH v5a 1/6] fast-import: put option parsing code in seperate functions
Date: Thu, 27 Aug 2009 21:52:42 +0300
Message-ID: <87y6p5xf5x.fsf@iki.fi>
References: <1251398431-12461-1-git-send-email-srabbelier@gmail.com>
	<1251398431-12461-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 20:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgk5g-0002Jy-GH
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 20:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbZH0Sws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 14:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbZH0Sws
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 14:52:48 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:43162 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948AbZH0Swr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 14:52:47 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 4A776AE600D1F3D4; Thu, 27 Aug 2009 21:52:45 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1Mgk5S-0001GO-D9; Thu, 27 Aug 2009 21:52:42 +0300
In-Reply-To: <1251398431-12461-2-git-send-email-srabbelier@gmail.com> (Sverre
	Rabbelier's message of "Thu, 27 Aug 2009 11:40:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127198>

On 2009-08-27 11:40 (-0700), Sverre Rabbelier wrote:

> Putting the options in their own functions increases readability of
> the option parsing block and makes it easier to reuse the option
> parsing code later on.
>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>

Typo in the title:

    fast-import: put option parsing code in seperate functions
                                               ^

"separate"
