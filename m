From: Jody McIntyre <scjody@sun.com>
Subject: Re: 'git pull' fails with 'not uptodate' message despite 'git	reset
 --hard'
Date: Thu, 30 Jul 2009 11:40:40 -0400
Message-ID: <20090730154040.GI22281@clouds>
References: <20090728230842.GE22281@clouds>
 <32541b130907281719y57862c25w524f5bbf1df11c40@mail.gmail.com>
 <20090729203637.GF22281@clouds>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 17:41:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWXkf-000152-Pp
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 17:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbZG3Pkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 11:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbZG3Pkp
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 11:40:45 -0400
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:54059 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZG3Pko (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 11:40:44 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n6UFegPk014270
	for <git@vger.kernel.org>; Thu, 30 Jul 2009 08:40:44 -0700 (PDT)
Content-disposition: inline
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java(tm) System Messaging Server 7u2-7.02 64bit (built Apr 16 2009))
 id <0KNL00C00Q0EPU00@fe-sfbay-09.sun.com> for git@vger.kernel.org; Thu,
 30 Jul 2009 08:40:42 -0700 (PDT)
Received: from shinkansen.modernduck.com ([unknown] [24.37.153.200])
 by fe-sfbay-09.sun.com
 (Sun Java(tm) System Messaging Server 7u2-7.02 64bit (built Apr 16 2009))
 with ESMTPSA id <0KNL004EFQ7SC840@fe-sfbay-09.sun.com>; Thu,
 30 Jul 2009 08:40:42 -0700 (PDT)
Received: by shinkansen.modernduck.com (sSMTP sendmail emulation); Thu,
 30 Jul 2009 11:40:40 -0400
In-reply-to: <20090729203637.GF22281@clouds>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124464>

On Wed, Jul 29, 2009 at 04:36:37PM -0400, Jody McIntyre wrote:
> On Tue, Jul 28, 2009 at 08:19:54PM -0400, Avery Pennarun wrote:
> > I believe this cache out-of-dateness issue was fixed in a recent version of
> > git.
> 
> I'll try that in the next few days and report back.

Git 1.6.4 fixes the issue, whatever it was.

Thanks!
Jody
