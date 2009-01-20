From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Jan 2009, #04; Mon, 19)
Date: Tue, 20 Jan 2009 08:55:19 +0100
Message-ID: <49758367.7040706@viscovery.net>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <20090120044021.GE30714@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 08:57:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPBU1-0007MD-Ju
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 08:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbZATHze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 02:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbZATHzd
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 02:55:33 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38406 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbZATHzb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 02:55:31 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LPBSG-0006c2-CI; Tue, 20 Jan 2009 08:55:25 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 972ACA865; Tue, 20 Jan 2009 08:55:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20090120044021.GE30714@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106453>

Jeff King schrieb:
>   - the test needs a few tweaks to be portable to Windows

While this is true, the workaround I have in my tree is so ugly that its
discussion would hold back this series unnecessarily. So, please don't
wait for the fixup of the test.

[My intention is to send test suite fixups for Windows as a separate
series, which would include the fixup for this case, too.]

-- Hannes
