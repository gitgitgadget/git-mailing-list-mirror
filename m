From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with NO_MMAP
Date: Fri, 18 Jan 2008 09:45:53 +0000
Message-ID: <20080118094553.GB22052@hashpling.org>
References: <20080118032222.GX24004@spearce.org> <20080118035700.GA3458@spearce.org> <20080118092652.GA22052@hashpling.org> <7v8x2nh3uw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 10:46:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFno8-00017o-Pe
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 10:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbYARJqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 04:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbYARJqK
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 04:46:10 -0500
Received: from pih-relay08.plus.net ([212.159.14.134]:34334 "EHLO
	pih-relay08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbYARJqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 04:46:09 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1JFnnR-00045s-BG; Fri, 18 Jan 2008 09:45:57 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m0I9jrod000768;
	Fri, 18 Jan 2008 09:45:53 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m0I9jrJH000767;
	Fri, 18 Jan 2008 09:45:53 GMT
Content-Disposition: inline
In-Reply-To: <7v8x2nh3uw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70985>

On Fri, Jan 18, 2008 at 01:36:55AM -0800, Junio C Hamano wrote:
> 
> Well, I do not want to be picky with these things, but you do
> not own that area, so that would be "Tested-by:"
> 
> I've already committed the simplified version I suggested to
> Shawn.
> 

Sorry, I thought that Acked-by was an acceptable tag for people not
involved in the development path of a patch.  I don't want to add a
"Tested-by" as I am not a fast-import user and I am *only* reporting
the success of the test suite, not any real-world testing.

Charles.
