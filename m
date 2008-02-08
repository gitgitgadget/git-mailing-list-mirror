From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH (repost)] Improve bash prompt to detect merge / rebase in progress
Date: Fri, 8 Feb 2008 14:12:49 +0100
Message-ID: <E3983D26-5DAC-48CE-A261-7C424FCB2D64@zib.de>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com> <200802062314.39440.robin.rosenberg.lists@dewire.com> <7vodatu37m.fsf@gitster.siamese.dyndns.org> <200802070123.43109.robin.rosenberg.lists@dewire.com> <20080207063412.GQ24004@spearce.org> <F19A1227-3803-4C23-BEA2-26F23824ACF5@zib.de> <alpine.LSU.1.00.0802081224210.11591@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Stephen Sinclair <radarsat1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 14:14:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNT3z-0006xb-Ui
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 14:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567AbYBHNNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 08:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYBHNNp
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 08:13:45 -0500
Received: from mailer.zib.de ([130.73.108.11]:33071 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756632AbYBHNNY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 08:13:24 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m18DC2ES001757;
	Fri, 8 Feb 2008 14:12:02 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m18DBprL001129
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 8 Feb 2008 14:11:51 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0802081224210.11591@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73085>


On Feb 8, 2008, at 1:25 PM, Johannes Schindelin wrote:

> On Fri, 8 Feb 2008, Steffen Prohaska wrote:
>
>> This improved prompt is great.  I already miss it each time I switch
>> back from next to master.
>
> Maybe we (as in msysgit) should install the git-completion.bash script
> into /share/git-core/?

Yes.

	Steffen
