From: Andy Hawkins <andy@gently.org.uk>
Subject: Re: old folders returning
Date: Sat, 10 Nov 2012 17:41:51 +0000 (UTC)
Organization: Gently
Message-ID: <slrnk9t4ev.qhg.andy@atom.gently.org.uk>
References: <CAN4PrMavggqn3ZM1atde5CADjszzLOvPoQasjRZfUvRKrqS-uA@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 18:51:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXFDb-0004vk-8U
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 18:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347Ab2KJRsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 12:48:41 -0500
Received: from plane.gmane.org ([80.91.229.3]:60603 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233Ab2KJRsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 12:48:40 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TXFAl-0002no-4C
	for git@vger.kernel.org; Sat, 10 Nov 2012 18:48:47 +0100
Received: from cpc2-swin2-0-0-cust495.3-1.cable.virginmedia.com ([81.109.93.240])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 18:48:47 +0100
Received: from andy by cpc2-swin2-0-0-cust495.3-1.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 18:48:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpc2-swin2-0-0-cust495.3-1.cable.virginmedia.com
User-Agent: slrn/pre1.0.0-18 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209287>

Hi,

In article <CAN4PrMavggqn3ZM1atde5CADjszzLOvPoQasjRZfUvRKrqS-uA@mail.gmail.com>,
           David Coombes<webeire@gmail.com> wrote:
> The only suggestion I can think of is that the name wasn't cleared
> after the "git add *" and then git went looking for an earlier copy.
> But seems the issue is with the git client as well because of the
> modified time. If it were pulled then the modified time would've
> changed, so it must have been taken from an earlier commit on my local
> branch.

Did you git rm the 'old' name of the folder?

Andy
