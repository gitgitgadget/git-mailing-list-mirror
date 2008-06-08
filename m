From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH v2] git-commit.txt: Correct option alternatives
Date: Sat, 07 Jun 2008 20:36:54 -0500
Message-ID: <484B37B6.1040408@freescale.com>
References: <200806070534.45761.chriscool@tuxfamily.org> <1212836805-20684-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jun 08 03:39:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K59sQ-0000fN-T5
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 03:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397AbYFHBia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 21:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756408AbYFHBia
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 21:38:30 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:52106 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349AbYFHBi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 21:38:29 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m581boAB016483;
	Sat, 7 Jun 2008 18:37:56 -0700 (MST)
Received: from [10.214.73.204] (mvp-10-214-73-204.am.freescale.net [10.214.73.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m581bn2h010703;
	Sat, 7 Jun 2008 20:37:49 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1212836805-20684-1-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84247>

Stephan Beyer wrote:
> This patch fixes the SYNOPSIS in git-commit.txt:
>  * --amend is not an alternative option to -c/-C/-F/-m
>  * -m and -F are not alternative options to -c/-C,
>    because you can reuse authorship from a commit (-c/-C)
>    but change the message (-m/-F).
> 
> Furthermore, for long-option consistency --author <author>
> is changed to --author=<author>.
> 
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>


> ---author <author>::
> +--author=<author>::
>  	Override the author name used in the commit.  Use
>  	`A U Thor <author@example.com>` format.
>  

Hey Junio,

Say, if we were to document and espouse one form over the other,
which would you recommend or prefer?

jdl
