From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: recent patch breaks the build ?
Date: Thu, 17 Nov 2005 07:57:09 -0800
Message-ID: <20051117155709.GD3968@reactrix.com>
References: <437B6997.8010903@mc.com> <Pine.LNX.4.63.0511171258440.2104@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wozniak <awozniak@mc.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 17:09:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecm8n-0001Ts-6m
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 16:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVKQP5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 10:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVKQP5e
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 10:57:34 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:51620 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932182AbVKQP5d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 10:57:33 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAHFvAVm012039;
	Thu, 17 Nov 2005 07:57:10 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAHFv97O012037;
	Thu, 17 Nov 2005 07:57:09 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511171258440.2104@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12124>

On Thu, Nov 17, 2005 at 01:00:19PM +0100, Johannes Schindelin wrote:

> Note that I had no success making http-fetch work without USE_CURL_MULTI. 
> So maybe you can compile it, but maybe you experience the same problems as 
> I had.

http-fetch or http-push?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
