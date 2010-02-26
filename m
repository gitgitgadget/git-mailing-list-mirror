From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git as an sfc member project
Date: Fri, 26 Feb 2010 13:14:27 +0000
Message-ID: <2b203beb1823fe320af0c8a520a7818d@212.159.54.234>
References: <20100224154452.GA25872@coredump.intra.peff.net> <20100226125916.GA12650@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 14:14:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl01d-0001HO-PO
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 14:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936188Ab0BZNOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 08:14:32 -0500
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:52537 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936095Ab0BZNOb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 08:14:31 -0500
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id A81A9819C172;
	Fri, 26 Feb 2010 13:14:29 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 7856710F893;
	Fri, 26 Feb 2010 13:14:29 +0000 (GMT)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MW-Wt4TbrtuH; Fri, 26 Feb 2010 13:14:29 +0000 (GMT)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 5126F10F869;
	Fri, 26 Feb 2010 13:14:27 +0000 (GMT)
In-Reply-To: <20100226125916.GA12650@coredump.intra.peff.net>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141130>

On Fri, 26 Feb 2010 07:59:16 -0500, Jeff King <peff@peff.net> wrote:
>>    * Names, email addresses, and affiliations of key developers, past
and
>>      present.
> 
> Junio C Hamano <gitster@pobox.com>
> (Part of Junio's git time used to be funded jointly by his employer and
> NEC, but the latter is not anymore.)
> 
> Shawn O. Pearce <spearce@spearce.org>
> (Google employee, Eclipse Foundation project committer, Apache Software
> Foundation project committer)
> 
> Linus Torvalds <torvalds@linux-foundation.org>
> [Linux Foundation?]
> 
> Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Eric Wong <normalperson@yhbt.net>
> Jeff King <peff@peff.net>
> Jakub Narebski <jnareb@gmail.com>
> Nicolas Pitre <nico@fluxnic.net>
> Paul Mackerras <paulus@samba.org>
> Johannes Sixt <j6t@kdbg.org>
> Robin Rosenberg <robin.rosenberg@dewire.com>
> 
> [I'm still not happy with this list. For example, Pasky was certainly a
> key person (and while he is not too active lately, it does say "past and
> present"). But this list is already getting long, and if they really
> care they can run shortlog themselves. I am tempted to cut it off after
> Dscho, where there is a big jump in the number of commits:
> 
>   $ git shortlog -ns v1.7.0
>   7689  Junio C Hamano
>   1356  Shawn O. Pearce
>   1092  Linus Torvalds
>    710  Johannes Schindelin
>    459  Eric Wong
>    432  Jeff King
>    395  Jakub Narebski
>    327  Nicolas Pitre
>    322  Paul Mackerras
>    272  Johannes Sixt
> 
> Maybe a note saying the development is very distributed and that they
> should look at the repo for full details?]

You could mention that a more complete list of developers is available at
http://www.git-scm.com/about at the bottom of the page?

-- 
Julian
