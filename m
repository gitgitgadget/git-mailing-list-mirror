From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: [PATCH (GITK BUGFIX)] gitk: Allow safely calling nukefile from
 a run queue handler.
Date: Mon, 11 Aug 2008 03:02:38 +0200
Message-ID: <489F8FAE.2040201@jaeger.mine.nu>
References: <42d19ab224653b2e6988d7209a8d3e87e19858f8.1218207346.git.christian@jaeger.mine.nu> <200808091313.52528.angavrilov@gmail.com> <217ad8e755d8d51e2ec0f06b4bffa0864976f7e4.1218277122.git.christian@jaeger.mine.nu> <200808091441.50444.angavrilov@gmail.com> <489D7E67.5050205@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 03:03:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSLp2-0003Yq-17
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 03:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbYHKBCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 21:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbYHKBCl
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 21:02:41 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:52881 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752501AbYHKBCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 21:02:41 -0400
Received: (qmail 29397 invoked from network); 11 Aug 2008 01:02:38 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 11 Aug 2008 01:02:38 -0000
Received: (qmail 5515 invoked from network); 11 Aug 2008 01:02:38 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 11 Aug 2008 01:02:38 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <489D7E67.5050205@jaeger.mine.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91907>

I wrote:
> BTW here's a patch to your patch to make it apply on top of 1.6.0.rc2:

Note to self: how could I be so naive to assume Git didn't offer a 
solution to that. I've missed the -3 option to git am.

Christian.
