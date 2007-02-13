From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make gitk save and restore window pane position on Linux and Cygwin.
Date: Tue, 13 Feb 2007 09:45:11 -0800
Message-ID: <7vps8ex87s.fsf@assigned-by-dhcp.cox.net>
References: <11713259742627-git-send-email-mdl123@verizon.net>
	<7vbqjy7t86.fsf@assigned-by-dhcp.cox.net>
	<20070213111037.GM23550@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Tue Feb 13 18:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH1iQ-0007FN-7D
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 18:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbXBMRpN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 12:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbXBMRpN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 12:45:13 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:63562 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbXBMRpM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 12:45:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213174512.KOLL21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 12:45:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P5lB1W00G1kojtg0000000; Tue, 13 Feb 2007 12:45:11 -0500
In-Reply-To: <20070213111037.GM23550@master.mivlgu.local> (Sergey Vlasov's
	message of "Tue, 13 Feb 2007 14:10:37 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39554>

Sergey Vlasov <vsu@altlinux.ru> writes:

> On Mon, Feb 12, 2007 at 05:15:53PM -0800, Junio C Hamano wrote:
>> This looks sane to me, although a bit twisted (and again it is
>> not Mark's fault).  Sergey, Ack?
>
> Yes, current git (85b1f988) works for me.

Thanks, both.
