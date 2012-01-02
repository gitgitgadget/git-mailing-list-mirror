From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Mon, 2 Jan 2012 20:47:11 +0100
Message-ID: <20120102194711.GA25296@ecki.lan>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <20120102092508.GA10977@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 02 20:55:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhnyw-0007Fb-Aj
	for gcvg-git-2@lo.gmane.org; Mon, 02 Jan 2012 20:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920Ab2ABTzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 14:55:33 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:35381 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752234Ab2ABTzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 14:55:31 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 0AF2913004E;
	Mon,  2 Jan 2012 20:54:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120102092508.GA10977@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187842>

On Mon, Jan 02, 2012 at 03:25:08AM -0600, Jonathan Nieder wrote:
> 
> > [Subject: daemon: add tests]
> 
> Can't believe I missed this.  That seems like a worthy cause ---
> can someone remind me why this is dropped, or if there are any
> tweaks I can help with to get it picked up again?

We were discussing some open issues with patch 2/2, which was based
on the tests. I later abandoned the idea for that patch. But the
tests should be ok by themselves.

Clemens
