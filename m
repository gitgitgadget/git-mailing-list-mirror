From: Ryan Tomayko <ryan@github.com>
Subject: Re: [RFC] git blame-tree
Date: Fri, 4 Mar 2011 21:41:07 -0800
Message-ID: <AANLkTinGkDga_X1gJnK_HDSNRD_F1XKWjBQm2LUxkyiM@mail.gmail.com>
References: <20110302164031.GA18233@sigill.intra.peff.net>
	<20110302171653.GA18957@sigill.intra.peff.net>
	<7vbp1tcr25.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 06:41:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvkF2-0001xr-A3
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 06:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626Ab1CEFlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 00:41:10 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54116 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab1CEFlI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 00:41:08 -0500
Received: by bwz15 with SMTP id 15so2612870bwz.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 21:41:07 -0800 (PST)
Received: by 10.204.126.131 with SMTP id c3mr733154bks.104.1299303667293; Fri,
 04 Mar 2011 21:41:07 -0800 (PST)
Received: by 10.204.55.144 with HTTP; Fri, 4 Mar 2011 21:41:07 -0800 (PST)
In-Reply-To: <7vbp1tcr25.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168480>

On Wed, Mar 2, 2011 at 10:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> It has been my opinion that the default github view that seems to be
> modeled after cvsview is the least useful choice of the default in the
> more modern git era ;-), but I guess people's eyes and brains are trained
> by the old school "file boundaries matter" way of thinking.

Junio, would you mind elaborating a bit here? I read this as "the
file tree is less interesting than the commit history", or maybe
some other view? I'm curious what would be your preference for
default view.

Ryan
