From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH 0/6] manual: Fix or remove em dashes.
Date: Tue, 9 Oct 2007 23:52:55 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071009215255.GB3146@ins.uni-bonn.de>
References: <20071009205755.GB31317@ins.uni-bonn.de> <20071009210530.GH31317@ins.uni-bonn.de> <18071eea0710091441n717c0a99p58a9b585d15cc778@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 23:53:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfN1M-0005je-0v
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbXJIVxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 17:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbXJIVxf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:53:35 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:40657 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbXJIVxe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 17:53:34 -0400
Received: from localhost.localdomain (xdsl-87-78-163-242.netcologne.de [87.78.163.242])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 9BFF540000485;
	Tue,  9 Oct 2007 23:53:33 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1IfN0Z-0000r0-Py; Tue, 09 Oct 2007 23:52:55 +0200
Content-Disposition: inline
In-Reply-To: <18071eea0710091441n717c0a99p58a9b585d15cc778@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60451>

Hello, and sorry, this patch should be number 6/6 of course.

* Thomas Adam wrote on Tue, Oct 09, 2007 at 11:41:41PM CEST:
> On 09/10/2007, Ralf Wildenhues <Ralf.Wildenhues@gmx.de> wrote:
> > em dashes were used inconsistently in the manual.
> > This changes them to the way they are used in US English.
> 
> I find this particular patch to be rather odd; there is nothing
> invalid in the way the em-dashes are used.

No, not invalid, just inconsistent usage in the manual.

> Why is it US English is somehow de facto over, say, proper English?
> :)

Oh, that was written quoting from memory and experience.  But here's a
quote to back it up, from <http://en.wikipedia.org/wiki/Dash> as of now:

| According to most American sources (e.g., The Chicago Manual of Style)
| and to some British sources (e.g., The Oxford Guide to Style), an em
| dash should always be set closed (not surrounded by spaces). But the
| practice in many parts of the English-speaking world[...] sets it
| open [...]

No, I did not write that!  ;-)

Cheers,
Ralf
