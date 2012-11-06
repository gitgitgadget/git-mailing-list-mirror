From: Damien Robert <damien.olivier.robert+gmane@gmail.com>
Subject: Re: git ls-files --ignored and ignored directory
Date: Tue, 6 Nov 2012 21:24:45 +0000 (UTC)
Message-ID: <k7bv6s$ujm$1@ger.gmane.org>
References: <k7bus9$o9t$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 22:25:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVqee-00065b-Hw
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 22:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab2KFVY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 16:24:59 -0500
Received: from plane.gmane.org ([80.91.229.3]:34611 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab2KFVY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 16:24:58 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TVqds-0005dy-TV
	for git@vger.kernel.org; Tue, 06 Nov 2012 22:25:04 +0100
Received: from phare.normalesup.org ([129.199.129.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 22:25:04 +0100
Received: from damien.olivier.robert+gmane by phare.normalesup.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 22:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: phare.normalesup.org
X-Newsreader: Flrn (0.9.20070704)
X-Start-date: Tue, 06 Nov 2012 22:24:03 +0100 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209123>

Damien Robert  wrote in message <k7bus9$o9t$1@ger.gmane.org>:
> I would like to use git ls-files to show all the ignored files, including
> directory.
> Is there a way to get the behavior I'd like? Thanks!

I forgot to add that this is with version 1.8.0, I haven't tried with
current master.

$ git --version
git version 1.8.0
