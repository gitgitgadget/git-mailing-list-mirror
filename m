From: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.fi>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Fri, 16 Oct 2009 14:23:08 +0000 (UTC)
Message-ID: <slrnhdh0ec.4du.antti-juhani@kukkaseppele.kaijanaho.fi>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
 <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <7vskdss3ei.fsf@alter.siamese.dyndns.org>
 <slrnhd0nfv.tq2.antti-juhani@kukkaseppele.kaijanaho.fi>
 <4AD80BBD.8080504@zytor.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 16:25:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MynkS-0008Gh-QL
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 16:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760377AbZJPOYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 10:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbZJPOYS
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 10:24:18 -0400
Received: from lo.gmane.org ([80.91.229.12]:52478 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760364AbZJPOYS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 10:24:18 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MyniS-0007GG-EE
	for git@vger.kernel.org; Fri, 16 Oct 2009 16:23:36 +0200
Received: from e82-103-230-151.elisa-laajakaista.fi ([82.103.230.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 16:23:36 +0200
Received: from antti-juhani by e82-103-230-151.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 16:23:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: e82-103-230-151.elisa-laajakaista.fi
User-Agent: slrn/pre1.0.0-11 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130496>

On 2009-10-16, H. Peter Anvin <hpa@zytor.com> wrote:
> 410 means "we once had it, it's no longer here, no idea where it went."
>  It's a largely useless code...

That's not a reason to forbid it methinks.  And I quite like the difference
between "oops, mistyped the URI" and "oops, that URI is no longer valid".

-- 
Mr. Antti-Juhani Kaijanaho, Jyvaskyla, Finland
