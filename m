From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 2/3] git-apply: complain about >=8 consecutive spaces
	in initial indent
Date: Sun, 16 Sep 2007 22:45:28 -0400
Message-ID: <20070917024528.GB24675@fieldses.org>
References: <11899829424040-git-send-email-bfields@citi.umich.edu> <11899829424173-git-send-email-bfields@citi.umich.edu> <1189982942187-git-send-email-bfields@citi.umich.edu> <46a038f90709161624j6eb55de6m61aab9e585e22a05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 04:45:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX6cC-0004hC-1H
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 04:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbXIQCpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 22:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbXIQCpb
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 22:45:31 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43107 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbXIQCpb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 22:45:31 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IX6c4-0006Zf-FU; Sun, 16 Sep 2007 22:45:28 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90709161624j6eb55de6m61aab9e585e22a05@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58375>

On Mon, Sep 17, 2007 at 11:24:12AM +1200, Martin Langhoff wrote:
> On 9/17/07, J. Bruce Fields <bfields@citi.umich.edu> wrote:
> > Complain if we find 8 spaces or more in a row as part of the initial
> > whitespace on a line, and (with --whitespace=stripspace) replace such by
> > a tab.
> 
> I do quite a bit of hacking on "spaces-for-indentation" projects and
> still use stripspace to cleanup my patches. So no, thanks.

OK, fair enough.

--b.
