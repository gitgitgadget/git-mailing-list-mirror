From: Ben Bucksch <ben.bucksch.news@beonex.com>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 23:46:34 +0100
Organization: Beonex
Message-ID: <4990B24A.4000801@beonex.com>
References: <498E50E2.8050309@codeweavers.com> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net> <499058B4.4070009@beonex.com> <qXxPO6LuQr7-9QoWMdojOMbuADIJ55oaOVr5t_8eLGR9vvNpW72wyA@cipher.nrlssc.navy.mil> <49907F75.2050100@beonex.com> <alpine.DEB.1.00.0902092013260.10279@pacific.mpi-cbg.de> <4990820B.504@beonex.com> <r57oMSnamWCJ1G1-r98G6mYQjX0YNpQz1OzEBHSrDifmBU_ir2P77A@cipher.nrlssc.navy.mil> <49908927.2030408@beonex.com> <49908B1A.7040101@beonex.com> <kCHkjagMqmrTXbd229odxLGt0neIkfVZDCJPnhpXGVU71q9GcXEmPw@cipher.nrlssc.navy.mil> <4990A7D6.5090709@beonex.com> <1quO9vKdveU3
 UD9xhBB6YkuoBUyUsLvXylSjOkZKRByKfUxgId9fwQ@cipher.nrlssc.navy.mil> <4990AD62.1030102@beonex.com> <LPqf-HWrLRqzpr9F2D3QXUFfkpclYxx-y3jCNxZ6UAc@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeremy White <jwhite@codeweavers.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:48:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWevk-0001Xd-53
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 23:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbZBIWrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 17:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbZBIWrR
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 17:47:17 -0500
Received: from mail.server.beonex.com ([78.46.195.11]:43670 "EHLO
	mail.server.beonex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbZBIWrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 17:47:16 -0500
Received: from [10.1.1.3] (localhost [127.0.0.1])
	by mail.server.beonex.com (Postfix) with ESMTP id D9999303C560;
	Mon,  9 Feb 2009 23:47:24 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2a1pre) Gecko/20081217 Shredder/3.0b2pre
In-Reply-To: <LPqf-HWrLRqzpr9F2D3QXUFfkpclYxx-y3jCNxZ6UAc@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109155>

On 09.02.2009 23:28, Brandon Casey wrote:
> But it's the latter one that gives me the *correct* results. :b
>    
Oh. As I showed, File | Save As... in normal msg viewer works here.
When I save in View Source, the file is different, and diff -u shows 
every line different, and diff -uw shows no difference. Therefore, I 
think it's the line ending.

FWIW, I'm on Linux, in case TB adapts to the system line ending in one 
case and not in the other, which may explain the difference between what 
we see.

/me just realizes that he's talking with the military.
