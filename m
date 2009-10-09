From: Scott Wiersdorf <scott@perlcode.org>
Subject: Re: git log -S not finding all commits?
Date: Fri, 9 Oct 2009 08:33:42 -0600
Message-ID: <20091009143341.GA50862@perlcode.org>
References: <7ae12651.522df17b.4acda0f5.21a31@o2.pl> <4ACDACE6.9060509@op5.se> <362436ca.6b5d0fc3.4acdc7e1.41b23@o2.pl> <vpqbpkixgea.fsf@bauges.imag.fr> <vpq63aqxflu.fsf@bauges.imag.fr> <86tyy9qz08.fsf@blue.stonehenge.com> <vpq1vldx7xx.fsf@bauges.imag.fr> <864oq8r795.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 16:40:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwGdj-0007iK-LE
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 16:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933364AbZJIOeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 10:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933307AbZJIOeV
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 10:34:21 -0400
Received: from deep2.securesites.net ([198.65.247.173]:3256 "EHLO
	deep2.securesites.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933203AbZJIOeU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 10:34:20 -0400
Received: from deep2.securesites.net (localhost [127.0.0.1])
	by deep2.securesites.net (8.13.6.20060614/8.13.6) with ESMTP id n99EXiuc066213
	for <git@vger.kernel.org>; Fri, 9 Oct 2009 08:33:44 -0600 (MDT)
Received: (from scott@localhost)
	by deep2.securesites.net (8.13.6.20060614/8.13.6/Submit) id n99EXiDZ066210
	for git@vger.kernel.org; Fri, 9 Oct 2009 08:33:44 -0600 (MDT)
Mail-Followup-To: Scott Wiersdorf <scott@perlcode.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <864oq8r795.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.4.2.3i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (deep2.securesites.net [127.0.0.1]); Fri, 09 Oct 2009 08:33:44 -0600 (MDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129803>

On Fri, Oct 09, 2009 at 07:07:02AM -0700, Randal L. Schwartz wrote:
> 
> Just a matter of one more switch.  Sorry for forgetting it earlier.
> 
>   .. | perl -ln0e 'print if /this/'

And I thought mine was a pretty tidy response... You *are* Japh.

Scott
-- 
Scott Wiersdorf
<scott@perlcode.org>
