From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH] Avoid warning when From: is encoded
Date: Fri, 25 Jul 2008 18:46:25 +0530
Message-ID: <20080725131625.GA11221@toroid.org>
References: <1216991208-18782-1-git-send-email-4ux6as402@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Valdemar =?iso-8859-1?Q?M=F8rch?= <4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 15:18:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMNBE-00020B-TW
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 15:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916AbYGYNQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 09:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755939AbYGYNQ3
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 09:16:29 -0400
Received: from fugue.toroid.org ([85.10.196.113]:44765 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753177AbYGYNQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 09:16:28 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 0747C5583A7;
	Fri, 25 Jul 2008 15:16:27 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 1B1C6ADC368; Fri, 25 Jul 2008 18:46:26 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <1216991208-18782-1-git-send-email-4ux6as402@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90047>

At 2008-07-25 15:06:48 +0200, 4ux6as402@sneakemail.com wrote:
>
> This is where my non-commit message goes, yeah?

Yes.

> Are there any form problems with this patch?

Looks fine to me (and also to git am).

The patch itself also looks good to me (but I'm not sure if that means I
should add an Acked-by: line to this message).

-- ams
