From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 08:17:25 +0200
Message-ID: <C1BDE454-BA17-4421-9877-7D97811979EC@zib.de>
References: <Pine.LNX.4.64.0710142112540.25221@racer.site> <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home> <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site> <4713BA89.633B86F2@dessent.net> <20071015194214.GC15541@steel.home> <4713C81F.A75FEFC2@dessent.net> <Pine.LNX.4.64.0710152117290.25221@racer.site> <7287AD62-3274-4B20-881C-D02E08C4B2EF@zib.de> <fcaeb9bf0710151924r258dd561hd13c22319d17f80f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Alex Riesen" <raa.lkml@gmail.com>, "Eli Zaretskii" <eliz@gnu.org>,
	"Andreas Ericsson" <ae@op5.se>, tsuna@lrde.epita.fr,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:16:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihfj3-00020D-4q
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 08:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbXJPGQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 02:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbXJPGQJ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 02:16:09 -0400
Received: from mailer.zib.de ([130.73.108.11]:53407 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbXJPGQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 02:16:07 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9G6G15G014541;
	Tue, 16 Oct 2007 08:16:01 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1b21a.pool.einsundeins.de [77.177.178.26])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9G6FsoR008763
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 16 Oct 2007 08:15:55 +0200 (MEST)
In-Reply-To: <fcaeb9bf0710151924r258dd561hd13c22319d17f80f@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61088>


On Oct 16, 2007, at 4:24 AM, Nguyen Thai Ngoc Duy wrote:

> On 10/16/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>
>> On Oct 15, 2007, at 10:19 PM, Johannes Schindelin wrote:
>>> There is a port of BusyBox' dash, which is nearing completion.  Once
>>> Nguyen says it is ready enough, we will try to integrate it into
>>> msysGit.
>>
>> Gnuarch [1] recommends zsh from the unxutils project [2].
>
> All zsh links in [2] are dead. I did try hard to find the legendary
> zsh for Windows before giving up and porting busybox's ash instead. If
> you have zsh source of the port, please send me. Thank you.

It is included in UnxUtilsSrc.zip, updated on 2007-03-01 06:22, from

http://sourceforge.net/projects/unxutils
http://sourceforge.net/project/showfiles.php?group_id=9328

	Steffen
