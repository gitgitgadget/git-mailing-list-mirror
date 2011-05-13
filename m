From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/8] revert: Introduce a struct to parse command-line options into
Date: Fri, 13 May 2011 15:52:47 +0530
Message-ID: <20110513102245.GI14272@ramkum.desktop.amazon.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com> <1305100822-20470-4-git-send-email-artagnon@gmail.com> <20110511112438.GD2676@elie> <20110513093253.GD14272@ramkum.desktop.amazon.com> <20110513100722.GC30396@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 12:22:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKpWJ-00070P-Me
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 12:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758649Ab1EMKWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 06:22:51 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:12000 "EHLO
	smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758516Ab1EMKWu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 06:22:50 -0400
X-IronPort-AV: E=Sophos;i="4.64,363,1301875200"; 
   d="scan'208";a="79590563"
Received: from smtp-in-5102.iad5.amazon.com ([10.218.9.29])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 May 2011 10:22:49 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-5102.iad5.amazon.com (8.13.8/8.13.8) with ESMTP id p4DAMmYN029917;
	Fri, 13 May 2011 10:22:48 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id BC73C754841; Fri, 13 May 2011 15:52:47 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20110513100722.GC30396@elie>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173524>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > In my defense, I thought whitespace (indentation, style) changes were
> > permitted as long as I'm making a functional change.  If this isn't
> > the case, when can I correct the style/ indentation?
> 
> What I generally try to do is to only correct style and indentation
> when it is making my life difficult (either in reading or writing the
> code), through a separate commit that explains the improvement.  That
> way, a person reading the diff for a functional change doesn't have to
> be distracted by irrelevant changes.
> 
> Based on the advice he gives from time to time, Junio's policy seems
> to be that trivial cosmetic cleanups should either be very compelling
> or go at the start of a series that makes other changes to the same
> section of code.

Cool.  Start of the series then.

Thanks.

-- Ram
