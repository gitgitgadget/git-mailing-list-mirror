From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v2 6/6] receive-pack: Send hook output over side band #2
Date: Tue, 9 Feb 2010 11:52:07 -0500
Message-ID: <20100209165207.GA12030@cthulhu>
References: <1265403462-20572-1-git-send-email-spearce@spearce.org>
 <1265403462-20572-7-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 17:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NetJw-0005yq-Cq
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 17:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab0BIQwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 11:52:09 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:39820 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab0BIQwI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 11:52:08 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 7E0F582200E; Tue,  9 Feb 2010 11:52:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1265403462-20572-7-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139413>


This breaks t5401.  See <7v4olqlva7.fsf@alter.siamese.dyndns.org> in another thread.

     --larry
