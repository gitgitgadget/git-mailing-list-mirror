From: "Chris Ortman" <chrisortman@gmail.com>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 20:01:47 -0600
Message-ID: <c0f2d4110801151801o941d8f7i3ec11668f7948b62@mail.gmail.com>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	 <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	 <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	 <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:02:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JExbd-0000Uk-Gm
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 03:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbYAPCBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 21:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756741AbYAPCBt
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 21:01:49 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:38103 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756732AbYAPCBt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 21:01:49 -0500
Received: by nz-out-0506.google.com with SMTP id s18so84101nze.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 18:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O920JDD2aMn+ib0leViVNazpZ5KcGPlUJ1Kuqx1bhRA=;
        b=iw78AzFVSjCAvIu17AMGEprQWudKTe7hJa4mEWHH5v3HpNRbhBhr4J1Iw3yA7nABGjQEtz3Yoy2PCTXFML3UKKte+bk/wmoC6pLuwRczD4CG3HZMJGowpRBUTeUoFuePbaQLMHIsxieS3F5dD7ZhvON5SJxQcVdjoU/W4EnF684=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sDkknIMxcWByRDiRmjY+8bg6ZKnvCU2jp9TiggDfyfa2pkwaW/B6AotqsPxIV+cLoGmZDuuSOykrDeA7YnkjfjCsJNuBiLgPdd87gjlteRqm/a6xusvpW4OaAE4fd42QU3xAbDbx9MhCbXdLBhCwakPaxgU9Ns1UDFtQQHLjb5Y=
Received: by 10.114.181.1 with SMTP id d1mr254911waf.10.1200448907413;
        Tue, 15 Jan 2008 18:01:47 -0800 (PST)
Received: by 10.115.17.6 with HTTP; Tue, 15 Jan 2008 18:01:47 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70601>

I'm sorry I completely forgot there was username / password on that link
username: guest
password: ''

Tortoise does care about the line of equals signs, although it seems
like an unecessary one from my understanding.

>From the best I can tell it doesn't look like tortoise actually cares
that the svn revision be something valid, just that something is there
as a placeholder
