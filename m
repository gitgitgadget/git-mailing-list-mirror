From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Submodules or similar for exercise/exam management
Date: Mon, 22 Nov 2010 14:20:52 +0100
Message-ID: <201011221420.52872.trast@student.ethz.ch>
References: <201011181109.08345.trast@student.ethz.ch> <201011181636.oAIGaRxm021543@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Mon Nov 22 14:21:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKWKK-0005Ha-Kg
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 14:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab0KVNUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 08:20:54 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:29149 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754803Ab0KVNUy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 08:20:54 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 22 Nov
 2010 14:20:35 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 22 Nov
 2010 14:20:53 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-93-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <201011181636.oAIGaRxm021543@no.baka.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161889>

Seth Robertson wrote:
> git clone git@example.com/some/super/repo
> cd repo
> gits checkout master
> # time passes
> gits pull
> # work
> gits status
> gits diff
> gits commit -a -m 'one message fits none'
> # I am not familiar with the "git commit --no-push" option
> gits push

Thanks a lot for pointing that out!  I just did a few simple tests and
it looks like it's the tool for the job.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
