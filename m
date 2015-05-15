From: Dror Levy <drorlevy@live.com>
Subject: Re: Bug when merging non normalized branch with normalized branch using the -X theirs -X renormalize options
Date: Fri, 15 May 2015 14:14:01 +0000 (UTC)
Message-ID: <loom.20150515T160501-69@post.gmane.org>
References: <loom.20150515T153902-500@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 16:14:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtGNU-0006OR-8X
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 16:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422993AbbEOOOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 10:14:12 -0400
Received: from plane.gmane.org ([80.91.229.3]:33871 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422669AbbEOOOK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 10:14:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YtGNM-0006Kn-71
	for git@vger.kernel.org; Fri, 15 May 2015 16:14:08 +0200
Received: from mail.tradologic.com ([77.70.98.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2015 16:14:08 +0200
Received: from drorlevy by mail.tradologic.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2015 16:14:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 77.70.98.102 (Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269143>

Using git version 1.9.5.msysgit.1
