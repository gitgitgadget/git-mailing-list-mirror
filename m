From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] mergetool: add support for ECMerge
Date: Tue, 9 Oct 2007 15:17:24 +0200
Message-ID: <236E44B5-361E-4CE3-8C3D-BDAD0569642E@zib.de>
References: <11918785613855-git-send-email-prohaska@zib.de> <11918785611059-git-send-email-prohaska@zib.de> <20071008214451.GB31713@thunk.org> <1C50C046-3D61-4D55-8D38-B2D563C1FF2A@zib.de> <Pine.LNX.4.64.0710091335580.4174@racer.site> <2b3a6fcd0710090603l3c3578caq3bfa6a1b8ec583f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Theodore Tso <tytso@mit.edu>, Alan Hadsell <ahadsell@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 15:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEwQ-0000BY-ED
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 15:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbXJINP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 09:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbXJINP5
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 09:15:57 -0400
Received: from mailer.zib.de ([130.73.108.11]:49010 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbXJINP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 09:15:57 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l99DFqqa016953;
	Tue, 9 Oct 2007 15:15:52 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l99DFqH3000162
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 9 Oct 2007 15:15:52 +0200 (MEST)
In-Reply-To: <2b3a6fcd0710090603l3c3578caq3bfa6a1b8ec583f@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60407>


On Oct 9, 2007, at 3:03 PM, Alan Hadsell wrote:

> On 10/9/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
>> What does TortoiseCVS use?
>
> They don't actually include it in the package, but they recommend
> WinMerge http://winmerge.org/, which is free (GPL).

WinMerge doesn't support 3-way merges. At least I cannot find any
indication for 3-way in the manual [1] and the comparison at [2] also
tells that WinMerge doesn't support 3-way.

	Steffen

[1] http://winmerge.org/2.6/manual/CompareFiles.html
[2] http://en.wikipedia.org/wiki/Comparison_of_file_comparison_tools
