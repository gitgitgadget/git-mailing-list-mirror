From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: Thunderbird and patches
Date: Mon, 09 Feb 2009 16:55:02 -0600
Message-ID: <4990B446.2070705@codeweavers.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <4990B086.10804@beonex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Ben Bucksch <ben.bucksch.news@beonex.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:56:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWf3J-0004MH-Tu
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 23:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbZBIWzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 17:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbZBIWzG
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 17:55:06 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:33892 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbZBIWzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 17:55:05 -0500
Received: from localhost
	([127.0.0.1] helo=[216.251.189.140] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LWf1s-0001M9-9m; Mon, 09 Feb 2009 16:55:04 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <4990B086.10804@beonex.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109157>

>     * I strong suggest to send inline attachments (Content-Disposition:
>       inline, RFC 2183 [1], Internet Standard), because patches are
>       arguably files, and the body is for human language text.
>       Therefore, it's an attachment that you want to see inline,
>       therefore inline attachment is the IMHO correct solution.
>       If some mailers cannot handle this comfortably (display inline,
>       quote), maybe you can also advocate having *them* fixed.


So, I start an email in Thunderbird, and attach test.patch to it.
I don't see a way to control things, but it seems to go across as
a multipart; the patch is disposition inline, type of text/x-patch.  I
rename it to test.txt, and now it goes across as a multipart, both parts
are text/plain.

I get the patch, and I can see it.  Very nice.

I click 'Reply', and I get no quoting in Thunderbird.  (A quick check
with mutt *does* show quoting.)

I'm hazarding a guess that is not the expected result; am I doing it wrong?

Cheers,

Jeremy
