From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: 'pu' branch for StGIT
Date: Mon, 6 Aug 2007 22:38:36 -0400
Message-ID: <20070807023836.GN9527@spearce.org>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Pavel Roskin <proski@gnu.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 04:39:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIEyQ-0003iB-RM
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765680AbXHGCit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 22:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765752AbXHGCit
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:38:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59838 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765658AbXHGCis (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 22:38:48 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IIExm-0008VE-V8; Mon, 06 Aug 2007 22:38:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 054E220FBAE; Mon,  6 Aug 2007 22:38:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070807022043.GA8482@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55200>

Karl Hasselstrm <kha@treskal.com> wrote:
> (Does anyone know the incantation for Junio's status mails, with topic
> branches grouped nicely?)

Look at his todo branch; one of those scripts does the magic.
Start with todo:WC, apparently it calls todo:git-topic.perl.
Junio checks out the todo branch in a Meta/ subdirectory.  :-)

-- 
Shawn.
