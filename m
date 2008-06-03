From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 3 Jun 2008 12:40:09 +0200
Message-ID: <20080603104009.GA559@neumann>
References: <200806030314.03252.jnareb@gmail.com>
	<alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
	<7v3anv5fy3.fsf@gitster.siamese.dyndns.org>
	<7vskvv3xmx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 12:56:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3UBe-0007qW-8i
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 12:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbYFCKzZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 06:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbYFCKzZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 06:55:25 -0400
Received: from francis.fzi.de ([141.21.7.5]:32067 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751311AbYFCKzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 06:55:25 -0400
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jun 2008 06:55:24 EDT
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Jun 2008 12:40:09 +0200
Content-Disposition: inline
In-Reply-To: <7vskvv3xmx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 03 Jun 2008 10:40:09.0438 (UTC) FILETIME=[31E35FE0:01C8C566]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83636>

Junio,

On Mon, Jun 02, 2008 at 10:17:42PM -0700, Junio C Hamano wrote:
> commit: drop duplicated parents
have you actually tried the testcase 'Hand committing of a redundant
merge removes dups' that you included with this commit (67bfc03)?  It
fails at the line 'EDITOR=3D: git commit -a'.

Regards,
G=E1bor
