From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Handle branch names with slashes
Date: Fri, 17 Feb 2006 09:47:21 +0000
Message-ID: <tnxbqx6z592.fsf@arm.com>
References: <20060214173509.GA8666@diana.vm.bytemark.co.uk>
	<20060217014117.12525.21330.stgit@backpacker.hemma.treskal.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 10:48:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA2DQ-0004on-GG
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 10:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWBQJrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 17 Feb 2006 04:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161172AbWBQJrt
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 04:47:49 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:48824 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1161174AbWBQJrs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 04:47:48 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k1H9lQ6s017095;
	Fri, 17 Feb 2006 09:47:26 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 17 Feb 2006 09:47:25 +0000
To: =?iso-8859-1?q?Karl_Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060217014117.12525.21330.stgit@backpacker.hemma.treskal.com> (
 =?iso-8859-1?q?Karl_Hasselstr=F6m's_message_of?= "Fri, 17 Feb 2006 02:41:17
 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 17 Feb 2006 09:47:25.0838 (UTC) FILETIME=[287B92E0:01C633A7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16333>

Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Let StGIT grok branch names with slashes in them. It used to fall fla=
t
> on its face when confronted with them.

Thanks for the patches you sent. I'll have a look at them tomorrow.

As a side note, for future patches, could you please use my
catalin.marinas@gmail.com address instead of the company one? I
maintain StGIT outside the working hours and it's much easier to grab
them from my personal address.

Thanks,

--=20
Catalin
