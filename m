From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Re: [PATCH 09/11] Add MSVC porting header files.
Date: Mon, 17 Aug 2009 22:07:03 +0200
Message-ID: <200908172207.03446.j6t@kdbg.org>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302> <3af572ac0908171231n30864c85ud67454a03ca08fbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 22:07:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md8UA-0001JC-36
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 22:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757704AbZHQUHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 16:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757046AbZHQUHG
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 16:07:06 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:41736 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755857AbZHQUHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 16:07:05 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2FFD5A7EB0;
	Mon, 17 Aug 2009 22:07:03 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8909642752;
	Mon, 17 Aug 2009 22:07:03 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <3af572ac0908171231n30864c85ud67454a03ca08fbe@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126269>

On Montag, 17. August 2009, Pau Garcia i Quiles wrote:
> What about having a CMake build system, ...

No, thank you. I have to use it for the little bit of KDE development that I 
do, and it is a horror. With autotools I at least was able to reuse my shell 
programming skills, but cmake is an entirely new language, and an absolutely 
horrible one (IMHO, of course).

-- Hannes
