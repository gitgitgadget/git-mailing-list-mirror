From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [OT] perhaps we want to support copied-context diff output
Date: Sat, 8 Dec 2007 12:10:29 +0100
Message-ID: <20071208111029.GB2844@xp.machine.xx>
References: <alpine.LFD.0.99999.0712072357050.555@xanadu.home> <7vmyslwqdr.fsf@gitster.siamese.dyndns.org> <20071208085302.GA13432@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 12:10:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0xa9-00046k-V1
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 12:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbXLHLKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 06:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbXLHLKd
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 06:10:33 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:45610 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751820AbXLHLKd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2007 06:10:33 -0500
Received: (qmail 27743 invoked by uid 0); 8 Dec 2007 11:10:31 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 8 Dec 2007 11:10:31 -0000
Content-Disposition: inline
In-Reply-To: <20071208085302.GA13432@glandium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67540>

On Sat, Dec 08, 2007 at 09:53:02AM +0100, Mike Hommey wrote:
> > Perhaps we may want to add "diff -c" (copied context) output format as
> > an option, which may be easier to read.
> 
> Or maybe use the patience diff.
> 

[... skip testcase showing a much nicer diff for human consumption ...]

AFAIR bzr uses the patience diff already. I don't actually use bzr
(obviously, because git is so much better:-) but it produces much nicer
diffs than git if you have many small changes nearby.

-Peter
