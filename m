From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH 12/12] [TODO] setup: bring changes from
 4msysgit/next to next
Date: Wed, 2 Jul 2008 17:17:10 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807021716030.9925@racer>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de>
 <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de> <1214987532-23640-9-git-send-email-prohaska@zib.de>
 <1214987532-23640-10-git-send-email-prohaska@zib.de> <1214987532-23640-11-git-send-email-prohaska@zib.de> <1214987532-23640-12-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
	Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Jul 02 18:20:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE53r-0003MZ-7m
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 18:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbYGBQTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 12:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755073AbYGBQTF
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 12:19:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:42587 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754693AbYGBQTE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 12:19:04 -0400
Received: (qmail invoked by alias); 02 Jul 2008 16:19:03 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp037) with SMTP; 02 Jul 2008 18:19:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ueCctAhJuqBsaq4SCS0SNodEKpZO8NlNc1qhyCi
	x5Oj+ssn2+8qtW
X-X-Sender: gene099@racer
In-Reply-To: <1214987532-23640-12-git-send-email-prohaska@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87155>

Hi,

On Wed, 2 Jul 2008, Steffen Prohaska wrote:

> 
> From: Johannes Sixt <johannes.sixt@telecom.at>
> 
> Hannes,
> You introduced "minoffset" in 861429a7c37c7.

AFAICT it was redone differently in 'next', because 'next' has this 
ceiling dir thingie, which allows a different (much smaller) patch.

It might be more sensible to base your patch series on 'next'...

Ciao,
Dscho
