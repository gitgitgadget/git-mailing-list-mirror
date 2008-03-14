From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] merge-recursive: handle file mode changes
Date: Fri, 14 Mar 2008 14:02:06 +0100
Message-ID: <20080314130206.GB6157@localhost>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site> <20080313192246.GA30361@localhost> <alpine.LSU.1.00.0803132216580.4174@racer.site> <20080313224741.GA5000@localhost> <7vabl2w4co.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 14:04:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja9Yk-0006Bo-Mp
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 14:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbYCNNCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 09:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYCNNCO
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 09:02:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:33673 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbYCNNCN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 09:02:13 -0400
Received: by ug-out-1314.google.com with SMTP id z38so56939ugc.16
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 06:02:10 -0700 (PDT)
Received: by 10.66.218.15 with SMTP id q15mr349166ugg.36.1205499730350;
        Fri, 14 Mar 2008 06:02:10 -0700 (PDT)
Received: from darc.dyndns.org ( [88.117.54.52])
        by mx.google.com with ESMTPS id e1sm1504533ugf.34.2008.03.14.06.02.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 06:02:08 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Ja9Xy-0001gP-Vb; Fri, 14 Mar 2008 14:02:06 +0100
Content-Disposition: inline
In-Reply-To: <7vabl2w4co.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77217>

On Thu, Mar 13, 2008 at 05:12:39PM -0700, Junio C Hamano wrote:
> This is from the e-mail header of your message:
> 
>   Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
>    git@vger.kernel.org, gitster@pobox.com
> 
> If you are asking people question, do not do this.  You want answers
> addressed to you.  Johannes and I may not be interested in learning what
> may want to find out, and redirecting answers for you to us is simply
> rude.

My apologies. I wasn't aware that was doing that.

Clemens
