From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/2] git-p4: Add copy detection support
Date: Thu, 17 Feb 2011 10:16:57 -0800
Message-ID: <20110217181657.GA20627@honk.padd.com>
References: <1297813789-3831-1-git-send-email-vitor.hda@gmail.com>
 <1297813789-3831-2-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 19:17:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq8PY-0001Vi-Gf
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 19:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487Ab1BQSQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 13:16:59 -0500
Received: from honk.padd.com ([74.3.171.149]:40204 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757093Ab1BQSQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 13:16:58 -0500
Received: by honk.padd.com (Postfix, from userid 7770)
	id AA38220C5; Thu, 17 Feb 2011 10:16:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297813789-3831-2-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167098>

vitor.hda@gmail.com wrote on Tue, 15 Feb 2011 23:49 +0000:
> Add new config options:
>     git-p4.detectCopies         - Enable copy detection.
>     git-p4.detectCopiesHarder   - Find copies harder.
> The detectCopies option should be set to a true/false value.
> The detectCopiesHarder option should be set to true/false value.
> P4Submit can now process diff-tree C status and integrate files accordingly.

Needs sign-off.
Acked-by: Pete Wyckoff <pw@padd.com>
