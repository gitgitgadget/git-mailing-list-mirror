From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 12:06:19 -0600
Message-ID: <4990709B.90401@codeweavers.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net> <499058B4.4070009@beonex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Ben Bucksch <ben.bucksch.news@beonex.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:08:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWaYQ-0007CL-O9
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 19:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbZBISGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 13:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754693AbZBISGY
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 13:06:24 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:52319 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbZBISGX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 13:06:23 -0500
Received: from localhost
	([127.0.0.1] helo=[216.251.189.140] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LWaWT-0005AE-VH; Mon, 09 Feb 2009 12:06:21 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <499058B4.4070009@beonex.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109097>

> So, you first have to quote using HTML rules:
> <   -> &lt;
>  >   -> &gt;
> &   -> &amp;
> "   -> &quot;

Thanks; that was helpful.

I've sent an experimental patch for further discussion (I even sent it
using my patch + Thunderbird, and now I'm carefully studying my navel
<grin>).

Cheers,

Jeremy
