From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH][RFC] git on Mac OS and precomposed unicode
Date: Mon, 09 Jan 2012 17:42:00 +0100
Message-ID: <4F0B18D8.1010406@web.de>
References: <201201072059.23074.tboegi@web.de> <87vcomravs.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jan 09 17:48:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkIOL-0007Yq-8S
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 17:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427Ab2AIQsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 11:48:07 -0500
Received: from smtp-out11.han.skanova.net ([195.67.226.200]:56049 "EHLO
	smtp-out11.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932234Ab2AIQsG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 11:48:06 -0500
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jan 2012 11:48:05 EST
Received: from birne.lan (194.22.188.61) by smtp-out11.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4EFC3D3500314745; Mon, 9 Jan 2012 17:42:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <87vcomravs.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188179>

On 08.01.12 07:01, Miles Bader wrote:
> BTW, about the names, e.g. "darwin.c" etc -- is this code actually
> Darwin-specific, or simply Systems-that-happen-to-force-decomposed-
> unicode specific?
> 
> If the latter, maybe more generic names might be better.
> 
> Thanks,
> 
> -Miles
> 
As far as I know, Mac OS (darwin) is the only existing OS which likes
decomposed unicode so much, that forces decomposed unicode that way.
/Torsten


 
