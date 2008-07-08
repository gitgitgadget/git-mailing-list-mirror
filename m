From: "James B. Byrne" <byrnejb@harte-lyne.ca>
Subject: [Fwd: Re: GiT and CentOS 5.2]
Date: Tue, 8 Jul 2008 14:51:21 -0400 (EDT)
Message-ID: <50493.216.185.71.22.1215543081.squirrel@webmail.harte-lyne.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 20:53:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGIJ5-000726-6Y
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 20:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbYGHSv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 14:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753060AbYGHSv4
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 14:51:56 -0400
Received: from inet06.hamilton.harte-lyne.ca ([216.185.71.26]:36596 "HELO
	inet06.hamilton.harte-lyne.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753869AbYGHSvz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2008 14:51:55 -0400
Received: from inet07.hamilton.harte-lyne.ca (inet07.hamilton.harte-lyne.ca [216.185.71.27])
	by inet06.hamilton.harte-lyne.ca (8.13.1/8.13.1) with ESMTP id m68IpsA8020226
	for <git@vger.kernel.org>; Tue, 8 Jul 2008 14:51:55 -0400
Received: from webmail.harte-lyne.ca (inet07.hamilton.harte-lyne.ca [216.185.71.27])
	by inet07.hamilton.harte-lyne.ca (8.13.1/8.13.1) with ESMTP id m68IpLQA010766
	for <git@vger.kernel.org>; Tue, 8 Jul 2008 14:51:21 -0400
Received: from 216.185.71.22
        (SquirrelMail authenticated user byrnejb)
        by webmail.harte-lyne.ca with HTTP;
        Tue, 8 Jul 2008 14:51:21 -0400 (EDT)
User-Agent: SquirrelMail/1.4.8-4.0.1.el4.centos
X-Priority: 3 (Normal)
Importance: Normal
X-Harte_and_Lyne_Limited-MailScanner-Information: For further information contact postmaster@harte-lyne.ca
X-Harte_and_Lyne_Limited-MailScanner-ID: m68IpLQA010766
X-Harte_and_Lyne_Limited-MailScanner: Checked by clamav and Found to be clean
X-Harte_and_Lyne_Limited-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=0.031, required 3,
	autolearn=not spam, AWL 0.03, SPF_PASS -0.00)
X-MailScanner-From: byrnejb@harte-lyne.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87784>



On Tue, July 8, 2008 14:37, Mike Hommey wrote:

>
> This only means the rpms in the yum repository at kernel.org were built
> on a system more recent than yours, and that run-time dependencies (as
> opposed to build dependencies) require some libraries to be newer than
> what your system provides.

I understand the meaning of the error messages.  What I am asking is
whether or not any of these dependencies is substantive.  If they are then
I am stuck at the immediately previous release of GiT. If not then I have
the option to either build from source or force an rpm update.  If I force
then I can no long use yum but at least I have the applicate managed by
rpm.  If I build from source then I lose that as well.

So, my question still remains: are these dependencies only artifacts of
the build environment or do they supply actual features that the latest
release of GiT depends upon and which are not available in the earlier
version of the software?

-- 
***          E-Mail is NOT a SECURE channel          ***
James B. Byrne                mailto:ByrneJB@Harte-Lyne.ca
Harte & Lyne Limited          http://www.harte-lyne.ca
9 Brockley Drive              vox: +1 905 561 1241
Hamilton, Ontario             fax: +1 905 561 0757
Canada  L8E 3C3


-- 
***          E-Mail is NOT a SECURE channel          ***
James B. Byrne                mailto:ByrneJB@Harte-Lyne.ca
Harte & Lyne Limited          http://www.harte-lyne.ca
9 Brockley Drive              vox: +1 905 561 1241
Hamilton, Ontario             fax: +1 905 561 0757
Canada  L8E 3C3
