From: madmarcos <fru574@my.utsa.edu>
Subject: Re: Java Inflater problem decompressing packfile
Date: Sat, 16 Apr 2011 07:36:16 -0700 (PDT)
Message-ID: <1302964576373-6279050.post@n2.nabble.com>
References: <1302919505984-6278154.post@n2.nabble.com> <20110416063729.GC28853@sigill.intra.peff.net> <1302963832717-6279028.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 16:36:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB6bm-0006ah-8w
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 16:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab1DPOgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 10:36:18 -0400
Received: from sam.nabble.com ([216.139.236.26]:54051 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655Ab1DPOgR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 10:36:17 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <fru574@my.utsa.edu>)
	id 1QB6bg-0006MW-CL
	for git@vger.kernel.org; Sat, 16 Apr 2011 07:36:16 -0700
In-Reply-To: <1302963832717-6279028.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171672>

1 more thing:
when it is decompressing the garbled object, it throws an "incorrect data
check" error.

--
View this message in context: http://git.661346.n2.nabble.com/Java-Inflater-problem-decompressing-packfile-tp6278154p6279050.html
Sent from the git mailing list archive at Nabble.com.
