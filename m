From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TOPGIT] Resolving conflicts
Date: Mon, 1 Dec 2008 15:36:40 +0100
Message-ID: <20081201143640.GA17818@cassiopeia.tralala>
References: <20081201121819.GB13495@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	martin f krafft <madduck@debian.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Dec 01 15:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L79uv-0008Bb-1C
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbYLAOhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 09:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbYLAOhG
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:37:06 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51863 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbYLAOhF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 09:37:05 -0500
Received: from themisto.ext.pengutronix.de ([92.198.50.58] helo=cassiopeia.tralala)
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <u.kleine-koenig@pengutronix.de>)
	id 1L79tB-0002Av-GV; Mon, 01 Dec 2008 15:36:44 +0100
Content-Disposition: inline
In-Reply-To: <20081201121819.GB13495@pengutronix.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 92.198.50.58
X-SA-Exim-Mail-From: u.kleine-koenig@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=4.5 tests=AWL,BAYES_00,RCVD_IN_PBL
	shortcircuit=no autolearn=no version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102046>

[added martin f krafft to Cc:]

Hi,

> Another thing is that the exported branch contains an empty commit
> resulting from t/whatever (and a corresponding empty patch when exported
> as a quilt series)
I fixed one half of this in with a patch sent to the ML:

	http://article.gmane.org/gmane.comp.version-control.git/101728

it didn't made it upstream yet, though.

Best regards
Uwe
