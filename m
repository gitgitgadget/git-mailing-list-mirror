From: Laurent Arnoud <laurent@spkdev.net>
Subject: Re: [PATCH] Add the tag.gpgsign option to sign all created tags
Date: Sun, 20 Mar 2016 18:44:34 +0100
Message-ID: <20160320174434.GB20083@spk-laptop>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
 <20160320122023.GA5139@spk-laptop>
 <20160320165216.GA5710@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 18:44:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahhP9-0006c1-LB
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 18:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbcCTRok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 13:44:40 -0400
Received: from ns3268618.ip-5-39-81.eu ([5.39.81.144]:53835 "EHLO
	mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbcCTRoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 13:44:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.spkdev.net (Postfix) with ESMTPSA id DB950FF1D1;
	Sun, 20 Mar 2016 17:44:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160320165216.GA5710@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289371>

On Sun, Mar 20, 2016 at 12:52:17PM -0400, Jeff King wrote:
> That behavior makes more sense to me, but I don't think it's what your
> patch does (v1 or v2). Perhaps it would make sense to add some tests,
> both to verify that it is behaving as expected, and to protect that
> behavior from future changes?

Yes, I will try to do so during the week.

Cheers,

-- 
Laurent
