From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Tue, 3 Nov 2009 16:48:57 -0800 (PST)
Message-ID: <1257295737457-3942366.post@n2.nabble.com>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com> <fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 01:49:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5U3b-0006du-3o
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 01:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbZKDAsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 19:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbZKDAsw
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 19:48:52 -0500
Received: from kuber.nabble.com ([216.139.236.158]:34808 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbZKDAsw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 19:48:52 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1N5U3V-0003Wd-Ex
	for git@vger.kernel.org; Tue, 03 Nov 2009 16:48:57 -0800
In-Reply-To: <fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com>
X-Nabble-From: Tim Mazid <timmazid@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132014>



Sverre Rabbelier-2 wrote:
> 
> On Tue, Nov 3, 2009 at 17:00, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>> At the command line, this gives you a detailed warning message, but the
>> GUI currently allows it without any fuss.
> 
> This is even better than an annoying popup dialog, as we all know
> those are just ignored anyway :).
> 

Might be better to include a configuration option to allow this, for those
that know what they're doing. Most of the people that know what they're
doing will use the command line, anyway, but it may irritate some people.
-- 
View this message in context: http://n2.nabble.com/PATCH-gitk-disable-checkout-of-remote-branch-tp3939363p3942366.html
Sent from the git mailing list archive at Nabble.com.
