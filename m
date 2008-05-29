From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: log --graph: extra space with --pretty=oneline
Date: Thu, 29 May 2008 13:25:49 +0300
Message-ID: <20080529102549.GA11074@mithlond.arda.local>
References: <20080528112405.GA12065@mithlond.arda.local> <20080529085752.GA31865@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Thu May 29 12:26:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1fLL-0006lI-QF
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 12:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbYE2KZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 06:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbYE2KZy
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 06:25:54 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:60276 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750840AbYE2KZy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 06:25:54 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 483E837C000013C1; Thu, 29 May 2008 13:25:51 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K1fKP-0006fU-KE; Thu, 29 May 2008 13:25:49 +0300
Content-Disposition: inline
In-Reply-To: <20080529085752.GA31865@adamsimpkins.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83188>


Adam Simpkins wrote (2008-05-29 01:57 -0700):

> What is everyone's preference between the 3 options?  Personally, I'm
> leaning towards Option 2.

I prefer the option 2 too. To me it never looks too ugly whereas the
other two have some broken line or buggy-ish cases.

Damn, this log --graph is so nice feature. I like it more than gitk,
regardless of the fact that I have two monitors and could easily have
gitk open and visible all the time.
