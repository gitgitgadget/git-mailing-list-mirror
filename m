From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Other compression?, was Re: [PATCH] Add --no-reuse-delta option
 to git-gc
Date: Wed, 9 May 2007 13:35:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091333570.4167@racer.site>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu>
 <11786309071033-git-send-email-tytso@mit.edu> <Pine.LNX.4.64.0705090056231.18541@iabervon.org>
 <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net> <46418E24.9020309@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed May 09 13:35:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlkRu-0003gJ-Hm
	for gcvg-git@gmane.org; Wed, 09 May 2007 13:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbXEILfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 07:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbXEILfE
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 07:35:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:51350 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751652AbXEILfC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 07:35:02 -0400
Received: (qmail invoked by alias); 09 May 2007 11:35:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 09 May 2007 13:35:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uZkAIE15ubmlZW6eIE/gP+1JRLw4q4zWejFPKTB
	wiF9+caDM8hXJC
X-X-Sender: gene099@racer.site
In-Reply-To: <46418E24.9020309@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46698>

Hi,

On Wed, 9 May 2007, Steven Grimm wrote:

> On that note, has any thought been given to looking at other compression
> algorithms?

I think you could do that. But you would lose compatibility with all 
existing Git clients. IOW nobody could pull from you.

Ciao,
Dscho
