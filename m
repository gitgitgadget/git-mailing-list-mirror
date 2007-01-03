From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix shortlog only showing HEAD revision.
Date: Wed, 03 Jan 2007 21:36:55 +0100
Organization: At home
Message-ID: <enh3v7$ji7$1@sea.gmane.org>
References: <459C0232.3090804@linuxtv.org> <20070103202555.GA25768@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 21:34:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2CoC-00026r-08
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 21:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbXACUd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 15:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbXACUd5
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 15:33:57 -0500
Received: from main.gmane.org ([80.91.229.2]:59994 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932094AbXACUd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 15:33:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H2Co0-0000EJ-Nz
	for git@vger.kernel.org; Wed, 03 Jan 2007 21:33:48 +0100
Received: from host-81-190-20-195.torun.mm.pl ([81.190.20.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 21:33:48 +0100
Received: from jnareb by host-81-190-20-195.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 21:33:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-195.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35890>

Robert Fitzsimons wrote:

> My change in 190d7fdcf325bb444fa806f09ebbb403a4ae4ee6 had a small bug
> found by Michael Krufky which caused the passed in hash value to be
> ignored, so shortlog would only show the HEAD revision.
> 
> Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

Identical change, better commit message (I think).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
