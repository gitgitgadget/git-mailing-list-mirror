From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCHv2 2/2] diff: add synonyms for -M, -C, -B
Date: Tue, 28 Sep 2010 16:15:27 -0500 (Central Daylight Time)
Message-ID: <alpine.WNT.2.00.1009281611310.6716@GWNotebook>
References: <FFDB2371-6C96-472C-A650-412546636450@sb.org> <1285631906-18200-2-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Sep 29 00:23:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0iaU-0008Cv-2t
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 00:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab0I1WXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 18:23:13 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:40970 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab0I1WXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 18:23:12 -0400
X-Greylist: delayed 4057 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2010 18:23:12 EDT
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWNotebook)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1P0hWQ-0005GM-9l; Tue, 28 Sep 2010 16:15:34 -0500
In-Reply-To: <1285631906-18200-2-git-send-email-kevin@sb.org>
User-Agent: Alpine 2.00 (WNT 1167 2008-08-23)
X-X-Sender: git+tbfowler.name@tbfowler.name
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157483>

Just wanted to throw support behind this patch as it is already helping 
our project to ease merging of a project that can't/won't modify some 
files that we have extensively altered.

Thanks for doing this Kevin!

Just to note:  We are using this applied to msysgit's devel branch by 
manually removing the diff.h chunk, applying the first patch, manually 
fixing diff.h, hen applying the second patch.  Which so far has worked 
just fine.

-- 
Thell
