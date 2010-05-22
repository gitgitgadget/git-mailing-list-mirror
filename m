From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: can pre-commit hook accept user input?
Date: Fri, 21 May 2010 18:45:24 -0700
Message-ID: <20100522014524.GF16470@spearce.org>
References: <ht7co7$d0s$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sat May 22 03:45:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFdmO-0004nz-Sb
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 03:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935698Ab0EVBp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 21:45:28 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:38485 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932456Ab0EVBp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 21:45:27 -0400
Received: by pzk15 with SMTP id 15so948781pzk.15
        for <git@vger.kernel.org>; Fri, 21 May 2010 18:45:27 -0700 (PDT)
Received: by 10.142.55.18 with SMTP id d18mr1605505wfa.170.1274492726925;
        Fri, 21 May 2010 18:45:26 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id d16sm13796546wam.0.2010.05.21.18.45.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 18:45:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ht7co7$d0s$1@dough.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147504>

Neal Kreitzinger <neal@rsss.com> wrote:
> Can the pre-commit hook accept user input?

No.  None of the hooks accept user input.

-- 
Shawn.
