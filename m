From: Christian Brabandt <cblists@256bit.org>
Subject: Re: Mark trailing whitespace error in del lines of diff
Date: Tue, 26 May 2015 19:39:10 +0200
Message-ID: <20150526173909.GC24439@256bit.org>
References: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
 <20150525222215.GI26436@vauxhall.crustytoothpaste.net>
 <xmqqbnh89r0z.fsf@gitster.dls.corp.google.com>
 <20150526162937.GA24439@256bit.org>
 <xmqqegm3l06u.fsf@gitster.dls.corp.google.com>
 <xmqq617fkztj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 19:39:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxIpO-0007NJ-V9
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 19:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbbEZRjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 13:39:42 -0400
Received: from 256bit.org ([144.76.87.176]:46469 "EHLO 256bit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbbEZRjL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 13:39:11 -0400
Received: from chrisbra by 256bit.org with local (Exim 4.76)
	(envelope-from <cblists@256bit.org>)
	id 1YxIoo-0001nK-29; Tue, 26 May 2015 19:39:10 +0200
Content-Disposition: inline
In-Reply-To: <xmqq617fkztj.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: cblists@256bit.org
X-SA-Exim-Scanned: No (on 256bit.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269958>

Hi Junio!

On Di, 26 Mai 2015, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I'll send out two patch series to do the painting part (I didn't
> > want to touch "--check", as its utility is even more dubious
> > compared to painting, at least to me).
> 
> And here is the second one.

Wow, great and so fast! I really apologize it.

Best,
Christian
