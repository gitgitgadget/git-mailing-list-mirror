From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Tue, 04 Dec 2007 11:00:42 +0000
Message-ID: <fj3c0q$id1$1@ger.gmane.org>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org> <e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com> <figlf6$d48$1@ger.gmane.org> <Pine.LNX.4.64.0711271747210.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 04 12:01:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzVX5-0007vc-Tk
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 12:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbXLDLBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 06:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbXLDLBX
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 06:01:23 -0500
Received: from main.gmane.org ([80.91.229.2]:40962 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbXLDLBX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 06:01:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IzVWL-0002k4-R4
	for git@vger.kernel.org; Tue, 04 Dec 2007 11:00:57 +0000
Received: from 194.70.53.227 ([194.70.53.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 11:00:57 +0000
Received: from andyparkins by 194.70.53.227 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 11:00:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 194.70.53.227
User-Agent: KNode/0.10.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67036>

Johannes Schindelin wrote:

> Tcl/Tk was easier to install on a lot more platforms in my life than Qt.

I wasn't really thinking of the install; that's a packaging problem.  I was
speaking of the toolkit itself.  I know what you mean, but I wasn't even
thinking of cross-platform in a "number of places it can run" sense.  What
I meant (although my point is irrelevant and way off the original question)
was the facilities available in the toolkit with a cross-platform
interface.

Qt puts a common face on threading, process control, networking, file
systems, internationalisation, rendering, openGL, and of course the GUI
itself.  Tcl/Tk (to take the most wicked example) gives you applications
that are much harder to make run on Windows than on UNIX.

Anyway, I don't want to sound like a strange Qt fan boy; the above is simply
my justification for putting "git-gui in Qt" on my wish list.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
