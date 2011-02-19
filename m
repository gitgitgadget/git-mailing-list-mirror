From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/3] git-p4: Improve rename detection support
Date: Sat, 19 Feb 2011 07:13:28 -0500
Message-ID: <20110219121328.GA5065@arf.padd.com>
References: <1297988600-7002-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 13:13:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqlgv-000659-KL
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 13:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab1BSMNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 07:13:33 -0500
Received: from honk.padd.com ([74.3.171.149]:36785 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267Ab1BSMNc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 07:13:32 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 4000BE77;
	Sat, 19 Feb 2011 04:13:31 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id DDAAE3198B; Sat, 19 Feb 2011 07:13:28 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1297988600-7002-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167270>

vitor.hda@gmail.com wrote on Fri, 18 Feb 2011 00:23 +0000:
> Only open files for edit after integrating if the SHA1 of source and destination
> differ from each other.
> Add git config option detectRenames to allow permanent rename detection. This
> options should be set to a true/false value.
> Rename "detectRename" variable to "detectRenames" to make it more coherent with
> the description in git man pages, which always use plural.
> 
> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>

Clean change now, thanks.

Acked-by: Pete Wyckoff <pw@padd.com>
