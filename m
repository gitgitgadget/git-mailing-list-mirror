From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: how to check pending commits to be pushed?
Date: Thu, 28 Feb 2013 19:58:48 +0100
Message-ID: <kgo9d6$oru$1@ger.gmane.org>
References: <C89CA603-2D94-44DB-8576-A296BAB5DA53@linea.gov.br>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 19:59:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB8hf-0003Eh-5O
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 19:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933049Ab3B1S7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 13:59:14 -0500
Received: from plane.gmane.org ([80.91.229.3]:48859 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932104Ab3B1S7L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 13:59:11 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UB8hS-00032Y-73
	for git@vger.kernel.org; Thu, 28 Feb 2013 19:59:26 +0100
Received: from dsdf-4db54812.pool.mediaways.net ([77.181.72.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Feb 2013 19:59:26 +0100
Received: from jojo by dsdf-4db54812.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Feb 2013 19:59:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db54812.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217249>

Patricia Bittencourt Egeland wrote:
> Hi,
> 
>      Does someone know how to identify pending commits to be pushed
> in a local super repository (with quite some submodules), with
> git-1.6.5-1 ?  

git status ?

Bye, Jojo
