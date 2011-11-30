From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Wed, 30 Nov 2011 18:00:07 -0500
Message-ID: <20111130230007.GA11598@arf.padd.com>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
 <loom.20111130T155409-599@post.gmane.org>
 <4ED6809A.9020703@diamand.org>
 <20111130225813.GA11544@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Dec 01 00:00:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVt8V-0001qE-0i
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 00:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab1K3XAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 18:00:12 -0500
Received: from honk.padd.com ([74.3.171.149]:38588 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab1K3XAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 18:00:11 -0500
Received: from arf.padd.com (unknown [50.52.169.245])
	by honk.padd.com (Postfix) with ESMTPSA id 9A40C31BF;
	Wed, 30 Nov 2011 15:00:10 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0F5FF3196F; Wed, 30 Nov 2011 18:00:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20111130225813.GA11544@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186144>

P.S.  Since you're respinning anyway to change the label code,
can you stick the 'branch with shell char' test from t9801 in
with t9803?  It feels more appropriate there than with the branch
tests.  And avoids collision with some Vitor code that will get
added eventually.

		-- Pete
