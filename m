From: Damien Robert <damien.olivier.robert+gmane@gmail.com>
Subject: Re: Our cumbersome mailing list workflow
Date: Fri, 28 Nov 2014 21:39:40 +0000 (UTC)
Message-ID: <m5aq2s$njj$1@ger.gmane.org>
References: <1416423000-4323-1-git-send-email-sbeller@google.com> <xmqq61e81ljq.fsf@gitster.dls.corp.google.com> <5473CD28.5020405@alum.mit.edu> <54776367.1010104@web.de> <54788743.5090703@alum.mit.edu> <547897F4.5000305@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 28 22:39:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuTGf-0007uF-CV
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 22:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbaK1Vjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 16:39:53 -0500
Received: from plane.gmane.org ([80.91.229.3]:44661 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbaK1Vjw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2014 16:39:52 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XuTGY-0007sF-ID
	for git@vger.kernel.org; Fri, 28 Nov 2014 22:39:50 +0100
Received: from quatramaran.salle-s.org ([188.165.201.225])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Nov 2014 22:39:50 +0100
Received: from damien.olivier.robert+gmane by quatramaran.salle-s.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Nov 2014 22:39:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: quatramaran.salle-s.org
X-Newsreader: Flrn (0.9.20070704)
X-Start-date: Fri, 28 Nov 2014 22:36:39 +0100 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260377>

> A bot could subscribe to the list and create branches in a public repo.
> (This idea feels familiar -- didn't somebody attempt this already?)

Thomas Rast maintains git notes that link git commits to their gmane
discussion, you can get them with

[remote "mailnotes"]
  url = git://github.com/trast/git.git
  fetch = refs/heads/notes/*:refs/notes/*

There is gmane branch and a message-id branch, its pretty usefull.
